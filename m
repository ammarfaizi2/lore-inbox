Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314093AbSD0Nv1>; Sat, 27 Apr 2002 09:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSD0NvZ>; Sat, 27 Apr 2002 09:51:25 -0400
Received: from ns.suse.de ([213.95.15.193]:11794 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314093AbSD0NvS>;
	Sat, 27 Apr 2002 09:51:18 -0400
Date: Sat, 27 Apr 2002 15:51:16 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.10-dj1
Message-ID: <20020427155116.I14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rudmer@legolas.dynup.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020427030823.GA21608@suse.de> <200204271313.g3RDD4024060@smtp1.wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 02:51:21PM +0200, Rudmer van Dijk wrote:

 > compiled fine, but after booting the system does not respond to the keyboard 
 > (I can see the message "serio: i8042 KBD port at 0x60,0x64 irq 1" om my 
 > screen)

There are some reports that ACPI is having a bad interaction with the
keyboard controller. For now, disabling it may fix this.

 > The system also hangs after fscking my root partition (fsck completed without 
 > errors)
 > After my harddisks went to sleep I switched the system off and after booting 
 > the kernel (2.4.19-pre7) panics (and the caps- and scroll-lock leds are 
 > blinking) as it can not mount the root fs due to the following errors:
 > EXT2-fs error (device ide0(3,1)): ext2_check_descriptors: Block bitmap for 
 > group 0 not in group (block 0)!
 > EXT2-fs: group descriptors corrupted!

This is somewhat disturbing. I'll look over the VFS changes, but I'm not
aware of anything added specifically to my tree that could cause this,
so it may be either an ext2 issue in mainline, or one of the drivers.

IDE ? SCSI ?

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
