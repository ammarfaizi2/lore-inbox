Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbREITjj>; Wed, 9 May 2001 15:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbREITj3>; Wed, 9 May 2001 15:39:29 -0400
Received: from [209.143.110.29] ([209.143.110.29]:28934 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S129242AbREITjK>; Wed, 9 May 2001 15:39:10 -0400
Message-ID: <3AF99C35.74BDAEC@the-rileys.net>
Date: Wed, 09 May 2001 15:36:21 -0400
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, t.sailer@alumni.ethz.ch
Subject: Small es1371 documentation fix (joyport)
Content-Type: multipart/mixed;
 boundary="------------6925F78CAA3F8637C38EA25F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6925F78CAA3F8637C38EA25F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

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
Content-Type: text/plain; charset=us-ascii;
 name="es1371.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es1371.diff"

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

