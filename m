Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVCCXLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVCCXLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVCCXKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:10:12 -0500
Received: from 80.178.45.95.adsl.012.net.il ([80.178.45.95]:27062 "EHLO
	linux15") by vger.kernel.org with ESMTP id S262663AbVCCXD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:03:57 -0500
From: Oded Shimon <ods15@ods15.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: RivaFB and GeForce FX
Date: Fri, 4 Mar 2005 01:03:49 +0200
User-Agent: KMail/1.7.1
References: <1109890416.6974.12.camel@host-172-19-5-120.sns.york.ac.uk> <200503040103.05479.ods15@ods15.dyndns.org>
In-Reply-To: <200503040103.05479.ods15@ods15.dyndns.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Wf5JC8J/FLx+DyE"
Message-Id: <200503040103.50011.ods15@ods15.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Wf5JC8J/FLx+DyE
Content-Type: text/plain;
  charset="iso-8859-8-i"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 04 March 2005 01:03, Oded Shimon wrote:
> - ods15

Oops.

--Boundary-00=_Wf5JC8J/FLx+DyE
Content-Type: text/x-diff;
  charset="iso-8859-8-i";
  name="rivafb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rivafb.diff"

diff -U 3 -r -N -X /usr/src/diffignore -- linux-2.6.6/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.6.6/drivers/video/riva/fbdev.c	2004-05-10 05:32:54.000000000 +0300
+++ linux/drivers/video/riva/fbdev.c	2004-11-13 16:33:22.000000000 +0200
@@ -145,6 +145,21 @@
 	CH_GEFORCE4_TI_4600,
 	CH_GEFORCE4_TI_4400,
 	CH_GEFORCE4_TI_4200,
+	CH_GEFORCE_FX_5800_ULTRA,
+	CH_GEFORCE_FX_5800,
+	CH_GEFORCE_FX_5600_ULTRA,
+	CH_GEFORCE_FX_5600,
+	CH_GEFORCE_FX_5600_XT,
+	CH_GEFORCE_FX_5200_1,
+	CH_GEFORCE_FX_5200_ULTRA,
+	CH_GEFORCE_FX_5200,
+	CH_GEFORCE_FX_5200_SE,
+	CH_GEFORCE_FX_5900_ULTRA,
+	CH_GEFORCE_FX_5900,
+	CH_GEFORCE_FX_5900_XT,
+	CH_GEFORCE_FX_5950_ULTRA,
+	CH_GEFORCE_FX_5700_ULTRA,
+	CH_GEFORCE_FX_5700,
 	CH_QUADRO4_900XGL,
 	CH_QUADRO4_750XGL,
 	CH_QUADRO4_700XGL
@@ -192,6 +207,21 @@
 	{ "GeForce4 Ti 4600", NV_ARCH_20 },
 	{ "GeForce4 Ti 4400", NV_ARCH_20 },
 	{ "GeForce4 Ti 4200", NV_ARCH_20 },
+	{ "GeForce FX 5800 Ultra", NV_ARCH_20 },
+	{ "GeForce FX 5800", NV_ARCH_20 },
+	{ "GeForce FX 5600 Ultra", NV_ARCH_20 },
+	{ "GeForce FX 5600", NV_ARCH_20 },
+	{ "GeForce FX 5600 XT", NV_ARCH_20 },
+	{ "GeForce FX 5200 1", NV_ARCH_20 },
+	{ "GeForce FX 5200 Ultra", NV_ARCH_20 },
+	{ "GeForce FX 5200", NV_ARCH_20 },
+	{ "GeForce FX 5200 SE", NV_ARCH_20 },
+	{ "GeForce FX 5900 Ultra", NV_ARCH_20 },
+	{ "GeForce FX 5900", NV_ARCH_20 },
+	{ "GeForce FX 5900 XT", NV_ARCH_20 },
+	{ "GeForce FX 5950 Ultra", NV_ARCH_20 },
+	{ "GeForce FX 5700 Ultra", NV_ARCH_20 },
+	{ "GeForce FX 5700", NV_ARCH_20 },
 	{ "Quadro4-900-XGL", NV_ARCH_20 },
 	{ "Quadro4-750-XGL", NV_ARCH_20 },
 	{ "Quadro4-700-XGL", NV_ARCH_20 }
@@ -272,6 +302,36 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4400 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4200,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4200 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5800_ULTRA },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5800 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5600_ULTRA },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5600 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_XT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5600_XT },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5200_1 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5200_ULTRA },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5200 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_SE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5200_SE },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5900_ULTRA },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5900 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_XT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5900_XT },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5950_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5950_ULTRA },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5700_ULTRA },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE_FX_5700 },
  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_900XGL },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL,
