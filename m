Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131271AbQK2Wei>; Wed, 29 Nov 2000 17:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131408AbQK2We3>; Wed, 29 Nov 2000 17:34:29 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:48887
        "EHLO opus.bloom.county") by vger.kernel.org with ESMTP
        id <S131271AbQK2WeQ>; Wed, 29 Nov 2000 17:34:16 -0500
Date: Wed, 29 Nov 2000 15:01:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre24
Message-ID: <20001129150159.Y872@opus.bloom.county>
In-Reply-To: <E140wh7-0005Na-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E140wh7-0005Na-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 29, 2000 at 02:09:59AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2000 at 02:09:59AM +0000, Alan Cox wrote:

...
> 2.2.18pre21
...
> o	Resnchronize Apple PowerMac codebase		(Paul Mackerras & co)
> o	Merge powermac tree fixes into usb
> o	Powermac input device handling changes

As Dave Miller pointed out, DEV_MAC_HID sysctl conflicts with the RAID patches
which are in much wider use.  And as nothing yet uses this sysctl, I've
attached a patch vs pre24 which changes the number from 3 to 5 (which is what
2.4.0-testX uses.)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sysctl.patch"

--- linux/include/linux/sysctl.h.orig	Wed Nov 29 15:01:09 2000
+++ linux/include/linux/sysctl.h	Wed Nov 29 15:01:25 2000
@@ -435,7 +435,7 @@
 enum {
 	DEV_CDROM=1,
 	DEV_HWMON=2,
-	DEV_MAC_HID=3
+	DEV_MAC_HID=5
 };
 
 /* /proc/sys/dev/cdrom */

--9amGYk9869ThD9tj--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
