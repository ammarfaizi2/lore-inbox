Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132519AbRDAQZL>; Sun, 1 Apr 2001 12:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDAQZC>; Sun, 1 Apr 2001 12:25:02 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:42450 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S132519AbRDAQY6>; Sun, 1 Apr 2001 12:24:58 -0400
Date: Sun, 1 Apr 2001 18:22:07 +0200 (MEST)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Subject: scsi bus numbering
Message-ID: <Pine.LNX.4.30.0104011729320.2224-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some reason, the order of initializing the scsi drivers
changed between 2.4.2 and 2.4.3: If both, ncr53c8xx and aic7xxx
drivers are included in the kernel, up to version 2.4.2, the
adaptec driver always came first (so the first disk on an adaptec
controller ended up as /dev/sda) while in 2.4.3, the ncr driver
initializes first and all the device names change - with
potentially disastrous effects for unsuspecting users.

AFAIK, the numbering of scsi busses depends only on the order the
low-level drivers are loaded. Not that I can think of any better
way to do this, but it would be good if things were a little bit
more predictable - in absence of any better idea, maybe by
loading the drivers in alphabetical order or something like that ...

How is it possible, to influence that order at the moment (for
example, to revert to the old order)? I personally couldn't
figure out, where to change this.

Regards,
              Peter Daum

