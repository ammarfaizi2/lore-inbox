Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbSLKMJN>; Wed, 11 Dec 2002 07:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbSLKMJN>; Wed, 11 Dec 2002 07:09:13 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:6414 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S267126AbSLKMJK>;
	Wed, 11 Dec 2002 07:09:10 -0500
Message-ID: <3DF72CB5.3010202@epfl.ch>
Date: Wed, 11 Dec 2002 13:16:53 +0100
From: Nicolas ASPERT <Nicolas.Aspert@epfl.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Margit Schubert-While <margitsw@t-online.de>
CC: davej@suse.de, faith@redhat.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.4.20 AGP for I845 wrong ?
References: <fa.jjk71mv.1kja10g@ifi.uio.no>
In-Reply-To: <fa.jjk71mv.1kja10g@ifi.uio.no>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070901070704090104090200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901070704090104090200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ooops... the patch I sent for 2.5.51 is wrong, since there I added a 
INTEL_I845 instead of a INTEL_I845_G (I know vim *does* weird things in 
my back 8-)

Here is the correct one...

Regards

Nicolas.
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

--------------070901070704090104090200
Content-Type: text/plain;
 name="intelchipset-id-2.5.51.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intelchipset-id-2.5.51.diff"

diff -ru linux-2.5.51.clean/drivers/char/drm/drm_agpsupport.h linux-2.5.51/drivers/char/drm/drm_agpsupport.h
--- linux-2.5.51.clean/drivers/char/drm/drm_agpsupport.h	Tue Dec 10 03:45:39 2002
+++ linux-2.5.51/drivers/char/drm/drm_agpsupport.h	Wed Dec 11 12:55:08 2002
@@ -271,10 +271,12 @@
 #if LINUX_VERSION_CODE >= 0x02040f /* KERNEL_VERSION(2,4,15) */
 	 	case INTEL_I820:	head->chipset = "Intel i820";	 break;
 #endif
+		case INTEL_I830_M:	head->chipset = "Intel i830M";	 break;
 		case INTEL_I840:	head->chipset = "Intel i840";    break;
 #if LINUX_VERSION_CODE >= 0x02040f /* KERNEL_VERSION(2,4,15) */
 		case INTEL_I845:	head->chipset = "Intel i845";    break;
 #endif
+		case INTEL_I845_G:	head->chipset = "Intel i845G";	 break;
 		case INTEL_I850:	head->chipset = "Intel i850";	 break;
 		case INTEL_460GX:	head->chipset = "Intel 460GX";	 break;
 

--------------070901070704090104090200--