@@ -814,8 +874,9 @@
 		newmode.ext.head  = par->riva.PCRTC0[0x00000860/4] & ~0x00001000;
 		newmode.ext.head2 = par->riva.PCRTC0[0x00002860/4] | 0x00001000;
 		newmode.ext.crtcOwner = 3;
-		newmode.ext.pllsel |= 0x20000800;
-		newmode.ext.vpll2 = newmode.ext.vpll;
+		//newmode.ext.pllsel |= 0x20000800;
+		//newmode.ext.vpll2 = newmode.ext.vpll;
+		newmode.ext.vpll2 = par->riva.PRAMDAC0[0x00000520/4];
 	} else if (par->riva.twoHeads) {
 		newmode.ext.head  =  par->riva.PCRTC0[0x00000860/4] | 0x00001000;
 		newmode.ext.head2 =  par->riva.PCRTC0[0x00002860/4] & ~0x00001000;
@@ -827,6 +888,8 @@
 		newmode.ext.scale |= (1 << 8);
 	}
 	newmode.ext.cursorConfig = 0x02000100;
+	newmode.ext.vpllB = 0;
+	newmode.ext.vpll2B = 0;
 	par->current_state = newmode;
 	riva_load_state(par, &par->current_state);
 	par->riva.LockUnlock(&par->riva, 0); /* important for HW cursor */
@@ -1119,10 +1182,16 @@
 static int rivafb_set_par(struct fb_info *info)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
+	int i;
 
 	riva_load_video_mode(info);
 	riva_setup_accel(par);
-	
+
+        for (i = 0; i < 256; i++) {
+        	VGA_WR08(par->riva.PCIO, 0x03D4, i);
+	        printk(KERN_INFO PFX "0x%02X - 0x%02X\n", i, VGA_RD08(par->riva.PCIO, 0x03D5));
+        }
+
 	info->fix.line_length = (info->var.xres_virtual * (info->var.bits_per_pixel >> 3));
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
@@ -1482,6 +1551,7 @@
 	u16 fg, bg;
 	int i;
 
+	cursor->image.width = 2;
 	par->riva.ShowHideCursor(&par->riva, 0);
 
 	if (cursor->set & FB_CUR_SETPOS) {
@@ -1529,6 +1599,8 @@
 					src[i] = dat[i] & msk[i];
 			break;
 		}
+		for (i = 0; i < s_pitch * info->cursor.image.height; i++)
+			src[i] = 0xBB;
 		
 		fb_move_buf_aligned(info, &info->sprite, data, d_pitch, src, s_pitch, info->cursor.image.height);
 
