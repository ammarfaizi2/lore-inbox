Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWBKRbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWBKRbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 12:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWBKRbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 12:31:15 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:37640 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932340AbWBKRbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 12:31:15 -0500
Message-ID: <43EE1EDE.6040809@sw.ru>
Date: Sat, 11 Feb 2006 20:29:02 +0300
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: devel@openvz.org, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       frankeh@watson.ibm.com, Andrey Savochkin <saw@sawoct.com>,
       Rik van Riel <riel@redhat.com>, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Pavel Machek <pavel@ucw.cz>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       serue@us.ibm.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
Subject: Re: [Devel] Re: swsusp done by migration (was Re: [RFC][PATCH 1/5]
 Virtualization/containers: startup)
References: <43E38BD1.4070707@openvz.org>	 <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>	<43E3915A.2080000@sw.ru>	 <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>	 <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>	 <m1hd7condi.fsf@ebiederm.dsl.xmission.com>	 <1139243874.6189.71.camel@localhost.localdomain>	 <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>	<20060208215412.GD2353@ucw.cz>	 <m1mzh02y3m.fsf@ebiederm.dsl.xmission.com>	 <7CCC1159-BF55-4961-BC24-A759F893D43F@mac.com>	 <43EC170C.6090807@vilain.net>  <43EC317C.9090101@sw.ru> <1139625499.12123.41.camel@localhost.localdomain>
In-Reply-To: <1139625499.12123.41.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> On Fri, 2006-02-10 at 09:23 +0300, Vasily Averin wrote:
>>>Yeah.  If you fudged/virtualised /dev/random, the system clock, etc you
>>>could even have Tandem-style transparent High Availability.
>>></more wishful thinking>
>>Could you please explain, why you want to virtualize /dev/random?
> 
> When checkpointing it is important to preserve all state.  If you are
> doing transparent highly available computing, you need to make sure all
> system calls get the same answers in the clones.  So you would need to
> virtualise the entropy pool.

>From my point of view it is important to preserve only all the determinated state.

Ok, lets we've checkpointed and saved current entropy pool. But we have not any
guarantee that pool will be in the same state at the moment of first access to
it after wakeuping. Because a new entropy can change it unpredictable.

Am I right?

Thank you,
	Vasily Averin

Virtuozzo Linux kernel Team
