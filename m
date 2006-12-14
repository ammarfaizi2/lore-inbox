Return-Path: <linux-kernel-owner+w=401wt.eu-S932708AbWLNNX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWLNNX7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbWLNNX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:23:59 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:41096 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708AbWLNNX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:23:58 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 14 Dec 2006 08:17:30 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] Various typo fixes.
Message-ID: <Pine.LNX.4.64.0612140815030.17756@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	timed out)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Correct mis-spellings of "algorithm", "appear", "consistent" and
(shame, shame) "kernel".

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

 Documentation/video4linux/bttv/Insmod-options |    2 +-
 arch/m32r/lib/usercopy.c                      |    4 ++--
 arch/m68knommu/platform/5307/timers.c         |    2 +-
 drivers/infiniband/hw/ipath/ipath_iba6110.c   |    2 +-
 drivers/infiniband/hw/ipath/ipath_iba6120.c   |    2 +-
 drivers/isdn/i4l/isdn_ppp.c                   |    2 +-
 drivers/net/e1000/e1000_hw.h                  |    2 +-
 drivers/net/wireless/wavelan_cs.c             |    8 ++++----
 drivers/sbus/char/vfc_i2c.c                   |    2 +-
 include/linux/seqlock.h                       |    2 +-
 lib/textsearch.c                              |    2 +-
 net/ipv4/tcp_cong.c                           |    2 +-
 12 files changed, 16 insertions(+), 16 deletions(-)


diff --git a/Documentation/video4linux/bttv/Insmod-options b/Documentation/video4linux/bttv/Insmod-options
index bb7c2ca..5ef7578 100644
--- a/Documentation/video4linux/bttv/Insmod-options
+++ b/Documentation/video4linux/bttv/Insmod-options
@@ -57,7 +57,7 @@ bttv.o
 		i2c_udelay=     Allow reduce I2C speed. Default is 5 usecs
 				(meaning 66,67 Kbps). The default is the
 				maximum supported speed by kernel bitbang
-				algoritm. You may use lower numbers, if I2C
+				algorithm. You may use lower numbers, if I2C
 				messages are lost (16 is known to work on
 				all supported cards).

diff --git a/arch/m32r/lib/usercopy.c b/arch/m32r/lib/usercopy.c
index 896cef1..82abd15 100644
--- a/arch/m32r/lib/usercopy.c
+++ b/arch/m32r/lib/usercopy.c
@@ -293,7 +293,7 @@ long strnlen_user(const char __user *s, long n)
 		: "0" (n), "1" (s), "r" (n & 3), "r" (mask), "r"(0x01010101)
 		: "r0", "r1", "cbit");

-	/* NOTE: strnlen_user() algorism:
+	/* NOTE: strnlen_user() algorithm:
 	 * {
 	 *   char *p;
 	 *   for (p = s; n-- && *p != '\0'; ++p)
@@ -369,7 +369,7 @@ long strnlen_user(const char __user *s, long n)
 		: "0" (n), "1" (s), "r" (n & 3), "r" (mask), "r"(0x01010101)
 		: "r0", "r1", "r2", "r3", "cbit");

-	/* NOTE: strnlen_user() algorism:
+	/* NOTE: strnlen_user() algorithm:
 	 * {
 	 *   char *p;
 	 *   for (p = s; n-- && *p != '\0'; ++p)
diff --git a/arch/m68knommu/platform/5307/timers.c b/arch/m68knommu/platform/5307/timers.c
index e5668af..b2d8e61 100644
--- a/arch/m68knommu/platform/5307/timers.c
+++ b/arch/m68knommu/platform/5307/timers.c
@@ -104,7 +104,7 @@ unsigned long coldfire_timer_offset(void)

 /*
  *	Choose a reasonably fast profile timer. Make it an odd value to
- *	try and get good coverage of kernal operations.
+ *	try and get good coverage of kernel operations.
  */
 #define	PROFILEHZ	1013

diff --git a/drivers/infiniband/hw/ipath/ipath_iba6110.c b/drivers/infiniband/hw/ipath/ipath_iba6110.c
index 7468477..9934825 100644
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c
@@ -1534,7 +1534,7 @@ static int ipath_ht_early_init(struct ipath_devdata *dd)
  * @kbase: ipath_base_info pointer
  *
  * We set the PCIE flag because the lower bandwidth on PCIe vs
