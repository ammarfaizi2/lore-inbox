Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbTAQOeJ>; Fri, 17 Jan 2003 09:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbTAQOeJ>; Fri, 17 Jan 2003 09:34:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3859 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267498AbTAQOeI>; Fri, 17 Jan 2003 09:34:08 -0500
Date: Fri, 17 Jan 2003 09:40:31 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jim Houston <jim.houston@attbi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE OnTrack remap for 2.5.58
In-Reply-To: <200301161814.h0GIEbb02258@linux.local>
Message-ID: <Pine.LNX.3.96.1030117093447.10871B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Jim Houston wrote:

> I'm running a Seagate 80 GB disk in an old Pentium Pro dual processor.
> I installed the current Redhat (phoebe) beta, and it works fine until
> I try to boot a 2.5.58 kernel.  It fails to mount the root disk because
> the disk has been setup with OnTrack remaping.  I didn't do anything
> to ask for this remapping.  Perhaps Seagate is shipping with this pre-
> installed?

Interesting if they are, but probably too late to determine. In any case
you *might* be able to clean it up with the extended menu geometry stuff
in fdisk. You might be able to go into the BIOS and tell it to use LBA,
although you might also lose what's on the drive that way.

> I went back and looked through the patches and found that the remapping
> support was removed in patch-2.5.30.  The comments in the mailing list
> suggest that it belonged in user space.  I have not found code/instructions
> on how to do this.  Since then, most of IDE code has been reverted to the
> 2.4 versions but not this bit.

I suspect that this will not go back in the mainline kernel, although the
"best done in user space" comment made by someone is a bit of a challenge
when you need it in place to get the system booted... Best avoid needing
it if you can.

I saved the patch, some of the local users might have ned of it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

