Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUFWWAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUFWWAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUFWVxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:53:42 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:8584 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S261907AbUFWVuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:50:20 -0400
Mail-Followup-To: linux-kernel@vger.kernel.org,
  fabian.fenaut@free.fr
MBOX-Line: From george@galis.org  Wed Jun 23 17:50:16 2004
Date: Wed, 23 Jun 2004 17:50:16 -0400
From: George Georgalis <george@galis.org>
To: Fabian Fenaut <fabian.fenaut@free.fr>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SIIMAGE and sata_sil with 2.6.7-bk
Message-ID: <20040623215016.GD3537@trot.local>
References: <20040623163505.GA1068@trot.local> <Pine.GSO.4.33.0406231327060.25702-100000@sweetums.bluetronic.net> <20040623202539.GB3537@trot.local> <40D9F4D9.1060002@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D9F4D9.1060002@free.fr>
X-Time: trot.local; @951; Wed, 23 Jun 2004 17:50:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 11:23:37PM +0200, Fabian Fenaut wrote:
>I think you need CONFIG_BLK_DEV_INITRD, otherwise libata and sata_sil
>won't be loaded at boot.

Since this is a monolithic kernel, that shouldn't be required.

I now have the box up on an ATA disk, root=/dev/hda1
but I don't see the sata drive or any scsi devices in
/proc/sys/dev/scsi/

This seems to indicate "sata_sil" which is more than lspci

# cat /proc/bus/pci/devices | grep sata
00a0    10953112        f       0000dc01        0000e001        0000e401        0000e801    0000ec01 e4400000        00000000        00000008        00000004        00000008        00000004     00000010        00000200        00080000        sata_sil


do I need to change my partition types to md or something? (...oh, atm I
can't.) Why isn't the controler in /proc/sys/dev/scsi/?

// George

-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

