Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLOV1v>; Fri, 15 Dec 2000 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbQLOV1l>; Fri, 15 Dec 2000 16:27:41 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:59640
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129340AbQLOV1h>; Fri, 15 Dec 2000 16:27:37 -0500
Date: Fri, 15 Dec 2000 13:56:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre1
Message-ID: <20001215135613.R504@opus.bloom.county>
In-Reply-To: <E1470sk-0001kp-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1470sk-0001kp-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 15, 2000 at 07:51:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2000 at 07:51:04PM +0000, Alan Cox wrote:
 
> Ok this is the first block of changes before we merge the VM stuff. This is
> mostly the bits left over from the 2.2.18 port that were deferred as too
> risky near the end of a prerelease set and some bug swats

I believe Brad Douglas has soemthing for aty128fb as well, but the attached
patch defines the correct CONFIG_FBCON_CFBXXs for aty128.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="128fix.patch"

===== drivers/video/Config.in 1.10 vs edited =====
--- 1.10/drivers/video/Config.in	Fri Oct 20 22:20:29 2000
+++ edited/drivers/video/Config.in	Sun Dec 10 13:33:45 2000
@@ -188,7 +188,8 @@
 	 "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
          "$CONFIG_FB_IGA" = "y" -o "$CONFIG_FB_MATROX" = "y" -o \
 	 "$CONFIG_FB_CT65550" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	 "$CONFIG_FB_SGIVW" = "y" -o "$CONFIG_FB_CYBER2000" = "y" ]; then
+	 "$CONFIG_FB_SGIVW" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
+	 "$CONFIG_FB_ATY128" = "y" ]; then
       define_bool CONFIG_FBCON_CFB8 y
     else
       if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_ATARI" = "m" -o \
@@ -202,14 +203,15 @@
 	   "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
            "$CONFIG_FB_IGA" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
 	   "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-	   "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_CYBER2000" = "m" ]; then
+	   "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_CYBER2000" = "m" -o \
+	   "$CONFIG_FB_ATY128" = "m" ]; then
 	define_bool CONFIG_FBCON_CFB8 m
       fi
     fi
     if [ "$CONFIG_FB_ATARI" = "y" -o "$CONFIG_FB_ATY" = "y" -o \
 	 "$CONFIG_FB_MAC" = "y" -o "$CONFIG_FB_VESA" = "y" -o \
 	 "$CONFIG_FB_VIRTUAL" = "y" -o "$CONFIG_FB_TBOX" = "y" -o \
-	 "$CONFIG_FB_Q40" = "y" -o \
+	 "$CONFIG_FB_Q40" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	 "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
 	 "$CONFIG_FB_VIRGE" = "y" -o "$CONFIG_FB_CYBER" = "y" -o \
 	 "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
@@ -221,7 +223,7 @@
       if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
 	   "$CONFIG_FB_MAC" = "m" -o "$CONFIG_FB_VESA" = "m" -o \
 	   "$CONFIG_FB_VIRTUAL" = "m" -o "$CONFIG_FB_TBOX" = "m" -o \
-	 "$CONFIG_FB_Q40" = "m" -o \
+	   "$CONFIG_FB_Q40" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	   "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
 	   "$CONFIG_FB_VIRGE" = "m" -o "$CONFIG_FB_CYBER" = "m" -o \
  	   "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
@@ -233,14 +235,14 @@
     fi
     if [ "$CONFIG_FB_ATY" = "y" -o "$CONFIG_FB_VIRTUAL" = "y" -o \
 	 "$CONFIG_FB_CLGEN" = "y" -o "$CONFIG_FB_VESA" = "y" -o \
-	  "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	 "$CONFIG_FB_CYBER2000" = "y" ]; then
+	 "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
+	 "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_ATY128" = "y" ]; then
       define_bool CONFIG_FBCON_CFB24 y
     else
       if [ "$CONFIG_FB_ATY" = "m" -o "$CONFIG_FB_VIRTUAL" = "m" -o \
 	   "$CONFIG_FB_CLGEN" = "m" -o "$CONFIG_FB_VESA" = "m" -o \
 	   "$CONFIG_FB_MATROX" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-	   "$CONFIG_FB_CYBER2000" = "m" ]; then
+	   "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_ATY128" = "m" ]; then
 	define_bool CONFIG_FBCON_CFB24 m
       fi
     fi
@@ -249,7 +251,8 @@
 	 "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
 	 "$CONFIG_FB_TGA" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
 	 "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	 "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" ]; then
+	 "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
+	 "$CONFIG_FB_ATY128" = "y" ]; then
       define_bool CONFIG_FBCON_CFB32 y
     else
       if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
@@ -257,7 +260,7 @@
 	   "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
 	   "$CONFIG_FB_TGA" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
 	   "$CONFIG_FB_MATROX" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-           "$CONFIG_FB_SGIVW" = "m" ]; then
+           "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_ATY128" = "m" ]; then
 	define_bool CONFIG_FBCON_CFB32 m
       fi
     fi

--/aVve/J9H4Wl5yVO--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
