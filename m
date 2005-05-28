Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVE1LNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVE1LNc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVE1LNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:13:32 -0400
Received: from orb.pobox.com ([207.8.226.5]:22224 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262700AbVE1LNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:13:17 -0400
Message-ID: <42985251.6030006@cpan.org>
Date: Sat, 28 May 2005 03:13:21 -0800
From: "Sean M. Burke" <sburke@cpan.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: PATCH: "Ok" -> "OK" in messages
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The English interjection "OK" is misspelled as "Ok" in a dozen
messages in the Linux kernel.  The following patch corrects
those typos from "Ok" to "OK".  It affects no comments or
symbol-names -- and it stops me wanting to gnaw my fingers off every
time I see "Ok, booting the kernel."!

("Okay" is an acceptable variant spelling of "OK".  I chose "OK" over
"Okay" for sake of concision.)

(I also fix three incidental nearby typoes in
drivers/media/video/bttv-driver.c -- see at the end.)


Signed-off-by: Sean M. Burke <sburke@cpan.org>


diff -uprN --exclude='*~*' linux-2.6.9.orig/arch/alpha/boot/bootp.c linux-2.6.9/arch/alpha/boot/bootp.c
--- linux-2.6.9.orig/arch/alpha/boot/bootp.c	2004-10-18 13:55:06.000000000 -0800
+++ linux-2.6.9/arch/alpha/boot/bootp.c	2005-05-28 01:29:44.000000000 -0800
@@ -100,7 +100,7 @@ pal_init(void)
  		(INIT_HWRPB->processor_offset + (unsigned long) INIT_HWRPB);
  	rev = percpu->pal_revision = percpu->palcode_avail[2];

-	srm_printk("Ok (rev %lx)\n", rev);
+	srm_printk("OK (rev %lx)\n", rev);

  	tbia(); /* do it directly in case we are SMP */
  }
diff -uprN --exclude='*~*' linux-2.6.9.orig/arch/alpha/boot/main.c linux-2.6.9/arch/alpha/boot/main.c
--- linux-2.6.9.orig/arch/alpha/boot/main.c	2004-10-18 13:55:35.000000000 -0800
+++ linux-2.6.9/arch/alpha/boot/main.c	2005-05-28 01:29:33.000000000 -0800
@@ -97,7 +97,7 @@ pal_init(void)
  		(INIT_HWRPB->processor_offset + (unsigned long) INIT_HWRPB);
  	rev = percpu->pal_revision = percpu->palcode_avail[2];

-	srm_printk("Ok (rev %lx)\n", rev);
+	srm_printk("OK (rev %lx)\n", rev);

  	tbia(); /* do it directly in case we are SMP */
  }
@@ -183,7 +183,7 @@ void start_kernel(void)
  	envval[nbytes] = '\0';
  	strcpy((char*)ZERO_PGE, envval);

-	srm_printk(" Ok\nNow booting the kernel\n");
+	srm_printk(" OK\nNow booting the kernel\n");
  	runkernel();
  	for (i = 0 ; i < 0x100000000 ; i++)
  		/* nothing */;
diff -uprN --exclude='*~*' linux-2.6.9.orig/arch/i386/boot/compressed/misc.c linux-2.6.9/arch/i386/boot/compressed/misc.c
--- linux-2.6.9.orig/arch/i386/boot/compressed/misc.c	2004-10-18 13:54:32.000000000 -0800
+++ linux-2.6.9/arch/i386/boot/compressed/misc.c	2005-05-28 01:27:54.000000000 -0800
@@ -376,7 +376,7 @@ asmlinkage int decompress_kernel(struct
  	makecrc();
  	putstr("Uncompressing Linux... ");
  	gunzip();
-	putstr("Ok, booting the kernel.\n");
+	putstr("OK, booting the kernel.\n");
  	if (high_loaded) close_output_buffer_if_we_run_high(mv);
  	return high_loaded;
  }
diff -uprN --exclude='*~*' linux-2.6.9.orig/arch/i386/mm/init.c linux-2.6.9/arch/i386/mm/init.c
--- linux-2.6.9.orig/arch/i386/mm/init.c	2004-10-18 13:54:54.000000000 -0800
+++ linux-2.6.9/arch/i386/mm/init.c	2005-05-28 02:14:18.000000000 -0800
@@ -541,7 +541,7 @@ void __init test_wp_bit(void)
  		panic("This kernel doesn't support CPU's with broken WP. Recompile it for a 386!");
  #endif
  	} else {
-		printk("Ok.\n");
+		printk("OK.\n");
  	}
  }

