Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbUKIHyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUKIHyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUKIHyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:54:02 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:13475 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261427AbUKIHvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:51:43 -0500
Date: Tue, 9 Nov 2004 18:51:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [3/6] PPC64 iSeries remove some Studly Caps
Message-Id: <20041109185131.29e6eabd.sfr@canb.auug.org.au>
In-Reply-To: <20041109184813.1a6e02cf.sfr@canb.auug.org.au>
References: <20041109184223.16ea3414.sfr@canb.auug.org.au>
	<20041109184551.03b8a32c.sfr@canb.auug.org.au>
	<20041109184813.1a6e02cf.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__9_Nov_2004_18_51_31_+1100_2K1Hyh9.pLfyIyH5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__9_Nov_2004_18_51_31_+1100_2K1Hyh9.pLfyIyH5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch changes the externally referenced names in mf.c to not use
Study Caps and removes a couple of no longer used functions.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-mf.0.6/arch/ppc64/kernel/iSeries_pci.c linus-bk-mf.0.7/arch/ppc64/kernel/iSeries_pci.c
--- linus-bk-mf.0.6/arch/ppc64/kernel/iSeries_pci.c	2004-11-08 16:21:10.000000000 +1100
+++ linus-bk-mf.0.7/arch/ppc64/kernel/iSeries_pci.c	2004-11-09 16:42:02.000000000 +1100
@@ -309,7 +309,7 @@
 	PPCDBG(PPCDBG_BUSWALK, "iSeries_pcibios_fixup Entry.\n"); 
 
 	/* Fix up at the device node and pci_dev relationship */
-	mf_displaySrc(0xC9000100);
+	mf_display_src(0xC9000100);
 
 	printk("pcibios_final_fixup\n");
 	for_each_pci_dev(pdev) {
@@ -335,7 +335,7 @@
 		pdev->irq = node->Irq;
 	}
 	iSeries_activate_IRQs();
-	mf_displaySrc(0xC9000200);
+	mf_display_src(0xC9000200);
 }
 
 void pcibios_fixup_bus(struct pci_bus *PciBus)
@@ -677,7 +677,7 @@
 		 */
 		if ((DevNode->IoRetry > Pci_Retry_Max) &&
 				(Pci_Error_Flag > 0)) {
-			mf_displaySrc(0xB6000103);
+			mf_display_src(0xB6000103);
 			panic_timeout = 0; 
 			panic("PCI: Hardware I/O Error, SRC B6000103, "
 					"Automatic Reboot Disabled.\n");
diff -ruN linus-bk-mf.0.6/arch/ppc64/kernel/iSeries_setup.c linus-bk-mf.0.7/arch/ppc64/kernel/iSeries_setup.c
--- linus-bk-mf.0.6/arch/ppc64/kernel/iSeries_setup.c	2004-09-24 15:23:06.000000000 +1000
+++ linus-bk-mf.0.7/arch/ppc64/kernel/iSeries_setup.c	2004-11-09 16:48:02.000000000 +1100
@@ -732,7 +732,7 @@
  */
 void iSeries_power_off(void)
 {
-	mf_powerOff();
+	mf_power_off();
 }
 
 /*
@@ -740,7 +740,7 @@
  */
 void iSeries_halt(void)
 {
-	mf_powerOff();
+	mf_power_off();
 }
 
 /* JDH Hack */
@@ -796,9 +796,9 @@
 	printk("Progress: [%04x] - %s\n", (unsigned)code, st);
 	if (!piranha_simulator && mf_initialized) {
 		if (code != 0xffff)
-			mf_displayProgress(code);
+			mf_display_progress(code);
 		else
-			mf_clearSrc();
+			mf_clear_src();
 	}
 }
 
diff -ruN linus-bk-mf.0.6/arch/ppc64/kernel/mf.c linus-bk-mf.0.7/arch/ppc64/kernel/mf.c
--- linus-bk-mf.0.6/arch/ppc64/kernel/mf.c	2004-11-09 16:39:08.000000000 +1100
+++ linus-bk-mf.0.7/arch/ppc64/kernel/mf.c	2004-11-09 17:27:46.000000000 +1100
@@ -357,7 +357,7 @@
 	if (rc) {
 		printk(KERN_ALERT "mf.c: SIGINT to init failed (%d), "
 				"hard shutdown commencing\n", rc);
-		mf_powerOff();
+		mf_power_off();
 	} else
 		printk(KERN_INFO "mf.c: init has been successfully notified "
 				"to proceed with shutdown\n");
