Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUFXP7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUFXP7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUFXP7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:59:23 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:55178 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S265782AbUFXP7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:59:20 -0400
Mail-Followup-To: linux-kernel@vger.kernel.org
MBOX-Line: From george@galis.org  Thu Jun 24 11:59:19 2004
Date: Thu, 24 Jun 2004 11:59:19 -0400
From: George Georgalis <george@galis.org>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: SATA_SIL fails with 2.6.7-bk6 seagate drive
Message-ID: <20040624155919.GA16422@trot.local>
References: <20040623202539.GB3537@trot.local> <Pine.GSO.4.33.0406232055050.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0406232055050.25702-100000@sweetums.bluetronic.net>
X-Time: trot.local; @707; Thu, 24 Jun 2004 11:59:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 08:59:06PM -0400, Ricky Beam wrote:
>On Wed, 23 Jun 2004, George Georgalis wrote:
>>I changed "hdc" entries to "sda" in fstab and grub, but on reboot
>>my root, sda1, could not be found. Might it be another device?
>>Or something else? config attached.
>
># CONFIG_BLK_DEV_SD is not set
>
>I'm gonna go ahead and say what I'm thinking *grin*... well, duh.  There's
>no support for any SCSI DISKS.  libata is a scsi driver which makes your
>sata drives appear as scsi drives.
>
>Turn that on, recompile, and reboot.

Whoops! Well that got me able to mount it. Thanks!

dd if=/dev/zero of=/mnt/zero-`date +%s`

has caused pdflush to block IO, any access to /mnt and the process
does not return. other than the pdflush load of ~99% the box seems to
function normally. 2.6.7-bk6, seagate drive

I enabled some video options which seem to have blanked my display,
wrong driver, bug or overscanning text console (?), not sure; but I'll
follow up with more detailed sata report when I get video okay (at least
24 hrs).

// George

-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

