Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSEQH7c>; Fri, 17 May 2002 03:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSEQH7b>; Fri, 17 May 2002 03:59:31 -0400
Received: from ns.tasking.nl ([195.193.207.2]:8460 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S315455AbSEQH7a>;
	Fri, 17 May 2002 03:59:30 -0400
To: linux-kernel@vger.kernel.org
Cc: Martin Dalecki <dalecki@evision-ventures.com>
Subject: VIA 82C586_1 (KT266 IDE) in 2.5.15
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: Kees Bakker <rnews@altium.nl>
Date: 17 May 2002 09:56:54 +0200
Message-ID: <sid6vvmcl5.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.15 I'm able to boot again. Great. Starting with 2.5.9 (upto
2.5.14) I was getting
  hda: lost interrupt
and the system was stuck at that point.
But now I'm happy again.

But for my KT266 I need a little patch. I've copied the entry for 82C561
which may be somewhat incorrrect. But it's a start.

--- linux-2.5.15/drivers/ide/ide-pci.c	Wed May 15 22:02:11 2002
+++ linux-2.5.15.kees/drivers/ide/ide-pci.c	Thu May 16 14:54:33 2002
@@ -787,6 +787,12 @@
 		device: PCI_DEVICE_ID_VIA_82C561,
 		bootable: ON_BOARD,
 		flags: ATA_F_NOADMA
+	},
+	{
+		vendor: PCI_VENDOR_ID_VIA,
+		device: PCI_DEVICE_ID_VIA_82C586_1,
+		bootable: ON_BOARD,
+		flags: ATA_F_NOADMA
 	}
 };
 

If you need more details, please let me know.
      Kees.
--