@@ -533,7 +533,7 @@
  * Global kernel interface to allocate and seed events into the
  * Hypervisor.
  */
-void mf_allocateLpEvents(HvLpIndex targetLp, HvLpEvent_Type type,
+void mf_allocate_lp_events(HvLpIndex targetLp, HvLpEvent_Type type,
 		unsigned size, unsigned count, MFCompleteHandler hdlr,
 		void *userToken)
 {
@@ -560,13 +560,13 @@
 	if ((rc != 0) && (hdlr != NULL))
 		(*hdlr)(userToken, rc);
 }
-EXPORT_SYMBOL(mf_allocateLpEvents);
+EXPORT_SYMBOL(mf_allocate_lp_events);
 
 /*
  * Global kernel interface to unseed and deallocate events already in
  * Hypervisor.
  */
-void mf_deallocateLpEvents(HvLpIndex targetLp, HvLpEvent_Type type,
+void mf_deallocate_lp_events(HvLpIndex targetLp, HvLpEvent_Type type,
 		unsigned count, MFCompleteHandler hdlr, void *userToken)
 {
 	struct pending_event *ev = new_pending_event();
@@ -591,13 +591,13 @@
 	if ((rc != 0) && (hdlr != NULL))
 		(*hdlr)(userToken, rc);
 }
-EXPORT_SYMBOL(mf_deallocateLpEvents);
+EXPORT_SYMBOL(mf_deallocate_lp_events);
 
 /*
  * Global kernel interface to tell the VSP object in the primary
  * partition to power this partition off.
  */
-void mf_powerOff(void)
+void mf_power_off(void)
 {
 	printk(KERN_INFO "mf.c: Down it goes...\n");
 	signal_ce_msg("\x00\x00\x00\x4D\x00\x00\x00\x00\x00\x00\x00\x00", NULL);
@@ -618,7 +618,7 @@
 /*
  * Display a single word SRC onto the VSP control panel.
  */
-void mf_displaySrc(u32 word)
+void mf_display_src(u32 word)
 {
 	u8 ce[12];
 
@@ -633,7 +633,7 @@
 /*
  * Display a single word SRC of the form "PROGXXXX" on the VSP control panel.
  */
-void mf_displayProgress(u16 value)
+void mf_display_progress(u16 value)
 {
 	u8 ce[12];
 	u8 src[72];
@@ -657,7 +657,7 @@
  * Clear the VSP control panel.  Used to "erase" an SRC that was
  * previously displayed.
  */
-void mf_clearSrc(void)
+void mf_clear_src(void)
 {
 	signal_ce_msg("\x00\x00\x00\x4B\x00\x00\x00\x00\x00\x00\x00\x00", NULL);
 }
@@ -909,15 +909,6 @@
 	return rc;
 }
 
-int mf_setRtcTime(unsigned long time)
-{
-	struct rtc_time tm;
-
-	to_tm(time, &tm);
-
-	return mf_setRtc(&tm);
-}
-
 struct RtcTimeData {
 	struct completion com;
 	struct CeMsgData xCeMsg;
@@ -933,47 +924,7 @@
 	complete(&rtc->com);
 }
 
-static unsigned long lastsec = 1;
-
-int mf_getRtcTime(unsigned long *time)
-{
-	u32 dataWord1 = *((u32 *)(&xSpCommArea.xBcdTimeAtIplStart));
-	u32 dataWord2 = *(((u32 *)&(xSpCommArea.xBcdTimeAtIplStart)) + 1);
-	int year = 1970;
-	int year1 = (dataWord1 >> 24) & 0x000000FF;
-	int year2 = (dataWord1 >> 16) & 0x000000FF;
-	int sec = (dataWord1 >> 8) & 0x000000FF;
-	int min = dataWord1 & 0x000000FF;
-	int hour = (dataWord2 >> 24) & 0x000000FF;
-	int day = (dataWord2 >> 8) & 0x000000FF;
-	int mon = dataWord2 & 0x000000FF;
-
-	BCD_TO_BIN(sec);
-	BCD_TO_BIN(min);
-	BCD_TO_BIN(hour);
-	BCD_TO_BIN(day);
-	BCD_TO_BIN(mon);
-	BCD_TO_BIN(year1);
-	BCD_TO_BIN(year2);
-	year = year1 * 100 + year2;
-
-	*time = mktime(year, mon, day, hour, min, sec);
-	*time += (jiffies / HZ);
-
-	/*
-	 * Now THIS is a nasty hack!
-	 * It ensures that the first two calls to mf_getRtcTime get different
-	 * answers.  That way the loop in init_time (time.c) will not think
-	 * the clock is stuck.
-	 */
-	if (lastsec) {
-		*time -= lastsec;
-		--lastsec;
-	}
-	return 0;
-}
-
-int mf_getRtc(struct rtc_time *tm)
+int mf_get_rtc(struct rtc_time *tm)
 {
 	struct CeMsgCompleteData ceComplete;
 	struct RtcTimeData rtcData;
@@ -999,7 +950,7 @@
 				tm->tm_mday = 10;
 				tm->tm_mon = 8;
 				tm->tm_year = 71;
-				mf_setRtc(tm);
+				mf_set_rtc(tm);
 			}
 			{
 				u32 dataWord1 = *((u32 *)(rtcData.xCeMsg.ce_msg+4));
@@ -1046,7 +997,7 @@
 	return rc;
 }
 
-int mf_setRtc(struct rtc_time * tm)
+int mf_set_rtc(struct rtc_time * tm)
 {
 	char ceTime[12] = "\x00\x00\x00\x41\x00\x00\x00\x00\x00\x00\x00\x00";
 	u8 day, mon, hour, min, sec, y1, y2;
@@ -1210,9 +1161,9 @@
 		return -EFAULT;
 
 	if ((count == 1) && (*stkbuf == '\0'))
-		mf_clearSrc();
+		mf_clear_src();
 	else
-		mf_displaySrc(*(u32 *)stkbuf);
+		mf_display_src(*(u32 *)stkbuf);
 
 	return count;
 }
diff -ruN linus-bk-mf.0.6/arch/ppc64/kernel/rtc.c linus-bk-mf.0.7/arch/ppc64/kernel/rtc.c
--- linus-bk-mf.0.6/arch/ppc64/kernel/rtc.c	2004-09-09 09:59:49.000000000 +1000
+++ linus-bk-mf.0.7/arch/ppc64/kernel/rtc.c	2004-11-09 16:50:00.000000000 +1100
@@ -275,7 +275,7 @@
 	if (piranha_simulator)
 		return;
 
-	mf_getRtc(rtc_tm);
+	mf_get_rtc(rtc_tm);
 	rtc_tm->tm_mon--;
 }
 
@@ -285,7 +285,7 @@
  */
 int iSeries_set_rtc_time(struct rtc_time *tm)
 {
-	mf_setRtc(tm);
+	mf_set_rtc(tm);
 	return 0;
 }
 
diff -ruN linus-bk-mf.0.6/arch/ppc64/kernel/viopath.c linus-bk-mf.0.7/arch/ppc64/kernel/viopath.c
--- linus-bk-mf.0.6/arch/ppc64/kernel/viopath.c	2004-09-09 09:59:49.000000000 +1000
+++ linus-bk-mf.0.7/arch/ppc64/kernel/viopath.c	2004-11-09 16:46:36.000000000 +1100
@@ -473,7 +473,7 @@
 		parms.used_wait_atomic = 0;
 		parms.sem = &Semaphore;
 	}
-	mf_allocateLpEvents(remoteLp, HvLpEvent_Type_VirtualIo, 250,	/* It would be nice to put a real number here! */
+	mf_allocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo, 250,	/* It would be nice to put a real number here! */
 			    numEvents, &viopath_donealloc, &parms);
 	if (in_atomic()) {
 		while (atomic_read(&wait_atomic))
@@ -582,7 +582,7 @@
 
 	doneAllocParms.used_wait_atomic = 0;
 	doneAllocParms.sem = &Semaphore;
-	mf_deallocateLpEvents(remoteLp, HvLpEvent_Type_VirtualIo,
+	mf_deallocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo,
 			      numReq, &viopath_donealloc, &doneAllocParms);
 	down(&Semaphore);
 
diff -ruN linus-bk-mf.0.6/drivers/net/iseries_veth.c linus-bk-mf.0.7/drivers/net/iseries_veth.c
--- linus-bk-mf.0.6/drivers/net/iseries_veth.c	2004-10-20 21:20:19.000000000 +1000
+++ linus-bk-mf.0.7/drivers/net/iseries_veth.c	2004-11-09 16:47:08.000000000 +1100
@@ -248,7 +248,7 @@
 {
 	struct veth_allocation vc = { COMPLETION_INITIALIZER(vc.c), 0 };
 
-	mf_allocateLpEvents(rlp, HvLpEvent_Type_VirtualLan,
+	mf_allocate_lp_events(rlp, HvLpEvent_Type_VirtualLan,
 			    sizeof(struct VethLpEvent), number,
 			    &veth_complete_allocation, &vc);
 	wait_for_completion(&vc.c);
@@ -662,12 +662,12 @@
 	del_timer_sync(&cnx->ack_timer);
 
 	if (cnx->num_events > 0)
-		mf_deallocateLpEvents(cnx->remote_lp,
+		mf_deallocate_lp_events(cnx->remote_lp,
 				      HvLpEvent_Type_VirtualLan,
 				      cnx->num_events,
 				      NULL, NULL);
 	if (cnx->num_ack_events > 0)
-		mf_deallocateLpEvents(cnx->remote_lp,
+		mf_deallocate_lp_events(cnx->remote_lp,
 				      HvLpEvent_Type_VirtualLan,
 				      cnx->num_ack_events,
 				      NULL, NULL);
diff -ruN linus-bk-mf.0.6/include/asm-ppc64/iSeries/mf.h linus-bk-mf.0.7/include/asm-ppc64/iSeries/mf.h
--- linus-bk-mf.0.6/include/asm-ppc64/iSeries/mf.h	2004-03-17 22:09:24.000000000 +1100
+++ linus-bk-mf.0.7/include/asm-ppc64/iSeries/mf.h	2004-11-09 17:27:54.000000000 +1100
@@ -1,6 +1,7 @@
 /*
  * mf.h
  * Copyright (C) 2001  Troy D. Armstrong IBM Corporation
+ * Copyright (C) 2004  Stephen Rothwell IBM Corporation
  *
  * This modules exists as an interface between a Linux secondary partition
  * running on an iSeries and the primary partition's Virtual Service
@@ -35,18 +36,18 @@
 
 typedef void (*MFCompleteHandler)(void *clientToken, int returnCode);
 
-extern void mf_allocateLpEvents(HvLpIndex targetLp, HvLpEvent_Type type,
+extern void mf_allocate_lp_events(HvLpIndex targetLp, HvLpEvent_Type type,
 		unsigned size, unsigned amount, MFCompleteHandler hdlr,
 		void *userToken);
-extern void mf_deallocateLpEvents(HvLpIndex targetLp, HvLpEvent_Type type,
+extern void mf_deallocate_lp_events(HvLpIndex targetLp, HvLpEvent_Type type,
 		unsigned count, MFCompleteHandler hdlr, void *userToken);
 
-extern void mf_powerOff(void);
+extern void mf_power_off(void);
 extern void mf_reboot(void);
 
-extern void mf_displaySrc(u32 word);
-extern void mf_displayProgress(u16 value);
-extern void mf_clearSrc(void);
+extern void mf_display_src(u32 word);
+extern void mf_display_progress(u16 value);
+extern void mf_clear_src(void);
 
 extern void mf_init(void);
 
@@ -62,9 +63,7 @@
 		u64 side);
 extern int mf_getVmlinuxChunk(char *buffer, int *size, int offset, u64 side);
 
-extern int mf_setRtcTime(unsigned long time);
-extern int mf_getRtcTime(unsigned long *time);
-extern int mf_getRtc( struct rtc_time * tm );
-extern int mf_setRtc( struct rtc_time * tm );
+extern int mf_get_rtc(struct rtc_time *tm);
+extern int mf_set_rtc(struct rtc_time *tm);
 
 #endif /* MF_H_INCLUDED */

--Signature=_Tue__9_Nov_2004_18_51_31_+1100_2K1Hyh9.pLfyIyH5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkHcD4CJfqux9a+8RAm8aAJ9h4KPi8+SKncLg6SZQV06d197QcQCdHX58
pphysSgQZ0XJB1M+liakcVY=
=XpvK
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Nov_2004_18_51_31_+1100_2K1Hyh9.pLfyIyH5--
