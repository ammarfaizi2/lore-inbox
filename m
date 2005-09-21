Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVIUBP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVIUBP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVIUBP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:15:58 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:57180 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S932093AbVIUBP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:15:58 -0400
Message-ID: <4330B428.90405@emc.com>
Date: Tue, 20 Sep 2005 21:15:20 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gmaxwell@gmail.com
CC: "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@suse.cz>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>	 <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>	 <20050921000425.GF6179@thunk.org> <e692861c05092018017ceef484@mail.gmail.com>
In-Reply-To: <e692861c05092018017ceef484@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.20.33
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:
> On 9/20/05, Theodore Ts'o <tytso@mit.edu> wrote:
> 
>>There is a very interesting paper that I coincidentally just came
>>across today that talks about making filesystems robust against
>>various different forms of failures of modern disk systems.  It is
>>going to be presented at the upcoming 2005 SOSP conference.
>>
>>        http://www.cs.wisc.edu/adsl/Publications/iron-sosp05.pdf
> 
> 
> Very interesting indeed, although it almost seems silly to tackle the
> difficult problem of making filesystems highly robust against oddball
> failure modes while our RAID subsystem falls horribly on it's face in
> the fairly common (and conceptually easy to handle) failure mode of a
> raid-5 where two disks have single unreadable blocks on differing
> parts of the disk. (the current raid system hits one bad block, fails
> the whole disk, then you attempt a rebuild and while reading hits the
> other bad block and downs the array).

I don't have any problem with fixing RAID code, but I would not describe 
the errors in this paper as oddball.  Believe me, we see a lot of disk 
issues and these are real examples of failures that happen to real file 
systems ;-)

Ric

