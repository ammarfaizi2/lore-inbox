Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKLLje>; Sun, 12 Nov 2000 06:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbQKLLjY>; Sun, 12 Nov 2000 06:39:24 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:30547
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129045AbQKLLjN>; Sun, 12 Nov 2000 06:39:13 -0500
Date: Sun, 12 Nov 2000 12:31:26 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: john slee <indigoid@higherplane.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, dake@staszic.waw.pl,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre3 [gus_midi.c breakage]
Message-ID: <20001112123126.C637@jaquet.dk>
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com> <20001112205848.E19275@higherplane.net> <20001112121707.B637@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001112121707.B637@jaquet.dk>; from rasmus@jaquet.dk on Sun, Nov 12, 2000 at 12:17:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 12:17:07PM +0100, Rasmus Andersen wrote:
> On Sun, Nov 12, 2000 at 08:58:48PM +1100, john slee wrote:
> > On Sat, Nov 11, 2000 at 07:22:06PM -0800, Linus Torvalds wrote:
> > >-----
> > >  - pre3:
> > >     - Bartlomiej Zolnierkiewicz: sound and drm driver init fixes and
> > >       cleanups
> > 

It seems like this touched more than just gus_midi.c. The following
patch are similarly trivial as the previously posted and therefore
are bunched together. They should fix the sound/ drivers.

--- linux-240-t11-pre3-clean/drivers/sound/gus_wave.c	Sun Nov 12 09:46:14 2000
+++ linux/drivers/sound/gus_wave.c	Sun Nov 12 12:20:08 2000
@@ -17,7 +17,7 @@
  * Bartlomiej Zolnierkiewicz : added some __init/__exit
  */
  
- 
+#include <linux/init.h> 
 #include <linux/config.h>
 
 #define GUSPNP_AUTODETECT
--- linux-240-t11-pre3-clean/drivers/sound/ics2101.c	Sun Nov 12 09:46:14 2000
+++ linux/drivers/sound/ics2101.c	Sun Nov 12 12:21:53 2000
@@ -14,6 +14,7 @@
  * Thomas Sailer   : ioctl code reworked (vmalloc/vfree removed)
  * Bartlomiej Zolnierkiewicz : added __init to ics2101_mixer_init()
  */
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include <linux/ultrasound.h>
--- linux-240-t11-pre3-clean/drivers/sound/pas2_midi.c	Sun Nov 12 09:46:14 2000
+++ linux/drivers/sound/pas2_midi.c	Sun Nov 12 12:24:24 2000
@@ -13,6 +13,7 @@
  * Bartlomiej Zolnierkiewicz	: Added __init to pas_init_mixer()
  */
 
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include "pas2.h"
--- linux-240-t11-pre3-clean/drivers/sound/pas2_mixer.c	Sun Nov 12 09:46:14 2000
+++ linux/drivers/sound/pas2_mixer.c	Sun Nov 12 12:25:16 2000
@@ -16,6 +16,7 @@
  * Thomas Sailer   : ioctl code reworked (vmalloc/vfree removed)
  * Bartlomiej Zolnierkiewicz : added __init to pas_init_mixer()
  */
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include "pas2.h"
--- linux-240-t11-pre3-clean/drivers/sound/pas2_pcm.c	Sun Nov 12 09:46:14 2000
+++ linux/drivers/sound/pas2_pcm.c	Sun Nov 12 12:26:49 2000
@@ -15,6 +15,7 @@
  * Bartlomiej Zolnierkiewicz : Added __init to pas_pcm_init()
  */
 
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include "pas2.h"


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"An intellectual is someone whose mind watches itself."
  -- Albert Camus (1913-1960)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