- * HyperTransport can affect some user packet algorithims.
+ * HyperTransport can affect some user packet algorithms.
  */
 static int ipath_ht_get_base_info(struct ipath_portdata *pd, void *kbase)
 {
diff --git a/drivers/infiniband/hw/ipath/ipath_iba6120.c b/drivers/infiniband/hw/ipath/ipath_iba6120.c
index ae8bf99..05918e1 100644
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c
@@ -1293,7 +1293,7 @@ int __attribute__((weak)) ipath_unordered_wc(void)
  * @kbase: ipath_base_info pointer
  *
  * We set the PCIE flag because the lower bandwidth on PCIe vs
- * HyperTransport can affect some user packet algorithims.
+ * HyperTransport can affect some user packet algorithms.
  */
 static int ipath_pe_get_base_info(struct ipath_portdata *pd, void *kbase)
 {
diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
index 1726131..87115b8 100644
--- a/drivers/isdn/i4l/isdn_ppp.c
+++ b/drivers/isdn/i4l/isdn_ppp.c
@@ -1680,7 +1680,7 @@ static void isdn_ppp_mp_receive(isdn_net_dev * net_dev, isdn_net_local * lp,
 	 * - we hit a gap in the sequence, so no reassembly/processing is
 	 *   possible ('start' would be set to NULL)
 	 *
-	 * algorightm for this code is derived from code in the book
+	 * algorithm for this code is derived from code in the book
 	 * 'PPP Design And Debugging' by James Carlson (Addison-Wesley)
 	 */
   	while (start != NULL || newfrag != NULL) {
diff --git a/drivers/net/e1000/e1000_hw.h b/drivers/net/e1000/e1000_hw.h
index 3321fb1..7f5c90f 100644
--- a/drivers/net/e1000/e1000_hw.h
+++ b/drivers/net/e1000/e1000_hw.h
@@ -3247,7 +3247,7 @@ struct e1000_host_command_info {
 #define IFE_PMC_AUTO_MDIX                    0x0080  /* 1=enable MDI/MDI-X feature, default 0=disabled */
 #define IFE_PMC_FORCE_MDIX                   0x0040  /* 1=force MDIX-X, 0=force MDI */
 #define IFE_PMC_MDIX_STATUS                  0x0020  /* 1=MDI-X, 0=MDI */
-#define IFE_PMC_AUTO_MDIX_COMPLETE           0x0010  /* Resolution algorthm is completed */
+#define IFE_PMC_AUTO_MDIX_COMPLETE           0x0010  /* Resolution algorithm is completed */
 #define IFE_PMC_MDIX_MODE_SHIFT              6
 #define IFE_PHC_MDIX_RESET_ALL_MASK          0x0000  /* Disable auto MDI-X */

diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index 5eb8163..b042397 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -1168,7 +1168,7 @@ wv_mmc_show(struct net_device *	dev)
 	 m.mmr_unused0[6],
 	 m.mmr_unused0[7]);
 #endif	/* DEBUG_SHOW_UNUSED */
-  printk(KERN_DEBUG "Encryption algorythm: %02X - Status: %02X\n",
+  printk(KERN_DEBUG "Encryption algorithm: %02X - Status: %02X\n",
 	 m.mmr_des_avail, m.mmr_des_status);
 #ifdef DEBUG_SHOW_UNUSED
   printk(KERN_DEBUG "mmc_unused1[]: %02X:%02X:%02X:%02X:%02X\n",
@@ -3590,9 +3590,9 @@ wv_82593_config(struct net_device *	dev)
   cfblk.acloc = TRUE;           /* Disable source addr insertion by i82593 */
   cfblk.preamb_len = 0;         /* 2 bytes preamble (SFD) */
   cfblk.loopback = FALSE;
-  cfblk.lin_prio = 0;   	/* conform to 802.3 backoff algoritm */
-  cfblk.exp_prio = 5;	        /* conform to 802.3 backoff algoritm */
-  cfblk.bof_met = 1;	        /* conform to 802.3 backoff algoritm */
+  cfblk.lin_prio = 0;   	/* conform to 802.3 backoff algorithm */
+  cfblk.exp_prio = 5;	        /* conform to 802.3 backoff algorithm */
+  cfblk.bof_met = 1;	        /* conform to 802.3 backoff algorithm */
   cfblk.ifrm_spc = 0x20 >> 4;	/* 32 bit times interframe spacing */
   cfblk.slottim_low = 0x20 >> 5;	/* 32 bit times slot time */
   cfblk.slottim_hi = 0x0;
diff --git a/drivers/sbus/char/vfc_i2c.c b/drivers/sbus/char/vfc_i2c.c
index ceec306..9efed77 100644
--- a/drivers/sbus/char/vfc_i2c.c
+++ b/drivers/sbus/char/vfc_i2c.c
@@ -14,7 +14,7 @@
 /* NOTE: It seems to me that the documentation regarding the
 pcd8584t/pcf8584 does not show the correct way to address the i2c bus.
 Based on the information on the I2C bus itself and the remainder of
-the Phillips docs the following algorithims apper to be correct.  I am
+the Phillips docs the following algorithms appear to be correct.  I am
 fairly certain that the flowcharts in the phillips docs are wrong. */


diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 6b0648c..52c9eb9 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -2,7 +2,7 @@
 #define __LINUX_SEQLOCK_H
 /*
  * Reader/writer consistent mechanism without starving writers. This type of
- * lock for data where the reader wants a consitent set of information
+ * lock for data where the reader wants a consistent set of information
  * and is willing to retry if the information changes.  Readers never
  * block but they may have to retry if a writer is in
  * progress. Writers do not wait for readers.
diff --git a/lib/textsearch.c b/lib/textsearch.c
index 98bcadc..0dd98eb 100644
--- a/lib/textsearch.c
+++ b/lib/textsearch.c
@@ -40,7 +40,7 @@
  *       configuration according to the specified parameters.
  *   (3) User starts the search(es) by calling _find() or _next() to
  *       fetch subsequent occurrences. A state variable is provided
- *       to the algorihtm to store persistent variables.
+ *       to the algorithm to store persistent variables.
  *   (4) Core eventually resets the search offset and forwards the find()
  *       request to the algorithm.
  *   (5) Algorithm calls get_next_block() provided by the user continously
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 5ca7723..7c1a87d 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -29,7 +29,7 @@ static struct tcp_congestion_ops *tcp_ca_find(const char *name)
 }

 /*
- * Attach new congestion control algorthim to the list
+ * Attach new congestion control algorithm to the list
  * of available options.
  */
 int tcp_register_congestion_control(struct tcp_congestion_ops *ca)
