Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290312AbSBLRKj>; Tue, 12 Feb 2002 12:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290609AbSBLRK3>; Tue, 12 Feb 2002 12:10:29 -0500
Received: from [65.213.101.20] ([65.213.101.20]:39926 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S290312AbSBLRK0>; Tue, 12 Feb 2002 12:10:26 -0500
Message-ID: <6B1DF6EEBA51D31182F200902740436803B249F8@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Martin Mares'" <pci-ids@ucw.cz>,
        "'acme@conectiva.com.br'" <acme@conectiva.com.br>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'lkml'" <linux-kernel@vger.kernel.org>,
        "'Mark Hahn'" <hahn@coffee.psychology.mcmaster.ca>
Subject: RE: [PATCH] 2.4.x/2.5.x: update for PCI vendor id 0x12d4
Date: Tue, 12 Feb 2002 12:10:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a re-send of a "minor nuisance" patch (down in the end) 
that got dropped without any actual objection. 
It still applies (with different offsets, but otherwise cleanly).

I've (unfortunately) been assigned to another task (non-Linux-related)
at work, so I'm not actively following lkml now (still reading the
web archives occ-ly as well as the ker. traffic...) :-((
This means I am not able to actively repush the patch if it keeps
being ignored - A.C.M.E., can you please add this patch to your
cleanups list if it gets forgotten again?

Kind regards,
	Vassilii

-----Original Message-----
From: Khachaturov, Vassilii 
Sent: Wednesday, May 30, 2001 3:34 PM

[Updated patch is in the end of this mail]
Thanks, Mark!

> submit patches as text in your message, since people want 
> to read them, and not waste time saving to a file, etc.
> also, explain patches: who is vid 0x12d4, how did you get 
> the information, what does it effect, etc.

BTW I noticed a funny thing: the file devlist.h I tried to 
patch doesn't always exist - as it gets built from the file 
pci.ids in the same directory. Noone complained on that :)
What I don't understand is why pci_ids.h doesn't get
generated from pci.ids as well.

So, here's the new patch, sent along also to the pci.ids 
maintainer, along with the required info.

12d4 was DGM&S. Then DGM&S was aquired by Comverse, and 
later the corresponding activities (and the same PCI boards 
manufacturing) went to Comverse spinoff Ulticom. So, in fact,
Ulticom is just DGM&S under a different name and controlled
by Comverse. I guess the PCI vendor registry should get 
updated at some point, but I thought it could be a great 
thing if Linux knew it ahead. (Currently reported by the 
PCI driver "DGM&S" is obsolete - such entity doesn't exist 
any more). Naturally, I have got this info being a 
Comverse employee.

This patch only has effect on kernel PCI driver reporting 
on the 12d4 vendor ID. There is no Linux kernel code which
supports the corresponding SS7 signalling boards.

Kind regards,
	Vassilii

--- /usr/src/linux-2.4.5/include/linux/pci_ids.h	Wed May 16 13:25:39
2001
+++ pci_ids.h	Wed May 30 14:55:01 2001
@@ -1199,6 +1199,8 @@
 #define PCI_VENDOR_ID_NVIDIA_SGS	0x12d2
 #define PCI_DEVICE_ID_NVIDIA_SGS_RIVA128 0x0018
 
+#define PCI_VENDOR_ID_ULTICOM	0x12d4 /* Formerly DGM&S */
+
 #define PCI_SUBVENDOR_ID_CHASE_PCIFAST		0x12E0
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST4		0x0031
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST8		0x0021
--- /usr/src/linux-2.4.5/drivers/pci/pci.ids	Sat May 19 20:49:14 2001
+++ pci.ids	Wed May 30 14:54:50 2001
@@ -3204,7 +3204,7 @@
 	002c  VTNT2
 	00a0  ITNT2
 12d3  Vingmed Sound A/S
-12d4  DGM&S
+12d4  Ulticom (Formerly DGM&S)
 12d5  Equator Technologies
 12d6  Analogic Corp
 12d7  Biotronic SRL
