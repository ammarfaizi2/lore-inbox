Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280686AbRKYEUX>; Sat, 24 Nov 2001 23:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280703AbRKYEUN>; Sat, 24 Nov 2001 23:20:13 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:50939 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280686AbRKYEUJ>; Sat, 24 Nov 2001 23:20:09 -0500
Date: Sat, 24 Nov 2001 23:20:08 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200111250420.fAP4K8724540@devserv.devel.redhat.com>
To: satch@concentric.net, linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <mailman.1006644421.6553.linux-kernel2news@redhat.com>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011124103642.A32278@vega.ipal.net> <20011124184119.C12133@emma1.emma.line.org> <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de> <mailman.1006644421.6553.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> It is the responsibility of the power monitor to detect a power-fail event 
> and tell the drive(s) that a power-fail event is occurring.

> Most power supplies are not designed to hold up for more than 30-60 ms at 
> full load upon removal of mains power.  Power-fail detect typically 
> requires 12 ms (three-quarters cycle average at 60 Hz) or 15 ms 
> (three-quarters cycle average at 50 Hz) to detect that mains power has 
> failed, leaving your system a very short time to abort that long queue of 
> disk write commands.

This is a total crap argument, because you invent an impossible
request, pretend that your opponent made that request, then show
that it's impossible to fulfill the impossible requesti. No shit,
sherlock! Of course it's "a very short time to abort that long
queue of disk write commands".

However, what is asked here is entirely different: disks must
complete writes of sectors that they started writing, this is all.
They do not need to report _anything_ to the host, in fact they
may ignore the host interface completely the moment the power
failure sequence is triggered. Neither they need to do anything
about queued commands: abort them, discard in any way, or whatever.
Just complete the sector, and start head landing sequence.

IBM Deskstar is completely broken, and that's a fact.

BTW, hpa went on how he was buying IBM drives, how good they were,
and what a surprise it was that IBM fucked Deskstar. Hardly a
surprise. The first time I heard of IBM drive was a horror story.
Our company was making RAID arrays, and we sourced new IBM SCSI disks.
They were qualified through a rigorous testing as it was the
procedure in the company. So, after a while they started to fail.
It turned out that bearings leaked grease to platters. Of course,
we shipped tens of thousands of those when IBM explained to us
that every one of them will die in a year. We shipped Seagates
ever after.

-- Pete
