Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUFXBFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUFXBFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 21:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUFXBFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 21:05:13 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:24455 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263413AbUFXBFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 21:05:09 -0400
Date: Wed, 23 Jun 2004 20:59:06 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: George Georgalis <george@galis.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SIIMAGE sata fails with 2.6.7
In-Reply-To: <20040623202539.GB3537@trot.local>
Message-ID: <Pine.GSO.4.33.0406232055050.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0406232055052.25702@sweetums.bluetronic.net>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, George Georgalis wrote:
>I changed "hdc" entries to "sda" in fstab and grub, but on reboot
>my root, sda1, could not be found. Might it be another device?
>Or something else? config attached.

# CONFIG_BLK_DEV_SD is not set

I'm gonna go ahead and say what I'm thinking *grin*... well, duh.  There's
no support for any SCSI DISKS.  libata is a scsi driver which makes your
sata drives appear as scsi drives.

Turn that on, recompile, and reboot.

--Ricky


