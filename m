Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbRFFOta>; Wed, 6 Jun 2001 10:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263393AbRFFOtU>; Wed, 6 Jun 2001 10:49:20 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:32757 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263313AbRFFOtE>; Wed, 6 Jun 2001 10:49:04 -0400
From: "Chris Liebman" <liebman@sponsera.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.5-ac9
Date: Wed, 6 Jun 2001 10:49:01 -0400
Message-ID: <GJEFIPNALMBKLKJKIPIGKEMMCAAA.liebman@sponsera.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010605234928.A28971@lightning.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just tried the orinoco_cs driver with my "Orinoco Gold" pcmcia card in
hopes that I could use this instead of having to rebuild the pcmcia-cs
package everytime I try a new kernel...  I am seeing the following messages:

NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.

and:

hermes_read_ltv(): rid  (0xfc28) does not match type (0xfc27)
hermes_read_ltv(): rid  (0xfd10) does not match type (0xfc28)
hermes_read_ltv(): rid  (0xfd20) does not match type (0xfd10)
hermes_read_ltv(): rid  (0xfd41) does not match type (0xfd20)
hermes_read_ltv(): rid  (0xfd42) does not match type (0xfd41)
hermes_read_ltv(): rid  (0xfd43) does not match type (0xfd42)
hermes_read_ltv(): rid  (0xfd44) does not match type (0xfd43)
hermes_read_ltv(): rid  (0xfd4f) does not match type (0xfd44)
hermes_read_ltv(): rid  (0xfdc1) does not match type (0xfd4f)
hermes_read_ltv(): rid  (0xfdc6) does not match type (0xfdc1)

any ideas?

[liebman@xyzzy kernel]$ cat /proc/hermes/eth1/recs
PORTTYPE        (0xfc00): length=2 (2 bytes)    value=0001
MACADDR         (0xfc01): length=4 (6 bytes)    value=00:02:2D:1B:5C:7E
DESIRED_SSID    (0xfc02): length=18 (34 bytes)  value="xyzzy"
CHANNEL         (0xfc03): length=2 (2 bytes)    value=0000
OWN_SSID        (0xfc04): length=18 (34 bytes)  value="non-specified SSID
!!"
SYSTEM_SCALE    (0xfc06): length=2 (2 bytes)    value=0001
MAX_DATA_LEN    (0xfc07): length=2 (2 bytes)    value=0900
PM_ENABLE       (0xfc09): length=2 (2 bytes)    value=0000
PM_MCAST_RX     (0xfc0b): length=2 (2 bytes)    value=0001
PM_PERIOD       (0xfc0c): length=2 (2 bytes)    value=0064
NICKNAME        (0xfc0e): length=18 (34 bytes)  value="xyzzy.zod.com"
WEP_ON          (0xfc20): length=2 (2 bytes)    value=0001
MWO_ROBUST      (0xfc25): length=2 (2 bytes)    value=0000
MULTICAST_LIST  (0xfc80): length=4 (6 bytes)    value=01:00:5E:00:00:01
CREATEIBSS      (0xfc81): length=2 (2 bytes)    value=0001
FRAG_THRESH     (0xfc82): length=0 (-2 bytes)   value
RTS_THRESH      (0xfc83): length=2 (2 bytes)    value=092B
TX_RATE_CTRL    (0xfc84): length=2 (2 bytes)    value=0003
PROMISCUOUS     (0xfc85): length=2 (2 bytes)    value=0000
KEYS            (0xfcb0): length=0 (-2 bytes)   value
TX_KEY          (0xfcb1): length=2 (2 bytes)    value=0000
TICKTIME        (0xfce0): length=2 (2 bytes)    value=000A
PRISM2_TX_KEY   (0xfc23): length=2 (2 bytes)    value=0002
PRISM2_KEY0     (0xfc24): length=0 (-2 bytes)   value
PRISM2_KEY1     (0xfc25): length=2 (2 bytes)    value=00:00
PRISM2_KEY2     (0xfc26): length=0 (-2 bytes)   value
PRISM2_KEY3     (0xfc27): length=0 (-2 bytes)   value
PRISM2_WEP_ON   (0xfc28): length=0 (-2 bytes)   value
CHANNEL_LIST    (0xfd10): length=2 (2 bytes)    value=07FF
STAIDENTITY     (0xfd20): length=5 (8 bytes)    value=001F-0001-0006-0010
CURRENT_SSID    (0xfd41): length=18 (34 bytes)  value="xyzzy"
CURRENT_BSSID   (0xfd42): length=4 (6 bytes)    value=02:02:2D:06:30:06
COMMSQUALITY    (0xfd43): length=4 (6 bytes)    value=0000-001B-001B
CURRENT_TX_RATE (0xfd44): length=2 (2 bytes)    value=0002
WEP_AVAIL       (0xfd4f): length=2 (2 bytes)    value=0001
CURRENT_CHANNEL (0xfdc1): length=2 (2 bytes)    value=0003
DATARATES       (0xfdc6): length=6 (10 bytes)
value=04:00:02:04:0B:16:00:00:00:00

	-- Chris

