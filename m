Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274454AbRIYDby>; Mon, 24 Sep 2001 23:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274451AbRIYDbn>; Mon, 24 Sep 2001 23:31:43 -0400
Received: from hermes.toad.net ([162.33.130.251]:49634 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S274455AbRIYDbU>;
	Mon, 24 Sep 2001 23:31:20 -0400
Message-ID: <3BAFFA6F.8D9DC309@yahoo.co.uk>
Date: Mon, 24 Sep 2001 23:30:55 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] airo.c code formatting
Content-Type: multipart/mixed;
 boundary="------------724437F474FE1BD33C86B5DC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------724437F474FE1BD33C86B5DC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have received word that the Aironet driver in the kernel
is the most up to date.

The attached patch just corrects a few spelling mistakes and
makes the coding style consistent within the file
drivers/net/wireless/airo.c .  

--
Thomas Hood
--------------724437F474FE1BD33C86B5DC
Content-Type: text/plain; charset=us-ascii;
 name="airo-prettify-patch-20010924-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="airo-prettify-patch-20010924-1"

--- linux-2.4.9-ac13-mwave/drivers/net/wireless/airo.c_ORIG	Fri Sep 21 15:23:18 2001
+++ linux-2.4.9-ac13-mwave/drivers/net/wireless/airo.c	Mon Sep 24 23:17:54 2001
@@ -1,6 +1,7 @@
 /*======================================================================
 
-    Aironet driver for 4500 and 4800 series cards
+    Driver for Aironet 4500 and 4800 series cards
+    and for Cisco Aironet 340 and 350 series cards
 
     This code is released under both the GPL version 2 and BSD licenses.
     Either license may be used.  The respective licenses are found at
@@ -82,7 +83,7 @@
 #include <linux/delay.h>
 #endif
 
-/* As you can see this list is HUGH!
+/* As you can see this list is HUGE!
    I really don't know what a lot of these counts are about, but they
    are all here for completeness.  If the IGNLABEL macro is put in
    infront of the label, that statistic will not be included in the list
@@ -207,13 +208,12 @@
 static int io[4];
 static int irq[4];
 
-static
-int maxencrypt /* = 0 */; /* The highest rate that the card can encrypt at.
-		       0 means no limit.  For old cards this was 4 */
+static int maxencrypt /* = 0 */; /* The highest rate that the card can encrypt at.
+                                    0 means no limit.  For old cards this was 4 */
 
 static int auto_wep /* = 0 */; /* If set, it tries to figure out the wep mode */
 static int aux_bap /* = 0 */; /* Checks to see if the aux ports are needed to read
-		    the bap, needed on some older cards and buses. */   
+                                 the bap, needed on some older cards and buses. */   
 static int adhoc;
 
 static int proc_uid /* = 0 */;
@@ -226,10 +226,10 @@
 
 MODULE_AUTHOR("Benjamin Reed");
 MODULE_DESCRIPTION("Support for Cisco/Aironet 802.11 wireless ethernet \
-                   cards.  Direct support for ISA/PCI cards and support \
-		   for PCMCIA when used with airo_cs.");
+cards.  Direct support for ISA/PCI cards and support \
+for PCMCIA when used with airo_cs.");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_SUPPORTED_DEVICE("Aironet 4500, 4800 and Cisco 340");
+MODULE_SUPPORTED_DEVICE("Aironet 4500 and 4800 and Cisco Aironet 340 and 350");
 MODULE_PARM(io,"1-4i");
 MODULE_PARM(irq,"1-4i");
 MODULE_PARM(basic_rate,"i");
@@ -249,7 +249,7 @@
 encryption.  Units are in 512kbs.  Zero (default) means there is no limit. \
 Older cards used to be limited to 2mbs (4).");
 MODULE_PARM(adhoc, "i");
-MODULE_PARM_DESC(adhoc, "If non-zero, the card will start in adhoc mode.");
+MODULE_PARM_DESC(adhoc, "If non-zero, the card will start in ad-hoc mode.");
 
 MODULE_PARM(proc_uid, "i");
 MODULE_PARM_DESC(proc_uid, "The uid that the /proc files will belong to.");
@@ -340,24 +340,24 @@
 #define IGNORE_INTS ( EV_CMD | EV_UNKNOWN)
 
 /* The RIDs */
-#define RID_CAPABILITIES 0xFF00
-#define RID_CONFIG     0xFF10
-#define RID_SSID       0xFF11
-#define RID_APLIST     0xFF12
-#define RID_DRVNAME    0xFF13
-#define RID_ETHERENCAP 0xFF14
-#define RID_WEP_TEMP   0xFF15
-#define RID_WEP_PERM   0xFF16
-#define RID_MODULATION 0xFF17
-#define RID_ACTUALCONFIG 0xFF20 /*readonly*/
-#define RID_LEAPUSERNAME 0xFF23
-#define RID_LEAPPASSWORD 0xFF24
-#define RID_STATUS     0xFF50
-#define RID_STATS      0xFF68
-#define RID_STATSDELTA 0xFF69
+#define RID_CAPABILITIES    0xFF00
+#define RID_CONFIG          0xFF10
+#define RID_SSID            0xFF11
+#define RID_APLIST          0xFF12
+#define RID_DRVNAME         0xFF13
+#define RID_ETHERENCAP      0xFF14
+#define RID_WEP_TEMP        0xFF15
+#define RID_WEP_PERM        0xFF16
+#define RID_MODULATION      0xFF17
+#define RID_ACTUALCONFIG    0xFF20 /*readonly*/
+#define RID_LEAPUSERNAME    0xFF23
+#define RID_LEAPPASSWORD    0xFF24
+#define RID_STATUS          0xFF50
+#define RID_STATS           0xFF68
+#define RID_STATSDELTA      0xFF69
 #define RID_STATSDELTACLEAR 0xFF6A
-#define RID_BSSLISTFIRST 0xFF72
-#define RID_BSSLISTNEXT  0xFF73
+#define RID_BSSLISTFIRST    0xFF72
+#define RID_BSSLISTNEXT     0xFF73
 
 typedef struct {
 	u16 cmd;
@@ -376,7 +376,7 @@
 /*
  * Rids and endian-ness:  The Rids will always be in cpu endian, since
  * this all the patches from the big-endian guys end up doing that.
- * so all rid access should use the read/writeXXXRid routines.
+ * so all rid access should use the read/writeXXXRid routines. 
  */
 
 /* This is redundant for x86 archs, but it seems necessary for ARM */
@@ -598,112 +598,112 @@
 } CapabilityRid;
 
 typedef struct {
-  u16 len;
-  u16 index; /* First is 0 and 0xffff means end of list */
+	u16 len;
+	u16 index; /* First is 0 and 0xffff means end of list */
 #define RADIO_FH 1 /* Frequency hopping radio type */
 #define RADIO_DS 2 /* Direct sequence radio type */
 #define RADIO_TMA 4 /* Proprietary radio used in old cards (2500) */
-  u16 radioType; 
-  u8 bssid[6]; /* Mac address of the BSS */
-  u8 zero;
-  u8 ssidLen;
-  u8 ssid[32];
-  u16 rssi;
+	u16 radioType; 
+	u8 bssid[6]; /* Mac address of the BSS */
+	u8 zero;
+	u8 ssidLen;
+	u8 ssid[32];
+	u16 rssi;
 #define CAP_ESS (1<<0)
 #define CAP_IBSS (1<<1)
 #define CAP_PRIVACY (1<<4)
 #define CAP_SHORTHDR (1<<5)
-  u16 cap;
-  u16 beaconInterval;
-  u8 rates[8]; /* Same as rates for config rid */
-  struct { /* For frequency hopping only */
-    u16 dwell;
-    u8 hopSet;
-    u8 hopPattern;
-    u8 hopIndex;
-    u8 fill;
-  } fh;
-  u16 dsChannel;
-  u16 atimWindow;
+	u16 cap;
+	u16 beaconInterval;
+	u8 rates[8]; /* Same as rates for config rid */
+	struct { /* For frequency hopping only */
+		u16 dwell;
+		u8 hopSet;
+		u8 hopPattern;
+		u8 hopIndex;
+		u8 fill;
+	} fh;
+	u16 dsChannel;
+	u16 atimWindow;
 } BSSListRid;
 
 #pragma pack()
 
-#define TXCTL_TXOK (1<<1) /* report if tx is ok */
-#define TXCTL_TXEX (1<<2) /* report if tx fails */
-#define TXCTL_802_3 (0<<3) /* 802.3 packet */
-#define TXCTL_802_11 (1<<3) /* 802.11 mac packet */
-#define TXCTL_ETHERNET (0<<4) /* payload has ethertype */
-#define TXCTL_LLC (1<<4) /* payload is llc */
-#define TXCTL_RELEASE (0<<5) /* release after completion */
+#define TXCTL_TXOK      (1<<1) /* report if tx is ok */
+#define TXCTL_TXEX      (1<<2) /* report if tx fails */
+#define TXCTL_802_3     (0<<3) /* 802.3 packet */
+#define TXCTL_802_11    (1<<3) /* 802.11 mac packet */
+#define TXCTL_ETHERNET  (0<<4) /* payload has ethertype */
+#define TXCTL_LLC       (1<<4) /* payload is llc */
+#define TXCTL_RELEASE   (0<<5) /* release after completion */
 #define TXCTL_NORELEASE (1<<5) /* on completion returns to host */
 
 #define BUSY_FID 0x10000
 
 #ifdef CISCO_EXT
-#define AIROMAGIC	0xa55a
-#define AIROIOCTL	SIOCDEVPRIVATE
-#define AIROIDIFC 	AIROIOCTL + 1
+#define AIROMAGIC       0xa55a
+#define AIROIOCTL       SIOCDEVPRIVATE
+#define AIROIDIFC       AIROIOCTL + 1
 
 /* Ioctl constants to be used in airo_ioctl.command */
 
-#define	AIROGCAP  		0	// Capability rid
-#define AIROGCFG		1       // USED A LOT 
-#define AIROGSLIST		2	// System ID list 
-#define AIROGVLIST		3       // List of specified AP's
-#define AIROGDRVNAM		4	//  NOTUSED
-#define AIROGEHTENC		5	// NOTUSED
-#define AIROGWEPKTMP		6
-#define AIROGWEPKNV		7
-#define AIROGSTAT		8
-#define AIROGSTATSC32		9
-#define AIROGSTATSD32		10
+#define AIROGCAP        0    // Capability rid
+#define AIROGCFG        1    // USED A LOT 
+#define AIROGSLIST      2    // System ID list 
+#define AIROGVLIST      3    // List of specified AP's
+#define AIROGDRVNAM     4    // NOT USED
+#define AIROGEHTENC     5    // NOT USED
+#define AIROGWEPKTMP    6
+#define AIROGWEPKNV     7
+#define AIROGSTAT       8
+#define AIROGSTATSC32   9
+#define AIROGSTATSD32   10
 
 /* Leave gap of 40 commands after AIROGSTATSD32 for future */
 
-#define AIROPCAP               	AIROGSTATSD32 + 40
-#define AIROPVLIST              AIROPCAP      + 1
-#define AIROPSLIST		AIROPVLIST    + 1
-#define AIROPCFG		AIROPSLIST    + 1
-#define AIROPSIDS		AIROPCFG      + 1
-#define AIROPAPLIST		AIROPSIDS     + 1
-#define AIROPMACON		AIROPAPLIST   + 1	/* Enable mac  */
-#define AIROPMACOFF		AIROPMACON    + 1 	/* Disable mac */
-#define AIROPSTCLR		AIROPMACOFF   + 1
-#define AIROPWEPKEY		AIROPSTCLR    + 1
-#define AIROPWEPKEYNV		AIROPWEPKEY   + 1
-#define AIROPLEAPPWD            AIROPWEPKEYNV + 1
-#define AIROPLEAPUSR            AIROPLEAPPWD  + 1
+#define AIROPCAP        AIROGSTATSD32 + 40
+#define AIROPVLIST      AIROPCAP      + 1
+#define AIROPSLIST      AIROPVLIST    + 1
+#define AIROPCFG        AIROPSLIST    + 1
+#define AIROPSIDS       AIROPCFG      + 1
+#define AIROPAPLIST     AIROPSIDS     + 1
+#define AIROPMACON      AIROPAPLIST   + 1    /* Enable mac  */
+#define AIROPMACOFF     AIROPMACON    + 1    /* Disable mac */
+#define AIROPSTCLR      AIROPMACOFF   + 1
+#define AIROPWEPKEY     AIROPSTCLR    + 1
+#define AIROPWEPKEYNV   AIROPWEPKEY   + 1
+#define AIROPLEAPPWD    AIROPWEPKEYNV + 1
+#define AIROPLEAPUSR    AIROPLEAPPWD  + 1
 
 /* Flash codes */
 
