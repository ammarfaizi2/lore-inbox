Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSL0CsL>; Thu, 26 Dec 2002 21:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSL0CsL>; Thu, 26 Dec 2002 21:48:11 -0500
Received: from CPE-203-51-25-222.nsw.bigpond.net.au ([203.51.25.222]:44792
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S264748AbSL0CsL>; Thu, 26 Dec 2002 21:48:11 -0500
Message-ID: <3E0BC155.5B291F57@eyal.emu.id.au>
Date: Fri, 27 Dec 2002 13:56:21 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-e1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph <jospehchan@yahoo.com.tw>
CC: linux-kernel@vger.kernel.org
Subject: Re: [USB 2.0 problem] ASUS CD-RW cannot be mounted.
References: <002801c2acd2$edf6a870$3716a8c0@taipei.via.com.tw> <20021226174653.GA8229@kroah.com> <003d01c2ad4a$54eb09f0$3716a8c0@taipei.via.com.tw>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph wrote:
> 
> > Are you sure you have all of the scsi modules you need loaded?  The
> > dmesg output looks fine, what happens when you try to mount the drive?
> > And does this drive work with older 2.5 kernels, or 2.4?
> 
>   I think I've made all scsi modules I need built-in kernel.
>   (usbcore, ehci-hcd, usb-storage, sr_mod, sd_mod) Do I miss something?
>   Also, I've tested the ASUS CD-RW under kernel 2.5.45 and it worked.
>   But in the kernel 2.5.53, the system shows below when I try to mount the
> CD-RW.
> **   #mount /dev/scd0 /mnt/usb-cd
> **   mount: /dev/scd0 is not a valid block device

Check that you actually have /dev/scd0. I think it should be:
	# mknod /dev/scd0 b 11 0

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
