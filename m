Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271892AbRIJWJv>; Mon, 10 Sep 2001 18:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271966AbRIJWJk>; Mon, 10 Sep 2001 18:09:40 -0400
Received: from s340-modem2375.dial.xs4all.nl ([194.109.169.71]:58033 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S271892AbRIJWJa>;
	Mon, 10 Sep 2001 18:09:30 -0400
Date: Mon, 10 Sep 2001 23:29:44 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Robert Love <rml@tech9.net>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Feedback on preemptible kernel patch
In-Reply-To: <1000098594.18895.1.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109102323450.24212-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On 10 Sep 2001, Robert Love wrote:

> On Sun, 2001-09-09 at 23:24, Daniel Phillips wrote:
> > This may not be your fault.  It's a GFP_NOFS recursive allocation - this
> > comes either from grow_buffers or ReiserFS, probably the former.  In
> > either case, it means we ran completely out of free pages, even though
> > the caller is willing to wait.  Hmm.  It smells like a loophole in vm
> > scanning.
>
> I am not a VM hacker -- can you tell me where to start? what do you
> suspect it is?
>
> If the user stops seeing the error with preemption disabled, is your
> theory nulled, or does that just mean the problem is agitated by
> preemption?
>
> I don't think Arjan was using ReiserFS, so its from grow_buffers...

Yes I am using reiserfs (for "ages"). better said, reiser on LVM.

Small discription of my system and used setup:
scsi-disk,scsi-cdrom,ide-disk,ide-scsi,ext2,reiser, iptables, ipv6,
acenic-Gbit-ethernet, ramdisk, highmem (1.5GB-ram), Athlon 1.1GHz, Asus
a7v MB (via).


 Greatings,


>
> I appreciate your help.
>
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