-#define AIROFLSHRST	       AIROPWEPKEYNV  + 40
-#define AIROFLSHGCHR           AIROFLSHRST    + 1
-#define AIROFLSHSTFL           AIROFLSHGCHR   + 1
-#define AIROFLSHPCHR           AIROFLSHSTFL   + 1
-#define AIROFLPUTBUF           AIROFLSHPCHR   + 1
-#define AIRORESTART            AIROFLPUTBUF   + 1
+#define AIROFLSHRST     AIROPWEPKEYNV  + 40
+#define AIROFLSHGCHR    AIROFLSHRST    + 1
+#define AIROFLSHSTFL    AIROFLSHGCHR   + 1
+#define AIROFLSHPCHR    AIROFLSHSTFL   + 1
+#define AIROFLPUTBUF    AIROFLSHPCHR   + 1
+#define AIRORESTART     AIROFLPUTBUF   + 1
 
-#define FLASHSIZE	32768
+#define FLASHSIZE   32768
 
 typedef struct aironet_ioctl {
-	unsigned short command;	// What to do
-	unsigned short len;		// Len of data
-	unsigned char *data;		// d-data
+	unsigned short command; // What to do
+	unsigned short len;     // Len of data
+	unsigned char *data;    // d-data
 } aironet_ioctl;
 #endif /* CISCO_EXT */
 
 #ifdef WIRELESS_EXT
 // Frequency list (map channels to frequencies)
 const long frequency_list[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
-				2447, 2452, 2457, 2462, 2467, 2472, 2484 };
+                                2447, 2452, 2457, 2462, 2467, 2472, 2484 };
 
 // A few details needed for WEP (Wireless Equivalent Privacy)
-#define MAX_KEY_SIZE 13			// 128 (?) bits
-#define MIN_KEY_SIZE  5			// 40 bits RC4 - WEP
+#define MAX_KEY_SIZE 13    // 128 (?) bits
+#define MIN_KEY_SIZE  5    // 40 bits RC4 - WEP
 typedef struct wep_key_t {
-	u16	len;
-	u8	key[16];	/* 40-bit and 104-bit keys */
+	u16  len;
+	u8   key[16]; /* 40-bit and 104-bit keys */
 } wep_key_t;
 #endif /* WIRELESS_EXT */
 
@@ -720,23 +720,23 @@
 static u16 issuecommand(struct airo_info*, Cmd *pCmd, Resp *pRsp);
 static int bap_setup(struct airo_info*, u16 rid, u16 offset, int whichbap);
 static int aux_bap_read(struct airo_info*, u16 *pu16Dst, int bytelen, 
-			int whichbap);
+                        int whichbap);
 static int fast_bap_read(struct airo_info*, u16 *pu16Dst, int bytelen, 
-			 int whichbap);
+                         int whichbap);
 static int bap_write(struct airo_info*, const u16 *pu16Src, int bytelen,
-		     int whichbap);
+                     int whichbap);
 static int PC4500_accessrid(struct airo_info*, u16 rid, u16 accmd);
 static int PC4500_readrid(struct airo_info*, u16 rid, void *pBuf, int len);
 static int PC4500_writerid(struct airo_info*, u16 rid, const void
-			   *pBuf, int len);
-static int do_writerid( struct airo_info*, u16 rid, const void *rid_data, 
-			int len );
+                           *pBuf, int len);
+static int do_writerid(struct airo_info*, u16 rid, const void *rid_data, 
+                       int len );
 static u16 transmit_allocate(struct airo_info*, int lenPayload);
 static int transmit_802_3_packet(struct airo_info*, u16 TxFid, char
-				 *pPacket, int len);
+                                 *pPacket, int len);
 
-static void airo_interrupt( int irq, void* dev_id, struct pt_regs
-			    *regs);
+static void airo_interrupt(int irq, void* dev_id, struct pt_regs
+                           *regs);
 static int airo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 #ifdef WIRELESS_EXT
 struct iw_statistics *airo_get_wireless_stats (struct net_device *dev);
@@ -750,68 +750,70 @@
 struct airo_info {
 	struct net_device_stats	stats;
 	int open;
-	struct net_device             *dev;
+	struct net_device *dev;
 	/* Note, we can have MAX_FIDS outstanding.  FIDs are 16-bits, so we
 	   use the high bit to mark wether it is in use. */
 #define MAX_FIDS 6
-	int                           fids[MAX_FIDS];
+	int fids[MAX_FIDS];
 	int registered;
 	ConfigRid config;
-	u16 authtype; // Used with auto_wep 
+	u16 authtype;  // Used with auto_wep 
 	char keyindex; // Used with auto wep
 	char defindex; // Used with auto wep
 	struct timer_list timer;
 	struct proc_dir_entry *proc_entry;
 	struct airo_info *next;
-        spinlock_t bap0_lock;
-        spinlock_t bap1_lock;
-        spinlock_t aux_lock;
-        spinlock_t cmd_lock;
-        int flags;
+	spinlock_t bap0_lock;
+	spinlock_t bap1_lock;
+	spinlock_t aux_lock;
+	spinlock_t cmd_lock;
+	int flags;
 #define FLAG_PROMISC   IFF_PROMISC
 #define FLAG_RADIO_OFF 0x02
 	int (*bap_read)(struct airo_info*, u16 *pu16Dst, int bytelen, 
-			int whichbap);
+	int whichbap);
 	int (*header_parse)(struct sk_buff*, unsigned char *);
 	unsigned short *flash;
 #ifdef WIRELESS_EXT
-	int			need_commit;	// Need to set config
-	struct iw_statistics	wstats;		// wireless stats
+	int need_commit;  // Need to set config
+	struct iw_statistics wstats;  // wireless stats
 #ifdef WIRELESS_SPY
-	int			spy_number;
-	u_char			spy_address[IW_MAX_SPY][6];
-	struct iw_quality	spy_stat[IW_MAX_SPY];
+	int spy_number;
+	u_char spy_address[IW_MAX_SPY][6];
+	struct iw_quality spy_stat[IW_MAX_SPY];
 #endif /* WIRELESS_SPY */
 #endif /* WIRELESS_EXT */
 };
 
 static inline int bap_read(struct airo_info *ai, u16 *pu16Dst, int bytelen, 
-			   int whichbap) {
+                           int whichbap)
+{
 	return ai->bap_read(ai, pu16Dst, bytelen, whichbap);
 }
 
-static int setup_proc_entry( struct net_device *dev,
-			     struct airo_info *apriv );
-static int takedown_proc_entry( struct net_device *dev,
-				struct airo_info *apriv );
+static int setup_proc_entry(struct net_device *dev,
+                            struct airo_info *apriv );
+static int takedown_proc_entry(struct net_device *dev,
+                               struct airo_info *apriv );
 
 static int readBSSListRid(struct airo_info *ai, int first,
-		      BSSListRid *list) {
+                          BSSListRid *list)
+{
 	int rc;
-			Cmd cmd;
-			Resp rsp;
+	Cmd cmd;
+	Resp rsp;
 
 	if (first == 1) {
-			memset(&cmd, 0, sizeof(cmd));
-			cmd.cmd=CMD_LISTBSS;
-			issuecommand(ai, &cmd, &rsp);
-			/* Let the command take effect */
-			set_current_state (TASK_INTERRUPTIBLE);
-			schedule_timeout (3*HZ);
-		}
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.cmd=CMD_LISTBSS;
+		issuecommand(ai, &cmd, &rsp);
+		/* Let the command take effect */
+		set_current_state (TASK_INTERRUPTIBLE);
+		schedule_timeout (3*HZ);
+	}
 	rc = PC4500_readrid(ai, 
-		            first ? RID_BSSLISTFIRST : RID_BSSLISTNEXT,
-			    list, sizeof(*list));
+	                    first ? RID_BSSLISTFIRST : RID_BSSLISTNEXT,
+	                    list, sizeof(*list));
 
 	list->len = le16_to_cpu(list->len);
 	list->index = le16_to_cpu(list->index);
@@ -824,18 +826,21 @@
 	return rc;
 }
 
-static int readWepKeyRid(struct airo_info*ai, WepKeyRid *wkr, int temp) {
+static int readWepKeyRid(struct airo_info*ai, WepKeyRid *wkr, int temp)
+{
 	int rc = PC4500_readrid(ai, temp ? RID_WEP_TEMP : RID_WEP_PERM, 
-				wkr, sizeof(*wkr));
-	
+                                wkr, sizeof(*wkr));
+
 	wkr->len = le16_to_cpu(wkr->len);
 	wkr->kindex = le16_to_cpu(wkr->kindex);
 	wkr->klen = le16_to_cpu(wkr->klen);
 	return rc;
 }
+
 /* In the writeXXXRid routines we copy the rids so that we don't screwup
  * the originals when we endian them... */
