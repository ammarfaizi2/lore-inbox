Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263426AbRFAJAC>; Fri, 1 Jun 2001 05:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbRFAI7w>; Fri, 1 Jun 2001 04:59:52 -0400
Received: from [199.183.24.200] ([199.183.24.200]:10639 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263426AbRFAI7n>; Fri, 1 Jun 2001 04:59:43 -0400
Date: Fri, 1 Jun 2001 04:58:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106010858.f518w4c18391@devserv.devel.redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real  this time)
In-Reply-To: <mailman.991383180.28261.linux-kernel2news@redhat.com>
In-Reply-To: <3B17025B.E5E23095@sun.com> <mailman.991383180.28261.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But, each time a user cats this proc file, the user is banging the
> hardware.  What happens when a malicious user forks off 100 processes to
> continually cat this file?  :)

Nothing good, probably. Same story as /proc/apm, which only
hits BIOS instead (and it's debateable what is better).

> Security: don't you want CAP_RAW_IO or something before executing any of
> these ioctls?

Perhaps it's mode 600 in their distro...

> bug: you can't hold a spinlock while you are sleeping in copy_from_user

Yep... I meant to check for it but forgot.

-- Pete
