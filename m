Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVIUANb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVIUANb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVIUANb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:13:31 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:14220 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750801AbVIUANa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:13:30 -0400
Message-ID: <4330A5A5.3050408@namesys.com>
Date: Tue, 20 Sep 2005 17:13:25 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>, vitaly@thebsh.namesys.com
CC: Pavel Machek <pavel@suse.cz>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <20050921000425.GF6179@thunk.org>
In-Reply-To: <20050921000425.GF6179@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ted, I'll ask Vitaly to read the paper, and tell us what he
thinks should be learned from it for V4.

Hans

Theodore Ts'o wrote:

>On Tue, Sep 20, 2005 at 09:51:33AM +0200, Pavel Machek wrote:
>  
>
>>Do you have working fsck for V4? Until then, you should not claim that
>>users should switch. Journalling does not help you, if you have
>>unexpected kernel problem or hardware trouble, fsck _is_ mandatory.
>>
>>Can V4 survive few hours of test below?
>>    
>>
>
>The script could be improved by select random locations to damage the
>filesystem, instead of hard-coding the seek=7 value.  Seek=7 is good
>for testing ext2/ext3 filesystems, but it may not be ideal for other
>filesystems.
>
>Another interesting refinement would be to analyze the resulting
>filesystem after it has been repaired to determine how much data could
>be salvaged by the fsck program.   
>
>There is a very interesting paper that I coincidentally just came
>across today that talks about making filesystems robust against
>various different forms of failures of modern disk systems.  It is
>going to be presented at the upcoming 2005 SOSP conference.
>
>	http://www.cs.wisc.edu/adsl/Publications/iron-sosp05.pdf
>
>It's definitely worth a read.  A few comments about it; first of all,
>I know nothing about this modified "iron ext3" (ixt3) discussed in the
>paper aside from what's the paper itself.  It would be interesting to
>see what they have done with it.  Secondly, I _think_ sct has already
>fixed the problems discussed in the paper with respect to inadequate
>write squelching after an I/O failure writing to the ext3 journal, but
>we need to chat with the paper's authors to confirm that, and if there
>still is a problem, obviously we need to fix it.  Third of all, I'll
>note that the paper does takes an approving note of the fact that
>Reiserfs (v3) always panic's when it detects a write fault, so for
>those folks in the Reiser team who might have a persecution complex,
>relax, the whole world isn't out to get you.  :-)
>
>						- Ted
>
>
>  
>