-static int writeWepKeyRid(struct airo_info*ai, WepKeyRid *pwkr, int perm) {
+static int writeWepKeyRid(struct airo_info*ai, WepKeyRid *pwkr, int perm)
+{
 	int rc;
 	WepKeyRid wkr = *pwkr;
 
@@ -853,7 +858,8 @@
 	return rc;
 }
 
-static int readSsidRid(struct airo_info*ai, SsidRid *ssidr) {
+static int readSsidRid(struct airo_info*ai, SsidRid *ssidr)
+{
 	int i;
 	int rc = PC4500_readrid(ai, RID_SSID, ssidr, sizeof(*ssidr));
 
@@ -863,7 +869,9 @@
 	}
 	return rc;
 }
-static int writeSsidRid(struct airo_info*ai, SsidRid *pssidr) {
+
+static int writeSsidRid(struct airo_info*ai, SsidRid *pssidr)
+{
 	int rc;
 	int i;
 	SsidRid ssidr = *pssidr;
@@ -875,7 +883,9 @@
 	rc = do_writerid(ai, RID_SSID, &ssidr, sizeof(ssidr));
 	return rc;
 }
-static int readConfigRid(struct airo_info*ai, ConfigRid *cfgr) {
+
+static int readConfigRid(struct airo_info*ai, ConfigRid *cfgr)
+{
 	int rc = PC4500_readrid(ai, RID_ACTUALCONFIG, cfgr, sizeof(*cfgr));
 	u16 *s;
 	
@@ -892,7 +902,9 @@
 	
 	return rc;
 }
-static int writeConfigRid(struct airo_info*ai, ConfigRid *pcfgr) {
+
+static int writeConfigRid(struct airo_info*ai, ConfigRid *pcfgr)
+{
 	u16 *s;
 	ConfigRid cfgr = *pcfgr;
 	
@@ -909,7 +921,9 @@
 	
 	return do_writerid( ai, RID_CONFIG, &cfgr, sizeof(cfgr));
 }
-static int readStatusRid(struct airo_info*ai, StatusRid *statr) {
+
+static int readStatusRid(struct airo_info*ai, StatusRid *statr)
+{
 	int rc = PC4500_readrid(ai, RID_STATUS, statr, sizeof(*statr));
 	u16 *s;
 
@@ -921,18 +935,24 @@
 
 	return rc;
 }
-static int readAPListRid(struct airo_info*ai, APListRid *aplr) {
+
+static int readAPListRid(struct airo_info*ai, APListRid *aplr)
+{
 	int rc =  PC4500_readrid(ai, RID_APLIST, aplr, sizeof(*aplr));
 	aplr->len = le16_to_cpu(aplr->len);
 	return rc;
 }
-static int writeAPListRid(struct airo_info*ai, APListRid *aplr) {
+
+static int writeAPListRid(struct airo_info*ai, APListRid *aplr)
+{
 	int rc;
 	aplr->len = cpu_to_le16(aplr->len);
 	rc = do_writerid(ai, RID_APLIST, aplr, sizeof(*aplr));
 	return rc;
 }
-static int readCapabilityRid(struct airo_info*ai, CapabilityRid *capr) {
+
+static int readCapabilityRid(struct airo_info*ai, CapabilityRid *capr)
+{
 	int rc = PC4500_readrid(ai, RID_CAPABILITIES, capr, sizeof(*capr));
 	u16 *s;
 	
@@ -944,7 +964,9 @@
 		*s = le16_to_cpu(*s);
 	return rc;
 }
-static int readStatsRid(struct airo_info*ai, StatsRid *sr, int rid) {
+
+static int readStatsRid(struct airo_info*ai, StatsRid *sr, int rid)
+{
 	int rc = PC4500_readrid(ai, rid, sr, sizeof(*sr));
 	u32 *i;
 
@@ -953,7 +975,8 @@
 	return rc;
 }
 
-static int airo_open(struct net_device *dev) {
+static int airo_open(struct net_device *dev)
+{
 	struct airo_info *info = dev->priv;
 
 	enable_interrupts(info);
@@ -962,7 +985,8 @@
 	return 0;
 }
 
-static int airo_start_xmit(struct sk_buff *skb, struct net_device *dev) {
+static int airo_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
 	s16 len;
 	s16 retval = 0;
 	u16 status;
@@ -993,9 +1017,9 @@
 	
 	len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN; /* check min length*/
 	buffer = skb->data;
-	status = transmit_802_3_packet( priv, 
-					fids[i],
-					skb->data, len );
+	status = transmit_802_3_packet(priv, 
+	                               fids[i],
+	                               skb->data, len );
 	
 	if ( status == SUCCESS ) {
                 /* Mark fid as used & save length for later */
@@ -1004,20 +1028,22 @@
 	} else {
 		priv->stats.tx_errors++;
 	}
- tx_done:
+tx_done:
 	spin_unlock_irqrestore(&priv->bap1_lock, flags);
 	dev_kfree_skb(skb);
 	return 0;
 }
 
-static struct net_device_stats *airo_get_stats(struct net_device *dev) {
+static struct net_device_stats *airo_get_stats(struct net_device *dev)
+{
 	return &(((struct airo_info*)dev->priv)->stats);
 }
 
 static int enable_MAC( struct airo_info *ai, Resp *rsp );
 static void disable_MAC(struct airo_info *ai);
 
-static void airo_set_multicast_list(struct net_device *dev) {
+static void airo_set_multicast_list(struct net_device *dev)
+{
 	struct airo_info *ai = (struct airo_info*)dev->priv;
 	Cmd cmd;
 	Resp rsp;
@@ -1060,7 +1086,6 @@
 	return 0;
 }
 
-
 static int airo_close(struct net_device *dev) { 
 	struct airo_info *ai = (struct airo_info*)dev->priv;
 
@@ -1101,14 +1126,14 @@
 	int i, rc;
 	
 	/* Create the network device object. */
-        dev = alloc_etherdev(sizeof(*ai));
-        if (!dev) {
+	dev = alloc_etherdev(sizeof(*ai));
+	if (!dev) {
 		printk(KERN_ERR "airo:  Couldn't alloc_etherdev\n");
 		return NULL;
-        }
+	}
 	ai = dev->priv;
 	ai->registered = 1;
-        ai->dev = dev;
+	ai->dev = dev;
 	ai->bap0_lock = SPIN_LOCK_UNLOCKED;
 	ai->bap1_lock = SPIN_LOCK_UNLOCKED;
 	ai->aux_lock = SPIN_LOCK_UNLOCKED;
@@ -1137,10 +1162,10 @@
 	if (rc)
 		goto err_out_unlink;
 	
-	rc = request_irq( dev->irq, airo_interrupt, 
-			  SA_SHIRQ | SA_INTERRUPT, dev->name, dev );
+	rc = request_irq(dev->irq, airo_interrupt, 
+	                 SA_SHIRQ | SA_INTERRUPT, dev->name, dev );
 	if (rc) {
-		printk(KERN_ERR "airo: register interrupt %d failed, rc %d\n", irq, rc );
+		printk( KERN_ERR "airo: register interrupt %d failed, rc %d\n", irq, rc );
 		goto err_out_unregister;
 	}
 	if (!is_pcmcia) {
@@ -1156,10 +1181,10 @@
 		goto err_out_res;
 	}
 
-	printk( KERN_INFO "airo: MAC enabled %s %x:%x:%x:%x:%x:%x\n",
-		dev->name,
-		dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-		dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5] );
+	printk(KERN_INFO "airo: MAC enabled %s %x:%x:%x:%x:%x:%x\n",
+	       dev->name,
+	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5] );
 
 	/* Allocate the transmit buffers */
 	for( i = 0; i < MAX_FIDS; i++ )
@@ -1234,7 +1259,8 @@
 	return ETH_ALEN;
 }
 
-static void airo_interrupt ( int irq, void* dev_id, struct pt_regs *regs) {
+static void airo_interrupt(int irq, void* dev_id, struct pt_regs *regs)
+{
 	struct net_device *dev = (struct net_device *)dev_id;
 	u16 status;
 	u16 fid;
@@ -1258,8 +1284,7 @@
 	if ( status & EV_LINK ) {
 		/* The link status has changed, if you want to put a
 		   monitor hook in, do it here.  (Remember that
-		   interrupts are still disabled!)
-		*/
+		   interrupts are still disabled!)  */
 		u16 newStatus = IN4500(apriv, LINKSTAT);
 		/* Here is what newStatus means: */
 #define NOBEACON 0x8000 /* Loss of sync - missed beacons */
@@ -1269,27 +1294,21 @@
 #define TSFSYNC 0x8004 /* Loss of sync - TSF synchronization */
 #define DEAUTH 0x8100 /* Deauthentication (low byte is reason code) */
 #define DISASS 0x8200 /* Disassociation (low byte is reason code) */
-#define ASSFAIL 0x8400 /* Association failure (low byte is reason
-			  code) */
-#define AUTHFAIL 0x0300 /* Authentication failure (low byte is reason
-			   code) */
+#define ASSFAIL 0x8400 /* Association failure (low byte is reason code) */
+#define AUTHFAIL 0x0300 /* Authentication failure (low byte is reason code) */
 #define ASSOCIATED 0x0400 /* Assocatied */
 #define RC_RESERVED 0 /* Reserved return code */
 #define RC_NOREASON 1 /* Unspecified reason */
 #define RC_AUTHINV 2 /* Previous authentication invalid */
-#define RC_DEAUTH 3 /* Deauthenticated because sending station is
-		       leaving */
+#define RC_DEAUTH 3 /* Deauthenticated because sending station is leaving */
 #define RC_NOACT 4 /* Disassociated due to inactivity */
 #define RC_MAXLOAD 5 /* Disassociated because AP is unable to handle
-			all currently associated stations */
-#define RC_BADCLASS2 6 /* Class 2 frame received from
-			  non-Authenticated station */
-#define RC_BADCLASS3 7 /* Class 3 frame received from
-			  non-Associated station */
-#define RC_STATLEAVE 8 /* Disassociated because sending station is
-			  leaving BSS */
+                        all currently associated stations */
+#define RC_BADCLASS2 6 /* Class 2 frame rec'd from non-Authenticated station */
+#define RC_BADCLASS3 7 /* Class 3 frame rec'd from non-Associated station */
+#define RC_STATLEAVE 8 /* Disassociated because sending station leaving BSS */
 #define RC_NOAUTH 9 /* Station requesting (Re)Association is not
-		       Authenticated with the responding station */
+                       Authenticated with the responding station */
 		if (newStatus != ASSOCIATED) {
 			if (auto_wep && !timer_pending(&apriv->timer)) {
 				apriv->timer.expires = RUN_AT(HZ*3);
@@ -1331,7 +1350,7 @@
 			apriv->stats.rx_length_errors++;
 			apriv->stats.rx_errors++;
 			printk( KERN_ERR 
-				"airo: Bad size %d\n", len );
+			        "airo: Bad size %d\n", len );
 			len = 0;
 		}
 		if (len) {
@@ -1428,7 +1447,7 @@
 		if (full) netif_wake_queue(dev);
 		if (index==-1) {
 			printk( KERN_ERR
-				"airo: Unallocated FID was used to xmit\n" );
+			        "airo: Unallocated FID was used to xmit\n" );
 		}
 		if ( status & EV_TX ) {
 			apriv->stats.tx_packets++;
@@ -1449,9 +1468,9 @@
 		}
 	}
 	if ( status & ~STATUS_INTS & ~IGNORE_INTS ) 
-		printk( KERN_WARNING 
-			"airo: Got weird status %x\n", 
-			status & ~STATUS_INTS & ~IGNORE_INTS );
+		printk(KERN_WARNING 
+		       "airo: Got weird status %x\n", 
+		       status & ~STATUS_INTS & ~IGNORE_INTS );
 	OUT4500( apriv, EVACK, status & STATUS_INTS );
 	OUT4500( apriv, EVINTEN, savedInterrupts );
 	
@@ -1468,28 +1487,31 @@
  *  NOTE:  If use with 8bit mode and SMP bad things will happen!
  *         Why would some one do 8 bit IO in an SMP machine?!?
  */
-static void OUT4500( struct airo_info *ai, u16 reg, u16 val ) {
-	if ( !do8bitIO )
+static void OUT4500( struct airo_info *ai, u16 reg, u16 val )
+{
+	if ( !do8bitIO ) {
 		outw( val, ai->dev->base_addr + reg );
-	else {
+	} else {
 		outb( val & 0xff, ai->dev->base_addr + reg );
 		outb( val >> 8, ai->dev->base_addr + reg + 1 );
 	}
 }
 
-static u16 IN4500( struct airo_info *ai, u16 reg ) {
+static u16 IN4500( struct airo_info *ai, u16 reg )
+{
 	unsigned short rc;
 	
-	if ( !do8bitIO )
+	if ( !do8bitIO ) {
 		rc = inw( ai->dev->base_addr + reg );
-	else {
+	} else {
 		rc = inb( ai->dev->base_addr + reg );
 		rc += ((int)inb( ai->dev->base_addr + reg + 1 )) << 8;
 	}
 	return rc;
 }
 
-static int enable_MAC( struct airo_info *ai, Resp *rsp ) {
+static int enable_MAC( struct airo_info *ai, Resp *rsp )
+{
         Cmd cmd;
 
         if (ai->flags&FLAG_RADIO_OFF) return SUCCESS;
@@ -1498,7 +1520,8 @@
 	return issuecommand(ai, &cmd, rsp);
 }
 
-static void disable_MAC( struct airo_info *ai ) {
+static void disable_MAC( struct airo_info *ai )
+{
         Cmd cmd;
 	Resp rsp;
 
@@ -1507,7 +1530,8 @@
 	issuecommand(ai, &cmd, &rsp);
 }
 
-static void enable_interrupts( struct airo_info *ai ) {
+static void enable_interrupts( struct airo_info *ai )
+{
 	/* Reset the status register */
 	u16 status = IN4500( ai, EVSTAT );
 	OUT4500( ai, EVACK, status );
@@ -1517,12 +1541,13 @@
 	   I dont know how to get rid of right now... */
 }
 
-static void disable_interrupts( struct airo_info *ai ) {
+static void disable_interrupts( struct airo_info *ai )
+{
 	OUT4500( ai, EVINTEN, 0 );
 }
 
 static u16 setup_card(struct airo_info *ai, u8 *mac, 
-		      ConfigRid *config)
+                      ConfigRid *config)
 {
 	Cmd cmd; 
 	Resp rsp;
@@ -1638,8 +1663,9 @@
 	return SUCCESS;
 }
 
-static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
-        // Im really paranoid about letting it run forever!
+static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp)
+{
+	// I'm really paranoid about letting it run forever!
 	int max_tries = 600000;  
         int rc = SUCCESS;
 	long flags;
@@ -1662,9 +1688,9 @@
 	}
 	if ( max_tries == -1 ) {
 		printk( KERN_ERR 
-			"airo: Max tries exceeded when issueing command\n" );
+                        "airo: Max tries exceeded when issueing command\n" );
                 rc = ERROR;
-                goto done;
+		goto done;
 	}
 	// command completed
 	pRsp->status = IN4500(ai, STATUS);
@@ -1678,7 +1704,7 @@
 	}
 	// acknowledge processing the status/response
 	OUT4500(ai, EVACK, EV_CMD);
- done:
+done:
 	spin_unlock_irqrestore(&ai->cmd_lock, flags);
 	return rc;
 }
@@ -1704,14 +1730,14 @@
 		} else if ( status & BAP_ERR ) {
 			/* invalid rid or offset */
 			printk( KERN_ERR "airo: BAP error %x %d\n", 
-				status, whichbap );
+			        status, whichbap );
 			return ERROR;
 		} else if (status & BAP_DONE) { // success
 			return SUCCESS;
 		}
 		if ( !(max_tries--) ) {
 			printk( KERN_ERR 
-				"airo: BAP setup error too many retries\n" );
+			        "airo: BAP setup error too many retries\n" );
 			return ERROR;
 		}
 		// -- PC4500 missed it, try again
@@ -1725,7 +1751,7 @@
    following use concepts not documented in the developers guide.  I
    got them from a patch given to my by Aironet */
 static u16 aux_setup(struct airo_info *ai, u16 page,
-		     u16 offset, u16 *len)
+                     u16 offset, u16 *len)
 {
 	u16 next;
 
@@ -1739,7 +1765,7 @@
 
 /* requires call to bap_setup() first */
 static int aux_bap_read(struct airo_info *ai, u16 *pu16Dst,
-			int bytelen, int whichbap) 
+                        int bytelen, int whichbap) 
 {
 	u16 len;
 	u16 page;
@@ -1776,7 +1802,7 @@
 
 /* requires call to bap_setup() first */
 static int fast_bap_read(struct airo_info *ai, u16 *pu16Dst, 
-			 int bytelen, int whichbap)
+                         int bytelen, int whichbap)
 {
 	bytelen = (bytelen + 1) & (~1); // round up to even value
 	if ( !do8bitIO ) 
@@ -1788,7 +1814,7 @@
 
 /* requires call to bap_setup() first */
 static int bap_write(struct airo_info *ai, const u16 *pu16Src, 
-		     int bytelen, int whichbap)
+                     int bytelen, int whichbap)
 {
 	bytelen = (bytelen + 1) & (~1); // round up to even value
 	if ( !do8bitIO ) 
@@ -1821,17 +1847,17 @@
 static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf, int len)
 {
 	u16 status;
-        long flags;
-        int rc = SUCCESS;
+	long flags;
+	int rc = SUCCESS;
 
 	spin_lock_irqsave(&ai->bap1_lock, flags);
 	if ( (status = PC4500_accessrid(ai, rid, CMD_ACCESS)) != SUCCESS) {
-                rc = status;
-                goto done;
-        }
+		rc = status;
+		goto done;
+	}
 	if (bap_setup(ai, rid, 0, BAP1) != SUCCESS) {
 		rc = ERROR;
-                goto done;
+		goto done;
         }
 	// read the rid length field
 	bap_read(ai, pBuf, 2, BAP1);
@@ -1840,19 +1866,19 @@
 	
 	if ( len <= 2 ) {
 		printk( KERN_ERR 
-			"airo: Rid %x has a length of %d which is too short\n",
-			(int)rid,
-			(int)len );
+		        "airo: Rid %x has a length of %d which is too short\n",
+		        (int)rid,
+		        (int)len );
 		rc = ERROR;
                 goto done;
 	}
 	// read remainder of the rid
 	if (bap_setup(ai, rid, 2, BAP1) != SUCCESS) {
-                rc = ERROR;
-                goto done;
-        }
+		rc = ERROR;
+		goto done;
+	}
 	rc = bap_read(ai, ((u16*)pBuf)+1, len, BAP1);
- done:
+done:
 	spin_unlock_irqrestore(&ai->bap1_lock, flags);
 	return rc;
 }
@@ -1860,27 +1886,27 @@
 /*  Note, that we are using BAP1 which is also used by transmit, so
  *  make sure this isnt called when a transmit is happening */
 static int PC4500_writerid(struct airo_info *ai, u16 rid, 
-			   const void *pBuf, int len)
+                           const void *pBuf, int len)
 {
 	u16 status;
-        long flags;
+	long flags;
 	int rc = SUCCESS;
 
 	spin_lock_irqsave(&ai->bap1_lock, flags);
 	// --- first access so that we can write the rid data
 	if ( (status = PC4500_accessrid(ai, rid, CMD_ACCESS)) != 0) {
-                rc = status;
-                goto done;
-        }
+		rc = status;
+		goto done;
+	}
 	// --- now write the rid data
 	if (bap_setup(ai, rid, 0, BAP1) != SUCCESS) {
-                rc = ERROR;
-                goto done;
-        }
+		rc = ERROR;
+		goto done;
+	}
 	bap_write(ai, pBuf, len, BAP1);
 	// ---now commit the rid data
 	rc = PC4500_accessrid(ai, rid, 0x100|CMD_ACCESS);
- done:
+done:
 	spin_unlock_irqrestore(&ai->bap1_lock, flags);
         return rc;
 }
@@ -1893,7 +1919,7 @@
 	Resp rsp;
 	u16 txFid;
 	u16 txControl;
-        long flags;
+	long flags;
 
 	cmd.cmd = CMD_ALLOCATETX;
 	cmd.parm0 = lenPayload;
@@ -1913,7 +1939,7 @@
 	/*  We only have to setup the control once since we are not
 	 *  releasing the fid. */
 	txControl = cpu_to_le16(TXCTL_TXOK | TXCTL_TXEX | TXCTL_802_3
-		| TXCTL_ETHERNET | TXCTL_NORELEASE);
+	                        | TXCTL_ETHERNET | TXCTL_NORELEASE);
 	spin_lock_irqsave(&ai->bap1_lock, flags);
 	if (bap_setup(ai, txFid, 0x0008, BAP1) != SUCCESS) {
 		spin_unlock_irqrestore(&ai->bap1_lock, flags);
@@ -1929,7 +1955,7 @@
    since we need a BAP when accessing RIDs, we also use BAP1 for that.
    Make sure the BAP1 spinlock is held when this is called. */
 static int transmit_802_3_packet(struct airo_info *ai, u16 txFid, 
-				 char *pPacket, int len)
+                                 char *pPacket, int len)
 {
 	u16 payloadLen;
 	Cmd cmd;
@@ -1963,14 +1989,14 @@
  */
 
 static ssize_t proc_read( struct file *file,
-			  char *buffer,
-			  size_t len,
-			  loff_t *offset);
+                          char *buffer,
+                          size_t len,
+                          loff_t *offset);
 
 static ssize_t proc_write( struct file *file,
-			   const char *buffer,
-			   size_t len,
-			   loff_t *offset );
+                           const char *buffer,
+                           size_t len,
+                           loff_t *offset );
 static int proc_close( struct inode *inode, struct file *file );
 
 static int proc_stats_open( struct inode *inode, struct file *file );
