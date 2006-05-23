Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWEWLMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWEWLMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 07:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWEWLMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 07:12:08 -0400
Received: from ns.suse.de ([195.135.220.2]:37863 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750879AbWEWLMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 07:12:07 -0400
From: Neil Brown <neilb@suse.de>
To: "Rainer Shiz" <rainer.shiz@gmail.com>
Date: Tue, 23 May 2006 21:11:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17522.60908.335242.982796@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID Sync Speeds
In-Reply-To: message from Rainer Shiz on Tuesday May 23
References: <cf5433040605220605t22b6030j701add7d494c83e8@mail.gmail.com>
	<17522.15942.232530.954548@cse.unsw.edu.au>
	<cf5433040605230037h42d36b60k37e1f7fd576688f9@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 23, rainer.shiz@gmail.com wrote:
> Thanks Neil and Chris for your quick replies.
> 
> Neil, well when you say 'detectable activity' what do you exactly
> refer to.

It should mean any IO request to any of the physical devices, whether
though the raid array or otherwise.  Sometimes in can get confused,
but in 2.6.12 (If it a kernel.org 2.6.12) got it pretty right I
think.  Current kernels may have occasional issues that I really need
to sort out one day...

Maybe if you give me more precise details about your setup 
(e.g. cat /proc/mdstat) something might occur to me.

> I heard that speed values are averaged out for about 5 minutes or so.

They are averaged over 30 seconds.

> 
> One more question while I am at it, if a RAID Set is newly created and
> syncing, and now I change the /proc/sys/dev/raid/speed_limit_min and
> max values will this reflect on new RAID Sets that are created henceforth
> or even the existing RAID Sets which are being synced currently?

These numbers apply globally to all arrays, and can be changed at any
time.
More recent kernels have similar numbers in /sys/block/mdX/md/..
which allow the same settings to be applied to individual arrays.

> 
> And yes, I am too using Seagate hard drives. Does mixing up of
> hard drives (vendors) affect this sync process.? (I presume not but please
> correct me if I am wrong).

Mixing things shouldn't have an unexpected effect.  Obviously the
total speed will be limited by the slowest device, but no other
effects that I can thing of.  Certainly not what you are experiencing.

NeilBrown
