Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVB1PYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVB1PYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVB1PYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:24:32 -0500
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:52965 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261642AbVB1PY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:24:27 -0500
Message-ID: <42233772.7020409@structurenet.com>
Date: Mon, 28 Feb 2005 10:23:30 -0500
From: "Benjamin L. Shi" <benjamin.shi@structurenet.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Bernd Schubert <bernd-schubert@gmx.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swapper: page allocation failure. order:1, mode:0x20
References: <fa.hgi75u0.1cnmhaa@ifi.uio.no>
In-Reply-To: <fa.hgi75u0.1cnmhaa@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen these, by adding the following tueables resolved the problem. 
More specifically, the lower zone protection made the difference.

vm.vfs_cache_pressure=1000
vm.lower_zone_protection=100
vm.max_map_count = 32668
vm.min_free_kbytes = 10000


Bernd Schubert wrote:
> Oh no, not this page allocation problems again. In summer I already pos=
> ted 
> problems with page allocation errors with 2.6.7, but to me it seemed th=
> at 
> nobody cared. That time we got those problems every morning during the =
> cron 
> jobs and our main file server always completely crashed.
> This time its our cluster master system and first happend after an upti=
> me 
> of 89 days, kernel is 2.6.9. Besides of those messages, the system stil=
> l 
> seems to run stable
> 
> I really beg for help here, so please please please help me solving thi=
> s 
> probem. What can I do to solve it?
> 
> First a (dumb) question, what does 'page allocation failure' really m=
> ean? 
> Is it some out of memory case?
> 
> 
> Thanks a lot in advance for any help,
>  Bernd