@@ -2052,28 +2078,29 @@
 #endif
 
 static int setup_proc_entry( struct net_device *dev,
-			     struct airo_info *apriv ) {
+                             struct airo_info *apriv )
+{
 	struct proc_dir_entry *entry;
 	/* First setup the device directory */
 	apriv->proc_entry = create_proc_entry(dev->name,
-					      S_IFDIR|airo_perm,
-					      airo_entry);
-        apriv->proc_entry->uid = proc_uid;
-        apriv->proc_entry->gid = proc_gid;
+	                                      S_IFDIR|airo_perm,
+	                                      airo_entry);
+	apriv->proc_entry->uid = proc_uid;
+	apriv->proc_entry->gid = proc_gid;
 
 	/* Setup the StatsDelta */
 	entry = create_proc_entry("StatsDelta",
-				  S_IFREG | (S_IRUGO&proc_perm),
-				  apriv->proc_entry);
-        entry->uid = proc_uid;
-        entry->gid = proc_gid;
+	                          S_IFREG | (S_IRUGO&proc_perm),
+	                          apriv->proc_entry);
+	entry->uid = proc_uid;
+	entry->gid = proc_gid;
 	entry->data = dev;
 	SETPROC_OPS(entry, proc_statsdelta_ops);
 	
 	/* Setup the Stats */
 	entry = create_proc_entry("Stats",
-				  S_IFREG | (S_IRUGO&proc_perm),
-				  apriv->proc_entry);
+	                          S_IFREG | (S_IRUGO&proc_perm),
+	                          apriv->proc_entry);
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
@@ -2081,8 +2108,8 @@
 	
 	/* Setup the Status */
 	entry = create_proc_entry("Status",
-				  S_IFREG | (S_IRUGO&proc_perm),
-				  apriv->proc_entry);
+	                          S_IFREG | (S_IRUGO&proc_perm),
+	                          apriv->proc_entry);
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
@@ -2090,8 +2117,8 @@
 	
 	/* Setup the Config */
 	entry = create_proc_entry("Config",
-				  S_IFREG | proc_perm,
-				  apriv->proc_entry);
+	                          S_IFREG | proc_perm,
+                                  apriv->proc_entry);
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
@@ -2099,8 +2126,8 @@
 
 	/* Setup the SSID */
 	entry = create_proc_entry("SSID",
-				  S_IFREG | proc_perm,
-				  apriv->proc_entry);
+	                          S_IFREG | proc_perm,
+                                  apriv->proc_entry);
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
@@ -2108,8 +2135,8 @@
 
 	/* Setup the APList */
 	entry = create_proc_entry("APList",
-				  S_IFREG | proc_perm,
-				  apriv->proc_entry);
+	                          S_IFREG | proc_perm,
+	                          apriv->proc_entry);
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
@@ -2117,8 +2144,8 @@
 
 	/* Setup the BSSList */
 	entry = create_proc_entry("BSSList",
-				  S_IFREG | proc_perm,
-				  apriv->proc_entry);
+	                          S_IFREG | proc_perm,
+	                          apriv->proc_entry);
 	entry->uid = proc_uid;
 	entry->gid = proc_gid;
 	entry->data = dev;
@@ -2126,8 +2153,8 @@
 
 	/* Setup the WepKey */
 	entry = create_proc_entry("WepKey",
-				  S_IFREG | proc_perm,
-				  apriv->proc_entry);
+	                          S_IFREG | proc_perm,
+	                          apriv->proc_entry);
         entry->uid = proc_uid;
         entry->gid = proc_gid;
 	entry->data = dev;
@@ -2136,8 +2163,9 @@
 	return 0;
 }
 
