Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135691AbREIWD5>; Wed, 9 May 2001 18:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135699AbREIWDq>; Wed, 9 May 2001 18:03:46 -0400
Received: from iq.sch.bme.hu ([152.66.214.168]:9488 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S135691AbREIWDa>;
	Wed, 9 May 2001 18:03:30 -0400
Date: Thu, 10 May 2001 00:08:57 +0200 (CEST)
From: Sasi Peter <sape@iq.rulez.org>
To: <linux-kernel@vger.kernel.org>
Subject: Small es1371 documentation fix (joyport) (fwd)
Message-ID: <Pine.LNX.4.33.0105100008230.20710-200000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=------------6925F78CAA3F8637C38EA25F
Content-ID: <Pine.LNX.4.33.0105100008231.20710@iq.rulez.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------6925F78CAA3F8637C38EA25F
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0105100008232.20710@iq.rulez.org>

Same patch should be applied for the es1370 also. (at least the joystick
part.)

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

---------- Forwarded message ----------
Date: Wed, 09 May 2001 15:36:21 -0400
From: David Riley <oscar@the-rileys.net>
To: linux-kernel@vger.kernel.org, t.sailer@alumni.ethz.ch
Subject: Small es1371 documentation fix (joyport)

The documentation for the es1371 driver doesn't mention how to
activate/specify the joystick port's base address (I had to look in the
code).  This patch fixes it.  The same probably applies to the es1370 as
well as other cards, but lacking said cards, I couldn't say for sure.
You may wish to re-word this, as it is not very concise, nor does it
read well (not that that's ever mattered in documentation before ;-).
If you have any replies, please CC me directly (I'm no longer subscribed
to the list).

Thanks,
	David

--------------6925F78CAA3F8637C38EA25F
Content-Type: TEXT/PLAIN; CHARSET=us-ascii; NAME="es1371.diff"
Content-ID: <Pine.LNX.4.33.0105100008233.20710@iq.rulez.org>
Content-Description: 
Content-Disposition: INLINE; FILENAME="es1371.diff"

--- es1371	Fri Jul 10 17:03:35 1998
+++ es1371	Wed May  9 15:20:56 2001
@@ -1,3 +1,11 @@
+/proc/sound, /dev/sndstat
+-------------------------
+
+/proc/sound and /dev/sndstat is not supported by the
+driver. To find out whether the driver succeeded loading,
+check the kernel log (dmesg).
+
+
 ALaw/uLaw sample formats
 ------------------------
 
@@ -51,6 +59,16 @@
 See http://www.cgs.fi/~tt/timidity/.
 
 
+Joystick Port
+-------------
+
+To enable the joystick port, enter "es1371=[port addr]" on the
+kernel command line.  Alternatively, if running as a module,
+enter "joystick=[port addr]" on the module's option line.
+Accepatble values for "port addr" are 0x200, 0x208, 0x210, and
+0x218.
+
+
 
 Thomas Sailer
-sailer@ife.ee.ethz.ch
+t.sailer@alumni.ethz.ch

--------------6925F78CAA3F8637C38EA25F--
