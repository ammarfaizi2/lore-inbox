Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132110AbQKZDGK>; Sat, 25 Nov 2000 22:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132114AbQKZDGB>; Sat, 25 Nov 2000 22:06:01 -0500
Received: from www.hr.vc-graz.ac.at ([193.171.240.3]:47626 "EHLO
        www.hr.vc-graz.ac.at") by vger.kernel.org with ESMTP
        id <S132110AbQKZDFu>; Sat, 25 Nov 2000 22:05:50 -0500
Message-ID: <3A207714.DA2B03E@fl.priv.at>
Date: Sun, 26 Nov 2000 03:36:04 +0100
From: Friedrich Lobenstock <fl@fl.priv.at>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: andre@linux-ide.org
CC: linux-kernel@vger.kernel.org, ahedrick@atipa.com, andre@suse.com
Subject: [PATCH] promise controller and QUANTUM FIREBALLlct10 30
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre!

I had to apply this patch to be able to get my system starting up
because the PDC driver would look the system without it.

If I remember correctly the system would hang after the last line shown.
hda: QUANTUM FIREBALLlct10 10, ATA DISK drive
hdc: QUANTUM FIREBALLlct10 10, ATA DISK drive
hde: QUANTUM FIREBALLlct10 30, ATA DISK drive           (on PDC 20262 !)
hdg: QUANTUM FIREBALLlct10 30, ATA DISK drive            (on PDC 20262 !)
[..]
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63, UDMA(33)
hdc: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63, UDMA(33)
hde: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)
hdg: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)


--- linux/drivers/ide/pdc202xx.c~       Fri Jul 28 21:08:30 2000
+++ linux/drivers/ide/pdc202xx.c        Sat Nov 25 20:18:51 2000
@@ -222,6 +222,7 @@

 const char *pdc_quirk_drives[] = {
        "QUANTUM FIREBALLlct08 08",
+       "QUANTUM FIREBALLlct10 30",
        "QUANTUM FIREBALLP KA6.4",
        "QUANTUM FIREBALLP LM20.4",
        "QUANTUM FIREBALLP LM20.5",

PS: Please CC me because I'm not on linux-kernel.
 
MfG / Regards
Friedrich Lobenstock
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