diff -uprN --exclude='*~*' linux-2.6.9.orig/arch/m32r/boot/compressed/misc.c linux-2.6.9/arch/m32r/boot/compressed/misc.c
--- linux-2.6.9.orig/arch/m32r/boot/compressed/misc.c	2004-10-18 13:53:22.000000000 -0800
+++ linux-2.6.9/arch/m32r/boot/compressed/misc.c	2005-05-28 01:29:03.000000000 -0800
@@ -218,6 +218,6 @@ long decompress_kernel(void)
  	makecrc();
  	puts("Uncompressing Linux... ");
  	gunzip();
-	puts("Ok, booting the kernel.\n");
+	puts("OK, booting the kernel.\n");
  	return bytes_out;
  }
diff -uprN --exclude='*~*' linux-2.6.9.orig/arch/sh/boot/compressed/misc.c linux-2.6.9/arch/sh/boot/compressed/misc.c
--- linux-2.6.9.orig/arch/sh/boot/compressed/misc.c	2004-10-18 13:53:43.000000000 -0800
+++ linux-2.6.9/arch/sh/boot/compressed/misc.c	2005-05-28 01:28:27.000000000 -0800
@@ -236,5 +236,5 @@ void decompress_kernel(void)
  	makecrc();
  	puts("Uncompressing Linux... ");
  	gunzip();
-	puts("Ok, booting the kernel.\n");
+	puts("OK, booting the kernel.\n");
  }
diff -uprN --exclude='*~*' linux-2.6.9.orig/arch/sh64/boot/compressed/misc.c linux-2.6.9/arch/sh64/boot/compressed/misc.c
--- linux-2.6.9.orig/arch/sh64/boot/compressed/misc.c	2004-10-18 13:53:45.000000000 -0800
+++ linux-2.6.9/arch/sh64/boot/compressed/misc.c	2005-05-28 01:28:42.000000000 -0800
@@ -245,7 +245,7 @@ void decompress_kernel(void)
  	}
  #endif

-	puts("Ok, booting the kernel.\n");
+	puts("OK, booting the kernel.\n");

  	cache_control(CACHE_DISABLE);
  }
diff -uprN --exclude='*~*' linux-2.6.9.orig/drivers/base/power/shutdown.c linux-2.6.9/drivers/base/power/shutdown.c
--- linux-2.6.9.orig/drivers/base/power/shutdown.c	2004-10-18 13:54:37.000000000 -0800
+++ linux-2.6.9/drivers/base/power/shutdown.c	2005-05-28 01:34:58.000000000 -0800
@@ -55,7 +55,7 @@ void device_shutdown(void)
  	list_for_each_entry_reverse(dev, &devices_subsys.kset.list, kobj.entry) {
  		pr_debug("shutting down %s: ", dev->bus_id);
  		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("Ok\n");
+			pr_debug("OK\n");
  			dev->driver->shutdown(dev);
  		} else
  			pr_debug("Ignored.\n");
diff -uprN --exclude='*~*' linux-2.6.9.orig/drivers/media/video/bttv-driver.c linux-2.6.9/drivers/media/video/bttv-driver.c
--- linux-2.6.9.orig/drivers/media/video/bttv-driver.c	2004-10-18 13:54:54.000000000 -0800
+++ linux-2.6.9/drivers/media/video/bttv-driver.c	2005-05-28 01:32:39.000000000 -0800
@@ -3228,14 +3228,14 @@ static void bttv_irq_debug_low_latency(s
  	       (unsigned long)rc);

  	if (0 == (btread(BT848_DSTATUS) & BT848_DSTATUS_HLOC)) {
-		printk("bttv%d: Oh, there (temporarely?) is no input signal. "
-		       "Ok, then this is harmless, don't worry ;)\n",
+		printk("bttv%d: Oh, there (temporarily?) is no input signal. "
+		       "OK, then this is harmless, don't worry ;)\n",
  		       btv->c.nr);
  		return;
  	}
  	printk("bttv%d: Uhm. Looks like we have unusual high IRQ latencies.\n",
  	       btv->c.nr);
-	printk("bttv%d: Lets try to catch the culpit red-handed ...\n",
+	printk("bttv%d: Let's try to catch the culprit red-handed ...\n",
  	       btv->c.nr);
  	dump_stack();
  }