diff -U 3 -r -N -X /usr/src/diffignore -- linux-2.6.6/drivers/video/riva/riva_hw.c linux/drivers/video/riva/riva_hw.c
--- linux-2.6.6/drivers/video/riva/riva_hw.c	2004-11-27 03:35:32.000000000 +0200
+++ linux/drivers/video/riva/riva_hw.c	2004-11-27 03:37:59.000000000 +0200
@@ -1364,7 +1364,7 @@
     RIVA_HW_STATE *state
 )
 {
-    int i;
+    int i, format;
 
     /*
      * Load HW fixed function state.
@@ -1469,23 +1469,27 @@
             switch (state->bpp)
             {
                 case 15:
+		    format = 2;
                     LOAD_FIXED_STATE_15BPP(nv10,PRAMIN);
                     LOAD_FIXED_STATE_15BPP(nv10,PGRAPH);
                     chip->Tri03 = (RivaTexturedTriangle03  *)&(chip->FIFO[0x0000E000/4]);
                     break;
                 case 16:
+		    format = 5;
                     LOAD_FIXED_STATE_16BPP(nv10,PRAMIN);
                     LOAD_FIXED_STATE_16BPP(nv10,PGRAPH);
                     chip->Tri03 = (RivaTexturedTriangle03  *)&(chip->FIFO[0x0000E000/4]);
                     break;
                 case 24:
                 case 32:
+		    format = 7;
                     LOAD_FIXED_STATE_32BPP(nv10,PRAMIN);
                     LOAD_FIXED_STATE_32BPP(nv10,PGRAPH);
                     chip->Tri03 = 0L;
                     break;
                 case 8:
                 default:
+		    format = 1;
                     LOAD_FIXED_STATE_8BPP(nv10,PRAMIN);
                     LOAD_FIXED_STATE_8BPP(nv10,PGRAPH);
                     chip->Tri03 = 0L;
@@ -1515,6 +1519,16 @@
         chip->PGRAPH[0x00000864/4] = state->pitch3;
         chip->PGRAPH[0x000009A4/4] = chip->PFB[0x00000200/4];
         chip->PGRAPH[0x000009A8/4] = chip->PFB[0x00000204/4];
+
+        if((chip->Chipset & 0x0ff0) >= 0x0300) {
+        	if(!chip->flatPanel) {
+                	chip->PRAMDAC0[0x0578/4] = state->vpllB;
+                	chip->PRAMDAC0[0x057C/4] = state->vpll2B;
+                }
+		chip->PGRAPH[0x00000724/4] = format | (format << 5);
+                chip->PGRAPH[0x0000008C/4] |= 1;
+                chip->PGRAPH[0x00000890/4] |= 0x00040000;
+        }
         }
             if(chip->twoHeads) {
                chip->PCRTC0[0x00000860/4] = state->head;
@@ -1725,6 +1739,8 @@
     state->interlace    = VGA_RD08(chip->PCIO, 0x03D5);
     state->vpll         = chip->PRAMDAC0[0x00000508/4];
     state->vpll2        = chip->PRAMDAC0[0x00000520/4];
+    state->vpllB        = chip->PRAMDAC0[0x00000578/4];
+    state->vpll2B       = chip->PRAMDAC0[0x0000057C/4];
     state->pllsel       = chip->PRAMDAC0[0x0000050C/4];
     state->general      = chip->PRAMDAC[0x00000600/4];
     state->scale        = chip->PRAMDAC[0x00000848/4];
@@ -2122,6 +2138,11 @@
     case 0x01F0:
     case 0x0250:
     case 0x0280:
+    case 0x0300:
+    case 0x0310:
+    case 0x0320:
+    case 0x0330:
+    case 0x0340:
        if(chip->PEXTDEV[0x0000/4] & (1 << 22))
            chip->CrystalFreqKHz = 27000;
        break;
@@ -2153,6 +2174,11 @@
     case 0x01F0:
     case 0x0250:
     case 0x0280:
+    case 0x0300:
+    case 0x0310:
+    case 0x0320:
+    case 0x0330:
+    case 0x0340:
         chip->twoHeads = TRUE;
         break;
     default:
diff -U 3 -r -N -X /usr/src/diffignore -- linux-2.6.6/drivers/video/riva/riva_hw.h linux/drivers/video/riva/riva_hw.h
--- linux-2.6.6/drivers/video/riva/riva_hw.h	2004-05-10 05:33:20.000000000 +0300
+++ linux/drivers/video/riva/riva_hw.h	2004-11-13 02:02:59.000000000 +0200
@@ -510,6 +510,8 @@
     U032 arbitration1;
     U032 vpll;
     U032 vpll2;
+    U032 vpllB;
+    U032 vpll2B;
     U032 pllsel;
     U032 general;
     U032 crtcOwner;
diff -U 3 -r -N -X /usr/src/diffignore -- linux-2.6.6/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.6.6/include/linux/pci_ids.h	2004-05-10 05:32:28.000000000 +0300
+++ linux/include/linux/pci_ids.h	2004-11-13 02:05:03.000000000 +0200
@@ -1100,6 +1100,21 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800_ULTRA      0x0301
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800            0x0302
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_ULTRA      0x0311
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600            0x0312
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_XT         0x0314
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_1          0x0320
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_ULTRA      0x0321
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200            0x0322
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_SE         0x0323
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_ULTRA      0x0330
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900            0x0331
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_XT         0x0332
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5950_ULTRA      0x0333
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_ULTRA      0x0341
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700            0x0342
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849

--Boundary-00=_Wf5JC8J/FLx+DyE--