-static int takedown_proc_entry( struct net_device *dev,
-				struct airo_info *apriv ) {
+static int takedown_proc_entry(struct net_device *dev,
+                               struct airo_info *apriv )
+{
 	if ( !apriv->proc_entry->namelen ) return 0;
 	remove_proc_entry("Stats",apriv->proc_entry);
 	remove_proc_entry("StatsDelta",apriv->proc_entry);
@@ -2163,10 +2191,10 @@
  *  The read routine is generic, it relies on the preallocated rbuffer
  *  to supply the data.
  */
-static ssize_t proc_read( struct file *file,
-			  char *buffer,
-			  size_t len,
-			  loff_t *offset )
+static ssize_t proc_read(struct file *file,
+                         char *buffer,
+                         size_t len,
+                         loff_t *offset )
 {
 	int i;
 	int pos;
@@ -2187,10 +2215,10 @@
  *  The write routine is generic, it fills in a preallocated rbuffer
  *  to supply the data.
  */
-static ssize_t proc_write( struct file *file,
-			   const char *buffer,
-			   size_t len,
-			   loff_t *offset ) 
+static ssize_t proc_write(struct file *file,
+                          const char *buffer,
+                          size_t len,
+                          loff_t *offset ) 
 {
 	int i;
 	int pos;
@@ -2202,17 +2230,19 @@
 	
 	pos = *offset;
 	
-	for( i = 0; i + pos <  priv->maxwritelen &&
-		     i < len; i++ ) {
+	for( i = 0; i + pos <  priv->maxwritelen && i < len; i++ ) {
 		if (get_user( priv->wbuffer[i+pos], buffer + i ))
 			return -EFAULT;
 	}
-	if ( i+pos > priv->writelen ) priv->writelen = i+file->f_pos;
+	if ( i+pos > priv->writelen ) {
+		priv->writelen = i+file->f_pos;
+	}
 	*offset += i;
 	return i;
 }
 
-static int proc_status_open( struct inode *inode, struct file *file ) {
+static int proc_status_open( struct inode *inode, struct file *file )
+{
 	struct proc_data *data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2237,66 +2267,70 @@
 	readStatusRid(apriv, &status_rid);
 	readCapabilityRid(apriv, &cap_rid);
 	
-        i = sprintf(data->rbuffer, "Status: %s%s%s%s%s%s%s%s%s\n",
-                    status_rid.mode & 1 ? "CFG ": "",
-                    status_rid.mode & 2 ? "ACT ": "",
-                    status_rid.mode & 0x10 ? "SYN ": "",
-                    status_rid.mode & 0x20 ? "LNK ": "",
-                    status_rid.mode & 0x40 ? "LEAP ": "",
-                    status_rid.mode & 0x80 ? "PRIV ": "",
-                    status_rid.mode & 0x100 ? "KEY ": "",
-                    status_rid.mode & 0x200 ? "WEP ": "",
-                    status_rid.mode & 0x8000 ? "ERR ": "");
-	sprintf( data->rbuffer+i, "Mode: %x\n"
-		 "Signal Strength: %d\n"
-		 "Signal Quality: %d\n"
-		 "SSID: %-.*s\n"
-		 "AP: %-.16s\n"
-		 "Freq: %d\n"
-		 "BitRate: %dmbs\n"
-		 "Driver Version: %s\n"
-		 "Device: %s\nManufacturer: %s\nFirmware Version: %s\n"
-		 "Radio type: %x\nCountry: %x\nHardware Version: %x\n"
-		 "Software Version: %x\nSoftware Subversion: %x\n"
-		 "Boot block version: %x\n",
-		 (int)status_rid.mode,
-		 (int)status_rid.normalizedSignalStrength,
-		 (int)status_rid.signalQuality,
-		 (int)status_rid.SSIDlen,
-		 status_rid.SSID,
-		 status_rid.apName,
-		 (int)status_rid.channel,
-		 (int)status_rid.currentXmitRate/2,
-		 version,
-		 cap_rid.prodName,
-		 cap_rid.manName,
-		 cap_rid.prodVer,
-		 cap_rid.radioType,
-		 cap_rid.country,
-		 cap_rid.hardVer,
-		 (int)cap_rid.softVer,
-		 (int)cap_rid.softSubVer,
-		 (int)cap_rid.bootBlockVer );
+	i = sprintf(data->rbuffer, "Status: %s%s%s%s%s%s%s%s%s\n",
+	            status_rid.mode & 1 ? "CFG ": "",
+	            status_rid.mode & 2 ? "ACT ": "",
+	            status_rid.mode & 0x10 ? "SYN ": "",
+	            status_rid.mode & 0x20 ? "LNK ": "",
+	            status_rid.mode & 0x40 ? "LEAP ": "",
+	            status_rid.mode & 0x80 ? "PRIV ": "",
+	            status_rid.mode & 0x100 ? "KEY ": "",
+	            status_rid.mode & 0x200 ? "WEP ": "",
+	            status_rid.mode & 0x8000 ? "ERR ": "");
+	sprintf(data->rbuffer+i,
+	        "Mode: %x\n"
+	        "Signal Strength: %d\n"
+		"Signal Quality: %d\n"
+		"SSID: %-.*s\n"
+		"AP: %-.16s\n"
+		"Freq: %d\n"
+		"BitRate: %dmbs\n"
+		"Driver Version: %s\n"
+		"Device: %s\nManufacturer: %s\nFirmware Version: %s\n"
+		"Radio type: %x\nCountry: %x\nHardware Version: %x\n"
+		"Software Version: %x\nSoftware Subversion: %x\n"
+		"Boot block version: %x\n",
+		(int)status_rid.mode,
+		(int)status_rid.normalizedSignalStrength,
+		(int)status_rid.signalQuality,
+		(int)status_rid.SSIDlen,
+		status_rid.SSID,
+		status_rid.apName,
+		(int)status_rid.channel,
+		(int)status_rid.currentXmitRate/2,
+		version,
+		cap_rid.prodName,
+		cap_rid.manName,
+		cap_rid.prodVer,
+		cap_rid.radioType,
+		cap_rid.country,
+		cap_rid.hardVer,
+		(int)cap_rid.softVer,
+		(int)cap_rid.softSubVer,
+		(int)cap_rid.bootBlockVer );
 	data->readlen = strlen( data->rbuffer );
 	return 0;
 }
 
 static int proc_stats_rid_open(struct inode*, struct file*, u16);
-static int proc_statsdelta_open( struct inode *inode, 
-				 struct file *file ) {
+static int proc_statsdelta_open(struct inode *inode, 
+                                struct file *file )
+{
 	if (file->f_mode&FMODE_WRITE) {
 		return proc_stats_rid_open(inode, file, RID_STATSDELTACLEAR);
 	}
 	return proc_stats_rid_open(inode, file, RID_STATSDELTA);
 }
 
-static int proc_stats_open( struct inode *inode, struct file *file ) {
+static int proc_stats_open( struct inode *inode, struct file *file )
+{
 	return proc_stats_rid_open(inode, file, RID_STATS);
 }
 
-static int proc_stats_rid_open( struct inode *inode, 
-				struct file *file,
-				u16 rid ) {
+static int proc_stats_rid_open(struct inode *inode, 
+                               struct file *file,
+                               u16 rid )
+{
 	struct proc_data *data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2322,11 +2356,11 @@
 	
         j = 0;
 	for(i=0; (int)statsLabels[i]!=-1 && 
-		    i*4<stats.len; i++){
+		    i*4<stats.len; i++) {
 		if (!statsLabels[i]) continue;
 		if (j+strlen(statsLabels[i])+16>4096) {
 			printk(KERN_WARNING
-			       "airo: Potentially disasterous buffer overflow averted!\n");
+			       "airo: Potentially disastrous buffer overflow averted!\n");
 			break;
 		}
 		j+=sprintf(data->rbuffer+j, "%s: %d\n", statsLabels[i], vals[i]);
@@ -2339,12 +2373,15 @@
 	return 0;
 }
 
-static int get_dec_u16( char *buffer, int *start, int limit ) {
+static int get_dec_u16( char *buffer, int *start, int limit )
+{
 	u16 value;
 	int valid = 0;
-	for( value = 0; buffer[*start] >= '0' &&
-		     buffer[*start] <= '9' &&
-		     *start < limit; (*start)++ ) {
+	for(
+		value = 0;
+		buffer[*start] >= '0' && buffer[*start] <= '9' && *start < limit;
+		(*start)++
+	) {
 		valid = 1;
 		value *= 10;
 		value += buffer[*start] - '0';
@@ -2353,7 +2390,8 @@
 	return value;
 }
 
-static void checkThrottle(ConfigRid *config) {
+static void checkThrottle(ConfigRid *config)
+{
 	int i;
 /* Old hardware had a limit on encryption speed */
 	if (config->authType != AUTH_OPEN && maxencrypt) {
@@ -2365,7 +2403,8 @@
 	}
 }
 
-static void proc_config_on_close( struct inode *inode, struct file *file ) {
+static void proc_config_on_close( struct inode *inode, struct file *file )
+{
 	struct proc_data *data = file->private_data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2383,7 +2422,6 @@
 
 	line = data->wbuffer;
 	while( line[0] ) {
-/*** Mode processing */
 		if ( !strncmp( line, "Mode: ", 6 ) ) {
 			line += 6;
 			config.rmode &= 0xfe00;
@@ -2404,31 +2442,24 @@
 				dev->hard_header_parse = ai->header_parse;
 				need_reset = 1;
 			}
-		}
-		
-/*** Radio status */
-		else if (!strncmp(line,"Radio: ", 7)) {
+		} else if (!strncmp(line,"Radio: ", 7)) {
 			line += 7;
 			if (!strncmp(line,"off",3)) {
 				ai->flags |= FLAG_RADIO_OFF;
 			} else {
 				ai->flags &= ~FLAG_RADIO_OFF;
 			}
-		}
-/*** NodeName processing */
-		else if ( !strncmp( line, "NodeName: ", 10 ) ) {
+		} else if ( !strncmp( line, "NodeName: ", 10 ) ) {
 			int j;
 			
 			line += 10;
 			memset( config.nodeName, 0, 16 );
-/* Do the name, assume a space between the mode and node name */
+			/* Do the name:
+			   assume a space between the mode and node name */
 			for( j = 0; j < 16 && line[j] != '\n'; j++ ) {
 				config.nodeName[j] = line[j];
 			}
-		} 
-		
-/*** PowerMode processing */
-		else if ( !strncmp( line, "PowerMode: ", 11 ) ) {
+		} else if ( !strncmp( line, "PowerMode: ", 11 ) ) {
 			line += 11;
 			if ( !strncmp( line, "PSPCAM", 6 ) ) {
 				config.powerSaveMode = POWERSAVE_PSPCAM;
@@ -2438,8 +2469,9 @@
 				config.powerSaveMode = POWERSAVE_CAM;
 			}	
 		} else if ( !strncmp( line, "DataRates: ", 11 ) ) {
-			int v, i = 0, k = 0; /* i is index into line, 
-						k is index to rates */
+			int v;
+			int i = 0; // index into line
+			int k = 0; // index to rates
 			
 			line += 11;
 			while((v = get_dec_u16(line, &i, 3))!=-1) {
@@ -2561,7 +2593,8 @@
 	enable_MAC(ai, &rsp);
 }
 
-static int proc_config_open( struct inode *inode, struct file *file ) {
+static int proc_config_open( struct inode *inode, struct file *file )
+{
 	struct proc_data *data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2593,69 +2626,70 @@
 	readConfigRid(ai, &config);
 	
 	i = sprintf( data->rbuffer, 
-		     "Mode: %s\n"
-		     "Radio: %s\n"
-		     "NodeName: %-16s\n"
-		     "PowerMode: %s\n"
-		     "DataRates: %d %d %d %d %d %d %d %d\n"
-		     "Channel: %d\n"
-		     "XmitPower: %d\n",
-		     config.opmode == 0 ? "adhoc" : 
-		     config.opmode == 1 ? "ESS" :
-		     config.opmode == 2 ? "AP" : 
-		     config.opmode == 3 ? "AP RPTR" : "Error",
-		     ai->flags&FLAG_RADIO_OFF ? "off" : "on",
-		     config.nodeName,
-		     config.powerSaveMode == 0 ? "CAM" :
-		     config.powerSaveMode == 1 ? "PSP" :
-		     config.powerSaveMode == 2 ? "PSPCAM" : "Error",
-		     (int)config.rates[0],
-		     (int)config.rates[1],
-		     (int)config.rates[2],
-		     (int)config.rates[3],
-		     (int)config.rates[4],
-		     (int)config.rates[5],
-		     (int)config.rates[6],
-		     (int)config.rates[7],
-		     (int)config.channelSet,
-		     (int)config.txPower
-		);
+	             "Mode: %s\n"
+	             "Radio: %s\n"
+	             "NodeName: %-16s\n"
+	             "PowerMode: %s\n"
+	             "DataRates: %d %d %d %d %d %d %d %d\n"
+	             "Channel: %d\n"
+	             "XmitPower: %d\n",
+	             config.opmode == 0 ? "adhoc" : 
+	             config.opmode == 1 ? "ESS" :
+	             config.opmode == 2 ? "AP" : 
+	             config.opmode == 3 ? "AP RPTR" : "Error",
+	             ai->flags&FLAG_RADIO_OFF ? "off" : "on",
+	             config.nodeName,
+	             config.powerSaveMode == 0 ? "CAM" :
+	             config.powerSaveMode == 1 ? "PSP" :
+	             config.powerSaveMode == 2 ? "PSPCAM" : "Error",
+	             (int)config.rates[0],
+	             (int)config.rates[1],
+	             (int)config.rates[2],
+	             (int)config.rates[3],
+	             (int)config.rates[4],
+	             (int)config.rates[5],
+	             (int)config.rates[6],
+	             (int)config.rates[7],
+	             (int)config.channelSet,
+	             (int)config.txPower
+	);
 	sprintf( data->rbuffer + i,
-		 "LongRetryLimit: %d\n"
-		 "ShortRetryLimit: %d\n"
-		 "RTSThreshold: %d\n"
-		 "TXMSDULifetime: %d\n"
-		 "RXMSDULifetime: %d\n"
-		 "TXDiversity: %s\n"
-		 "RXDiversity: %s\n"
-		 "FragThreshold: %d\n"
-		 "WEP: %s\n"
-		 "Modulation: %s\n"
-		 "Preamble: %s\n",
-		 (int)config.longRetryLimit,
-		 (int)config.shortRetryLimit,
-		 (int)config.rtsThres,
-		 (int)config.txLifetime,
-		 (int)config.rxLifetime,
-		 config.txDiversity == 1 ? "left" :
-		 config.txDiversity == 2 ? "right" : "both",
-		 config.rxDiversity == 1 ? "left" :
-		 config.rxDiversity == 2 ? "right" : "both",
-		 (int)config.fragThresh,
-		 config.authType == AUTH_ENCRYPT ? "encrypt" :
-		 config.authType == AUTH_SHAREDKEY ? "shared" : "open",
-		 config.modulation == 0 ? "default" :
-		 config.modulation == MOD_CCK ? "cck" :
-		 config.modulation == MOD_MOK ? "mok" : "error",
-		 config.preamble == PREAMBLE_AUTO ? "auto" :
-		 config.preamble == PREAMBLE_LONG ? "long" :
-		 config.preamble == PREAMBLE_SHORT ? "short" : "error"
-		);
+	         "LongRetryLimit: %d\n"
+	         "ShortRetryLimit: %d\n"
+	         "RTSThreshold: %d\n"
+	         "TXMSDULifetime: %d\n"
+	         "RXMSDULifetime: %d\n"
+	         "TXDiversity: %s\n"
+	         "RXDiversity: %s\n"
+	         "FragThreshold: %d\n"
+	         "WEP: %s\n"
+	         "Modulation: %s\n"
+	         "Preamble: %s\n",
+	         (int)config.longRetryLimit,
+	         (int)config.shortRetryLimit,
+	         (int)config.rtsThres,
+	         (int)config.txLifetime,
+	         (int)config.rxLifetime,
+	         config.txDiversity == 1 ? "left" :
+	         config.txDiversity == 2 ? "right" : "both",
+	         config.rxDiversity == 1 ? "left" :
+	         config.rxDiversity == 2 ? "right" : "both",
+	         (int)config.fragThresh,
+	         config.authType == AUTH_ENCRYPT ? "encrypt" :
+	         config.authType == AUTH_SHAREDKEY ? "shared" : "open",
+	         config.modulation == 0 ? "default" :
+	         config.modulation == MOD_CCK ? "cck" :
+	         config.modulation == MOD_MOK ? "mok" : "error",
+	         config.preamble == PREAMBLE_AUTO ? "auto" :
+	         config.preamble == PREAMBLE_LONG ? "long" :
+	         config.preamble == PREAMBLE_SHORT ? "short" : "error"
+	);
 	data->readlen = strlen( data->rbuffer );
 	return 0;
 }
 
-static void proc_SSID_on_close( struct inode *inode, struct file *file ) {
+static void proc_SSID_on_close( struct inode *inode, struct file *file )
+{
 	struct proc_data *data = (struct proc_data *)file->private_data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2670,28 +2704,34 @@
 	
 	for( i = 0; i < 3; i++ ) {
 		int j;
-		for( j = 0; j+offset < data->writelen && j < 32 &&
-			     data->wbuffer[offset+j] != '\n'; j++ ) {
+		for(
+			j = 0;
+			j+offset < data->writelen && j < 32 && data->wbuffer[offset+j] != '\n';
+			j++
+		) {
 			SSID_rid.ssids[i].ssid[j] = data->wbuffer[offset+j];
 		}
 		if ( j == 0 ) break;
 		SSID_rid.ssids[i].len = j;
 		offset += j;
-		while( data->wbuffer[offset] != '\n' && 
-		       offset < data->writelen ) offset++;
+		while( data->wbuffer[offset] != '\n' && offset < data->writelen ) {
+			offset++;
+		}
 		offset++;
 	}
 	writeSsidRid(ai, &SSID_rid);
 }
 
-inline static u8 hexVal(char c) {
+inline static u8 hexVal(char c)
+{
 	if (c>='0' && c<='9') return c -= '0';
 	if (c>='a' && c<='f') return c -= 'a'-10;
 	if (c>='A' && c<='F') return c -= 'A'-10;
 	return 0;
 }
 
-static void proc_APList_on_close( struct inode *inode, struct file *file ) {
+static void proc_APList_on_close( struct inode *inode, struct file *file )
+{
 	struct proc_data *data = (struct proc_data *)file->private_data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2724,7 +2764,8 @@
 
 /* This function wraps PC4500_writerid with a MAC disable */
 static int do_writerid( struct airo_info *ai, u16 rid, const void *rid_data,
-			int len ) {
+                        int len )
+{
 	int rc;
 	Resp rsp;
 	
@@ -2738,7 +2779,8 @@
  * the index of the transmit key is returned.  If the key doesn't exist,
  * -1 will be returned.
  */
-static int get_wep_key(struct airo_info *ai, u16 index) {
+static int get_wep_key(struct airo_info *ai, u16 index)
+{
 	WepKeyRid wkr;
 	int rc;
 	u16 lastindex;
@@ -2758,20 +2800,21 @@
 }
 
 static int set_wep_key(struct airo_info *ai, u16 index,
-		       const char *key, u16 keylen, int perm ) {
+                       const char *key, u16 keylen, int perm )
+{
 	static const unsigned char macaddr[6] = { 0x01, 0, 0, 0, 0, 0 };
 	WepKeyRid wkr;
 
 	memset(&wkr, 0, sizeof(wkr));
 	if (keylen == 0) {
-// We are selecting which key to use
+		// We are selecting which key to use
 		wkr.len = sizeof(wkr);
 		wkr.kindex = 0xffff;
 		wkr.mac[0] = (char)index;
 		if (perm) printk(KERN_INFO "Setting transmit key to %d\n", index);
 		if (perm) ai->defindex = (char)index;
 	} else {
-// We are actually setting the key
+		// We are actually setting the key
 		wkr.len = sizeof(wkr);
 		wkr.kindex = index;
 		wkr.klen = keylen;
@@ -2784,7 +2827,8 @@
 	return 0;
 }
 
-static void proc_wepkey_on_close( struct inode *inode, struct file *file ) {
+static void proc_wepkey_on_close( struct inode *inode, struct file *file )
+{
 	struct proc_data *data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2795,11 +2839,11 @@
 	int j = 0;
 
 	memset(key, 0, sizeof(key));
-	
+
 	dp = (struct proc_dir_entry *) inode->u.generic_ip;
 	data = (struct proc_data *)file->private_data;
 	if ( !data->writelen ) return;
-	
+
 	if (data->wbuffer[0] >= '0' && data->wbuffer[0] <= '3' &&
 	    (data->wbuffer[1] == ' ' || data->wbuffer[1] == '\n')) {
 		index = data->wbuffer[0] - '0';
@@ -2826,7 +2870,8 @@
 	set_wep_key(ai, index, key, i/3, 1);
 }
 
-static int proc_wepkey_open( struct inode *inode, struct file *file ) {
+static int proc_wepkey_open( struct inode *inode, struct file *file )
+{
 	struct proc_data *data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2880,7 +2925,8 @@
 	return 0;
 }
 
-static int proc_SSID_open( struct inode *inode, struct file *file ) {
+static int proc_SSID_open( struct inode *inode, struct file *file )
+{
 	struct proc_data *data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2928,7 +2974,8 @@
 	return 0;
 }
 
-static int proc_APList_open( struct inode *inode, struct file *file ) {
+static int proc_APList_open( struct inode *inode, struct file *file )
+{
 	struct proc_data *data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -2962,16 +3009,16 @@
 	readAPListRid(ai, &APList_rid);
 	ptr = data->rbuffer;
 	for( i = 0; i < 4; i++ ) {
-// We end when we find a zero MAC
+		// We end when we find a zero MAC
 		if ( !*(int*)APList_rid.ap[i] &&
 		     !*(int*)&APList_rid.ap[i][2]) break;
 		ptr += sprintf(ptr, "%02x:%02x:%02x:%02x:%02x:%02x\n",
-			       (int)APList_rid.ap[i][0],
-			       (int)APList_rid.ap[i][1],
-			       (int)APList_rid.ap[i][2],
-			       (int)APList_rid.ap[i][3],
-			       (int)APList_rid.ap[i][4],
-			       (int)APList_rid.ap[i][5]);
+		               (int)APList_rid.ap[i][0],
+		               (int)APList_rid.ap[i][1],
+		               (int)APList_rid.ap[i][2],
+		               (int)APList_rid.ap[i][3],
+		               (int)APList_rid.ap[i][4],
+		               (int)APList_rid.ap[i][5]);
 	}
 	if (i==0) ptr += sprintf(ptr, "Not using specific APs\n");
 
@@ -2980,7 +3027,8 @@
 	return 0;
 }
 
-static int proc_BSSList_open( struct inode *inode, struct file *file ) {
+static int proc_BSSList_open( struct inode *inode, struct file *file )
+{
 	struct proc_data *data;
 	struct proc_dir_entry *dp = inode->u.generic_ip;
 	struct net_device *dev = dp->data;
@@ -3023,26 +3071,26 @@
 	}
 	ptr = data->rbuffer;
 	/* There is a race condition here if there are concurrent opens.
-           Since it is a rare condition, we'll just live with it, otherwise
-           we have to add a spin lock... */
+	   Since it is a rare condition, we'll just live with it, otherwise
+	   we have to add a spin lock... */
 	rc = readBSSListRid(ai, doLoseSync, &BSSList_rid);
 	while(rc == 0 && BSSList_rid.index != 0xffff) {
 		ptr += sprintf(ptr, "%02x:%02x:%02x:%02x:%02x:%02x %*s rssi = %d",
-				(int)BSSList_rid.bssid[0],
-				(int)BSSList_rid.bssid[1],
-				(int)BSSList_rid.bssid[2],
-				(int)BSSList_rid.bssid[3],
-				(int)BSSList_rid.bssid[4],
-				(int)BSSList_rid.bssid[5],
-				(int)BSSList_rid.ssidLen,
-				BSSList_rid.ssid,
-				(int)BSSList_rid.rssi);
+		               (int)BSSList_rid.bssid[0],
+		               (int)BSSList_rid.bssid[1],
+		               (int)BSSList_rid.bssid[2],
+		               (int)BSSList_rid.bssid[3],
+		               (int)BSSList_rid.bssid[4],
+		               (int)BSSList_rid.bssid[5],
+		               (int)BSSList_rid.ssidLen,
+		               BSSList_rid.ssid,
+		               (int)BSSList_rid.rssi);
 		ptr += sprintf(ptr, " channel = %d %s %s %s %s\n",
-				(int)BSSList_rid.dsChannel,
-				BSSList_rid.cap & CAP_ESS ? "ESS" : "",
-				BSSList_rid.cap & CAP_IBSS ? "adhoc" : "",
-				BSSList_rid.cap & CAP_PRIVACY ? "wep" : "",
-				BSSList_rid.cap & CAP_SHORTHDR ? "shorthdr" : "");
+		               (int)BSSList_rid.dsChannel,
+		               BSSList_rid.cap & CAP_ESS ? "ESS" : "",
+		               BSSList_rid.cap & CAP_IBSS ? "adhoc" : "",
+		               BSSList_rid.cap & CAP_PRIVACY ? "wep" : "",
+		               BSSList_rid.cap & CAP_SHORTHDR ? "shorthdr" : "");
 		rc = readBSSListRid(ai, 0, &BSSList_rid);
 	}
 	*ptr = '\0';
@@ -3071,18 +3119,19 @@
    will switch WEP modes to see if that will help.  If the card is
    associated we will check every minute to see if anything has
    changed. */
-static void timer_func( u_long data ) {
+static void timer_func( u_long data )
+{
 	struct net_device *dev = (struct net_device*)data;
 	struct airo_info *apriv = (struct airo_info *)dev->priv;
 	u16 linkstat = IN4500(apriv, LINKSTAT);
 	
 	if (linkstat != 0x400 ) {
-/* We don't have a link so try changing the authtype */
+		/* We don't have a link so try changing the authtype */
 		ConfigRid config = apriv->config;
 
 		switch(apriv->authtype) {
 		case AUTH_ENCRYPT:
-/* So drop to OPEN */
+			/* So drop to OPEN */
 			config.authType = AUTH_OPEN;
 			apriv->authtype = AUTH_OPEN;
 			break;
@@ -3107,13 +3156,14 @@
 		checkThrottle(&config);
 		writeConfigRid(apriv, &config);
 
-/* Schedule check to see if the change worked */
+		/* Schedule check to see if the change worked */
 		apriv->timer.expires = RUN_AT(HZ*3);
 		add_timer(&apriv->timer);
 	}
 }
 
-static int add_airo_dev( struct net_device *dev ) {
+static int add_airo_dev( struct net_device *dev )
+{
 	struct net_device_list *node = kmalloc( sizeof( *node ), GFP_KERNEL );
 	if ( !node )
 		return -ENOMEM;
@@ -3135,7 +3185,8 @@
 	return 0;
 }
 
-static void del_airo_dev( struct net_device *dev ) {
+static void del_airo_dev( struct net_device *dev )
+{
 	struct net_device_list **p = &airo_devices;
 	while( *p && ( (*p)->dev != dev ) )
 		p = &(*p)->next;
@@ -3145,10 +3196,10 @@
 
 #ifdef CONFIG_PCI
 static int __devinit airo_pci_probe(struct pci_dev *pdev, 
-				    const struct pci_device_id *pent)
+                                    const struct pci_device_id *pent)
 {
 	pdev->driver_data = init_airo_card(pdev->irq, 
-					   pdev->resource[2].start, 0);
+	                                   pdev->resource[2].start, 0);
 	if (!pdev->driver_data) {
 		return -ENODEV;
 	}
@@ -3166,10 +3217,10 @@
 	int i, rc = 0, have_isa_dev = 0;
 	
 	airo_entry = create_proc_entry("aironet",
-				       S_IFDIR | airo_perm,
-				       proc_root_driver);
-        airo_entry->uid = proc_uid;
-        airo_entry->gid = proc_gid;
+	                               S_IFDIR | airo_perm,
+	                               proc_root_driver);
+	airo_entry->uid = proc_uid;
+	airo_entry->gid = proc_gid;
 	
 	for( i = 0; i < 4 && io[i] && irq[i]; i++ ) {
 		printk( KERN_INFO 
@@ -3186,8 +3237,7 @@
 #endif
 
 	/* Always exit with success, as we are a library module
-	 * as well as a driver module
-	 */
+	   as well as a driver module */
 	return 0;
 }
 
@@ -3232,9 +3282,9 @@
 #ifdef WIRELESS_EXT
 	struct airo_info *local = (struct airo_info*) dev->priv;
 	struct iwreq *wrq = (struct iwreq *) rq;
-	ConfigRid config;		/* Configuration info */
-	CapabilityRid cap_rid;		/* Card capability info */
-	StatusRid status_rid;		/* Card status info */
+	ConfigRid config;         /* Configuration info */
+	CapabilityRid cap_rid;    /* Card capability info */
+	StatusRid status_rid;     /* Card status info */
 
 #ifdef CISCO_EXT
 	if (cmd != SIOCGIWPRIV && cmd != AIROIOCTL && cmd != AIROIDIFC)
@@ -3253,8 +3303,8 @@
 
 	switch (cmd) {
 #ifdef WIRELESS_EXT
-		// Get name
 	case SIOCGIWNAME:
+		// Get name
 		strcpy(wrq->u.name, "IEEE 802.11-DS");
 		break;
 
@@ -3308,7 +3358,7 @@
 	case SIOCSIWESSID:
 		if (wrq->u.data.pointer) {
 			char	essid[IW_ESSID_MAX_SIZE + 1];
-			SsidRid SSID_rid;		/* SSIDs */
+			SsidRid SSID_rid;          /* SSIDs */
 
 			/* Reload the list of current SSID */
 			readSsidRid(local, &SSID_rid);
@@ -3318,8 +3368,7 @@
 				/* Just send an empty SSID list */
 				memset(&SSID_rid, 0, sizeof(SSID_rid));
 			} else {
-				int	index = (wrq->u.data.flags &
-						 IW_ENCODE_INDEX) - 1;
+				int index = (wrq->u.data.flags & IW_ENCODE_INDEX) - 1;
 
 				/* Check the size of the string */
 				if(wrq->u.data.length > IW_ESSID_MAX_SIZE+1) {
@@ -3335,13 +3384,12 @@
 				/* Set the SSID */
 				memset(essid, 0, sizeof(essid));
 				if (copy_from_user(essid,
-					       wrq->u.data.pointer,
-					       wrq->u.data.length)) {
+				                   wrq->u.data.pointer,
+				                   wrq->u.data.length)) {
 					rc = -EFAULT;
 					break;
 				}
-				memcpy(SSID_rid.ssids[index].ssid, essid,
-				       sizeof(essid) - 1);
+				memcpy(SSID_rid.ssids[index].ssid, essid, sizeof(essid) - 1);
 				SSID_rid.ssids[index].len = wrq->u.data.length - 1;
 			}
 			/* Write it to the card */
@@ -3370,10 +3418,11 @@
 		}
 		break;
 
+		// ?
 	case SIOCSIWAP:
-		if (wrq->u.ap_addr.sa_family != ARPHRD_ETHER)
+		if (wrq->u.ap_addr.sa_family != ARPHRD_ETHER) {
 			rc = -EINVAL;
-		else {
+		} else {
 			APListRid APList_rid;
 
 			memset(&APList_rid, 0, sizeof(APList_rid));
@@ -3402,8 +3451,7 @@
 				break;
 			}
 			memset(name, 0, sizeof(name));
-			if (copy_from_user(name, wrq->u.data.pointer,
-					   wrq->u.data.length)) {
+			if (copy_from_user(name, wrq->u.data.pointer, wrq->u.data.length)) {
 				rc = -EFAULT;
 				break;
 			}
@@ -3486,7 +3534,7 @@
 		break;
 	}
 
-	// Get the current bit-rate
+		// Get the current bit-rate
 	case SIOCGIWRATE:
 	{
 		int brate = status_rid.currentXmitRate;
@@ -3496,7 +3544,7 @@
 	}
 	break;
 
-	// Set the desired RTS threshold
+		// Set the desired RTS threshold
 	case SIOCSIWRTS:
 	{
 		int rthr = wrq->u.rts.value;
@@ -3511,7 +3559,7 @@
 	}
 	break;
 
-	// Get the current RTS threshold
+		// Get the current RTS threshold
 	case SIOCGIWRTS:
 		wrq->u.rts.value = config.rtsThres;
 		wrq->u.rts.disabled = (wrq->u.rts.value >= 2312);
@@ -3534,7 +3582,7 @@
 	}
 	break;
 
-	// Get the current fragmentation threshold
+		// Get the current fragmentation threshold
 	case SIOCGIWFRAG:
 		wrq->u.frag.value = config.fragThresh;
 		wrq->u.frag.disabled = (wrq->u.frag.value >= 2312);
@@ -3586,11 +3634,14 @@
 		// Set WEP keys and mode
 	case SIOCSIWENCODE:
 		/* Is WEP supported ? */
-		/* Older firmware doesn't support this...
+
+#if 0 /* Older firmware doesn't support this... */
 		if(!(cap_rid.softCap & 2)) {
 			rc = -EOPNOTSUPP;
 			break;
-		} */
+		}
+#endif
+
 		/* Basic checking: do we have a key to set ? */
 		if (wrq->u.encoding.pointer != (caddr_t) 0) {
 			wep_key_t key;
@@ -3707,7 +3758,7 @@
 			}
 
 			if(copy_to_user(wrq->u.encoding.pointer, zeros,
-					wrq->u.encoding.length))
+			                wrq->u.encoding.length))
 				rc = -EFAULT;
 		}
 		break;
@@ -3720,6 +3771,8 @@
 		wrq->u.txpower.disabled = (local->flags & FLAG_RADIO_OFF);
 		wrq->u.txpower.flags = IW_TXPOW_MWATT;
 		break;
+
+		// ?
 	case SIOCSIWTXPOW:
 		if (wrq->u.txpower.disabled) {
 			local->flags |= FLAG_RADIO_OFF;
@@ -3743,6 +3796,7 @@
 #endif /* WIRELESS_EXT > 9 */
 
 #if WIRELESS_EXT > 10
+		// ?
 	case SIOCSIWRETRY:
 		if(wrq->u.retry.disabled) {
 			rc = -EINVAL;
@@ -3770,6 +3824,7 @@
 		}
 		break;
 
+		// ?
 	case SIOCGIWRETRY:
 		wrq->u.retry.disabled = 0;      /* Can't be disabled */
 
@@ -3887,6 +3942,7 @@
 		}
 		break;
 
+		// ?
 	case SIOCGIWPOWER:
 	{
 		int mode = config.powerSaveMode;
@@ -3906,6 +3962,7 @@
 	}
 	break;
 
+		// ?
 	case SIOCSIWPOWER: 
 		if (wrq->u.power.disabled) {
 			if ((config.rmode & 0xFF) >= RXMODE_RFMON) {
@@ -3952,17 +4009,20 @@
 		}
 		break;
 
+		// ?
 	case SIOCGIWSENS:
 		wrq->u.sens.value = config.rssiThreshold;
 		wrq->u.sens.disabled = (wrq->u.sens.value == 0);
 		wrq->u.sens.fixed = 1;
 		break;
 
+		// ?
 	case SIOCSIWSENS:
 		config.rssiThreshold = wrq->u.sens.disabled ? RSSI_DEFAULT : wrq->u.sens.value;
 		local->need_commit = 1;
 		break;
 
+		// ?
 	case SIOCGIWAPLIST:
 		if (wrq->u.data.pointer) {
 			int i, rc;
@@ -3984,34 +4044,36 @@
 			if (!i) {
 				for (i = 0; 
 				     i < min(IW_MAX_AP, 4) &&
-					     (status_rid.bssid[i][0]
-					      & status_rid.bssid[i][1]
-					      & status_rid.bssid[i][2]
-					      & status_rid.bssid[i][3]
-					      & status_rid.bssid[i][4]
-					      & status_rid.bssid[i][5])!=-1 &&
-					     (status_rid.bssid[i][0]
-					      | status_rid.bssid[i][1]
-					      | status_rid.bssid[i][2]
-					      | status_rid.bssid[i][3]
-					      | status_rid.bssid[i][4]
-					      | status_rid.bssid[i][5]);
-				     i++) {
+				             (status_rid.bssid[i][0]
+				              & status_rid.bssid[i][1]
+				              & status_rid.bssid[i][2]
+				              & status_rid.bssid[i][3]
+				              & status_rid.bssid[i][4]
+				              & status_rid.bssid[i][5])!=-1 &&
+				             (status_rid.bssid[i][0]
+				              | status_rid.bssid[i][1]
+				              | status_rid.bssid[i][2]
+				              | status_rid.bssid[i][3]
+				              | status_rid.bssid[i][4]
+				              | status_rid.bssid[i][5]);
+				     i++
+				) {
 					memcpy(s[i].sa_data, 
 					       status_rid.bssid[i], 6);
 					s[i].sa_family = ARPHRD_ETHER;
 				}
 			} else {
 				wrq->u.data.flags = 1; /* Should be define'd */
-				if (copy_to_user(wrq->u.data.pointer
-						 + sizeof(struct sockaddr)*i,
-						 &qual,
-						 sizeof(struct iw_quality)*i))
+				if (copy_to_user(
+					wrq->u.data.pointer + sizeof(struct sockaddr)*i,
+					&qual,
+					sizeof(struct iw_quality)*i)
+				) {
 					rc = -EFAULT;
+				}
 			}
 			wrq->u.data.length = i;
-			if (copy_to_user(wrq->u.data.pointer, &s, 
-					 sizeof(struct sockaddr)*i))
+			if (copy_to_user(wrq->u.data.pointer, &s, sizeof(struct sockaddr)*i))
 				rc = -EFAULT;
 		}
 		break;
@@ -4019,19 +4081,17 @@
 #ifdef WIRELESS_SPY
 		// Set the spy list
 	case SIOCSIWSPY:
-		if (wrq->u.data.length > IW_MAX_SPY)
-		{
+		if (wrq->u.data.length > IW_MAX_SPY) {
 			rc = -E2BIG;
 			break;
 		}
 		local->spy_number = wrq->u.data.length;
-		if (local->spy_number > 0)
-		{
+		if (local->spy_number > 0) {
 			struct sockaddr address[IW_MAX_SPY];
 			int i;
 
 			if (copy_from_user(address, wrq->u.data.pointer,
-					   sizeof(struct sockaddr) * local->spy_number)) {
+			                   sizeof(struct sockaddr) * local->spy_number)) {
 				rc = -EFAULT;
 				break;
 			}
@@ -4044,15 +4104,13 @@
 		// Get the spy list
 	case SIOCGIWSPY:
 		wrq->u.data.length = local->spy_number;
-		if ((local->spy_number > 0) && (wrq->u.data.pointer))
-		{
+		if ((local->spy_number > 0) && (wrq->u.data.pointer)) {
 			struct sockaddr address[IW_MAX_SPY];
 			int i;
 			rc = verify_area(VERIFY_WRITE, wrq->u.data.pointer, (sizeof(struct iw_quality)+sizeof(struct sockaddr)) * IW_MAX_SPY);
 			if (rc)
 				break;
-			for (i=0; i<local->spy_number; i++)
-			{
+			for (i=0; i<local->spy_number; i++) {
 				memcpy(address[i].sa_data, local->spy_address[i], 6);
 				address[i].sa_family = AF_UNIX;
 			}
@@ -4072,10 +4130,9 @@
 
 #ifdef CISCO_EXT
 	case SIOCGIWPRIV:
-		if(wrq->u.data.pointer)
-		{
-			struct iw_priv_args   priv[] =
-			{ /* cmd, set_args, get_args, name */
+		if(wrq->u.data.pointer) {
+			struct iw_priv_args   priv[] = {
+				/* cmd, set_args, get_args, name */
 				{ AIROIOCTL, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | sizeof (aironet_ioctl), IW_PRIV_TYPE_BYTE | 2047, "airoioctl" },
 				{ AIROIDIFC, IW_PRIV_TYPE_BYTE | IW_PRIV_SIZE_FIXED | sizeof (aironet_ioctl), IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, "airoidifc" },
 			};
@@ -4093,6 +4150,7 @@
 #endif /* WIRELESS_EXT */
 
 #ifdef CISCO_EXT
+		// ?
 	case AIROIDIFC:
 	{
 		int val = AIROMAGIC;
@@ -4104,10 +4162,10 @@
 	}
 	break;
   
+		// ?
 	case AIROIOCTL:
 		/* Get the command struct and hand it off for evaluation by 
-		 * the proper subfunction
-		 */
+		   the proper subfunction */
 	{
 		aironet_ioctl com;
 		if (copy_from_user(&com,rq->ifr_data,sizeof(com))) {
@@ -4115,8 +4173,7 @@
 			break;
 		}
 
-		/* Seperate R/W functions bracket legality here
-		 */
+		/* Seperate R/W functions bracket legality here */
 		if ( com.command <= AIROGSTATSD32 )
 			rc = readrids(dev,&com);
 		else if ( com.command >= AIROPCAP && com.command <= AIROPLEAPUSR )
@@ -4129,10 +4186,10 @@
 	break;
 #endif /* CISCO_EXT */
 
-	// All other calls are currently unsupported
+		// All other calls are currently unsupported
 	default:
 		rc = -EOPNOTSUPP;
-	}
+	} /* switch */
 
 #ifdef WIRELESS_EXT
 	/* Some of the "SET" function may have modified some of the
@@ -4210,12 +4267,12 @@
  * as needed.  This represents the READ side of control I/O to 
  * the card
  */
-static int readrids(struct net_device *dev, aironet_ioctl *comp) {
+static int readrids(struct net_device *dev, aironet_ioctl *comp)
+{
 	unsigned short ridcode;
 	unsigned char iobuf[2048]; 
 
-	switch(comp->command)
-	{
+	switch(comp->command) {
 	case AIROGCAP:      ridcode = RID_CAPABILITIES; break;
 	case AIROGCFG:      ridcode = RID_CONFIG;       break;
 	case AIROGSLIST:    ridcode = RID_SSID;         break;
@@ -4238,7 +4295,7 @@
 	default:
 		return -EINVAL;  
 		break;
-	}
+	} /* switch */
 
 	PC4500_readrid((struct airo_info *)dev->priv,ridcode,iobuf,sizeof(iobuf));
 	/* get the count of bytes in the rid  docs say 1st 2 bytes is it.
@@ -4246,8 +4303,7 @@
 	 * 9/22/2000 Honor user given length
 	 */
 
-	if (copy_to_user(comp->data, iobuf,
-			 min_t(unsigned int, comp->len, sizeof(iobuf))))
+	if (copy_to_user(comp->data, iobuf, min_t(unsigned int, comp->len, sizeof(iobuf))))
 		return -EFAULT;
 	return 0;
 }
@@ -4256,7 +4312,8 @@
  * Danger Will Robinson write the rids here
  */
 
-static int writerids(struct net_device *dev, aironet_ioctl *comp) {
+static int writerids(struct net_device *dev, aironet_ioctl *comp)
+{
 	int  ridcode;
 	Resp      rsp;
 	static int (* writer)(struct airo_info *, u16 rid, const void *, int);
@@ -4269,8 +4326,7 @@
 	ridcode = 0;
 	writer = do_writerid;
 
-	switch(comp->command)
-	{
+	switch(comp->command) {
 	case AIROPSIDS:     ridcode = RID_SSID;         break;
 	case AIROPCAP:      ridcode = RID_CAPABILITIES; break;
 	case AIROPAPLIST:   ridcode = RID_APLIST;       break;
@@ -4314,6 +4370,7 @@
 	default:
 		return -EOPNOTSUPP;	/* Blarg! */
 	}
+
 	if(comp->len > sizeof(iobuf))
 		return -EINVAL;
 
@@ -4326,14 +4383,14 @@
 
 /*****************************************************************************
  * Ancillary flash / mod functions much black magic lurkes here              *
- *****************************************************************************
- */
+ *****************************************************************************/
 
 /* 
  * Flash command switch table
  */
 
-int flashcard(struct net_device *dev, aironet_ioctl *comp) {
+int flashcard(struct net_device *dev, aironet_ioctl *comp)
+{
 	int z;
 	int cmdreset(struct airo_info *);
 	int setflashmode(struct airo_info *);
@@ -4346,8 +4403,7 @@
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	switch(comp->command)
-	{
+	switch(comp->command) {
 	case AIROFLSHRST:
 		return cmdreset((struct airo_info *)dev->priv);
 
@@ -4398,10 +4454,11 @@
  * card. 
  */
 
-int cmdreset(struct airo_info *ai) {
+int cmdreset(struct airo_info *ai)
+{
 	disable_MAC(ai);
 
-	if(!waitbusy (ai)){
+	if(!waitbusy (ai)) {
 		printk(KERN_INFO "Waitbusy hang before RESET\n");
 		return -EBUSY;
 	}
@@ -4423,7 +4480,8 @@
  * mode
  */
 
-int setflashmode (struct airo_info *ai) {
+int setflashmode (struct airo_info *ai)
+{
 	OUT4500(ai, SWS0, FLASH_COMMAND);
 	OUT4500(ai, SWS1, FLASH_COMMAND);
 	OUT4500(ai, SWS0, FLASH_COMMAND);
@@ -4442,13 +4500,14 @@
  * x 50us for  echo . 
  */
 
-int flashpchar(struct airo_info *ai,int byte,int dwelltime) {
+int flashpchar(struct airo_info *ai,int byte,int dwelltime)
+{
 	int echo;
 	int waittime;
 
 	byte |= 0x8000;
 
-	if(dwelltime == 0 )
+	if (dwelltime == 0 )
 		dwelltime = 200;
   
 	waittime=dwelltime;
@@ -4460,7 +4519,7 @@
 	}
 
 	/* timeout for busy clear wait */
-	if(waittime <= 0 ){
+	if (waittime <= 0 ) {
 		printk(KERN_INFO "flash putchar busywait timeout! \n");
 		return -EBUSY;
 	}
@@ -4482,21 +4541,22 @@
  * Get a character from the card matching matchbyte
  * Step 3)
  */
-int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime){
+int flashgchar(struct airo_info *ai,int matchbyte,int dwelltime)
+{
 	int           rchar;
 	unsigned char rbyte=0;
 
 	do {
 		rchar = IN4500(ai,SWS1);
     
-		if(dwelltime && !(0x8000 & rchar)){
+		if (dwelltime && !(0x8000 & rchar)) {
 			dwelltime -= 10;
 			mdelay(10);
 			continue;
 		}
 		rbyte = 0xff & rchar;
 
-		if( (rbyte == matchbyte) && (0x8000 & rchar) ){
+		if( (rbyte == matchbyte) && (0x8000 & rchar) ) {
 			OUT4500(ai,SWS1,0);
 			return 0;
 		}
@@ -4504,7 +4564,7 @@
 			break;
 		OUT4500(ai,SWS1,0);
 
-	}while(dwelltime > 0);
+	} while (dwelltime > 0);
 	return -EIO;
 }
 
@@ -4513,14 +4573,15 @@
  * send to the card 
  */
 
-int flashputbuf(struct airo_info *ai){
+int flashputbuf(struct airo_info *ai)
+{
 	int            nwords;
 
 	/* Write stuff */
 	OUT4500(ai,AUXPAGE,0x100);
 	OUT4500(ai,AUXOFF,0);
 
-	for(nwords=0;nwords != FLASHSIZE / 2;nwords++){
+	for (nwords=0;nwords != FLASHSIZE / 2;nwords++) {
 		OUT4500(ai,AUXDATA,ai->flash[nwords] & 0xffff);
 	}
   
@@ -4530,9 +4591,10 @@
 }
 
 /*
- *
+ * ?
  */
-int flashrestart(struct airo_info *ai,struct net_device *dev){
+int flashrestart(struct airo_info *ai,struct net_device *dev)
+{
 	int    i,status;
 
 	set_current_state (TASK_UNINTERRUPTIBLE);

--------------724437F474FE1BD33C86B5DC--

