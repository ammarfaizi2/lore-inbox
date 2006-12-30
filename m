Return-Path: <linux-kernel-owner+w=401wt.eu-S1030345AbWL3VXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWL3VXe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 16:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWL3VXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 16:23:34 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:47656 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030342AbWL3VXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 16:23:32 -0500
Message-ID: <4596D8DE.2030408@lwfinger.net>
Date: Sat, 30 Dec 2006 15:23:42 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>, Aaron Sethman <androsyn@ratbox.org>
CC: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [OOPS] bcm43xx oops on 2.6.20-rc1 on x86_64
References: <Pine.LNX.4.64.0612171510030.17532@squeaker.ratbox.org> <20061230192104.GB20714@stusta.de>
In-Reply-To: <20061230192104.GB20714@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------070908010307060504070708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070908010307060504070708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> On Sun, Dec 17, 2006 at 03:15:28PM -0500, Aaron Sethman wrote:
>> Just was loading the bcm43xx module and got the following oops. Note that 
>> this card is one of the newer PCI-E cards.  If any other info is needed 
>> let me know.
> 
> Is this issue still present in 2.6.10-rc2-git1?
> 
> If yes, was 2.6.19 working fine?
> 
>> -Aaron
>>
>> ACPI: PCI Interrupt 0000:0c:00.0[A] -> GSI 17 (level, low) -> IRQ 17
>> PCI: Setting latency timer of device 0000:0c:00.0 to 64
>> bcm43xx: Chip ID 0x4311, rev 0x1
>> bcm43xx: Number of cores: 4
>> bcm43xx: Core 0: ID 0x800, rev 0x11, vendor 0x4243
>> bcm43xx: Core 1: ID 0x812, rev 0xa, vendor 0x4243
>> bcm43xx: Core 2: ID 0x817, rev 0x3, vendor 0x4243
>> bcm43xx: Core 3: ID 0x820, rev 0x1, vendor 0x4243
>> bcm43xx: PHY connected
>> bcm43xx: Detected PHY: Version: 4, Type 2, Revision 8
>> bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
>> bcm43xx: Radio turned off
>> bcm43xx: Radio turned off
>> Unable to handle kernel NULL pointer dereference at 0000000000000011 RIP:
>>  [<ffffffff88007793>] :ieee80211:ieee80211_wx_set_encode+0x14a/0x4a7
>> PGD 33a22067 PUD 3469b067 PMD 0
>> Oops: 0000 [1] SMP
>> CPU 0
>> Modules linked in: bcm43xx rng_core ieee80211softmac ieee80211 
>> ieee80211_crypt
>> Pid: 4088, comm: iwconfig Not tainted 2.6.20-rc1 #2
>> RIP: 0010:[<ffffffff88007793>]  [<ffffffff88007793>] 
>> :ieee80211:ieee80211_wx_set_encode+0x14a/0x4a7
>> RSP: 0018:ffff810032d3fc28  EFLAGS: 00010202
>> RAX: 0000000000000001 RBX: ffff81003332ebf8 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff810032d3fcd5
>> RBP: ffff81003332ebf8 R08: 0000000000000005 R09: ffff810032d3fc48
>> R10: 0000000000000000 R11: 0000000000000202 R12: ffff81003332e4c0
>> R13: 0000000000000000 R14: 0000000000000000 R15: ffff810032d3fe58
>> FS:  00002b7863a2d6d0(0000) GS:ffffffff80697000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> CR2: 0000000000000011 CR3: 0000000034270000 CR4: 00000000000026e0
>> Process iwconfig (pid: 4088, threadinfo ffff810032d3e000, task 
>> ffff810037c4f690)
>> Stack:  ffff81003d87ecc0 0000000000000000 0000000100000000 
>> ffffffff80290ede
>>  0000000000000404 0000000000000000 0000000000000000 0000000000000000
>>  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> Call Trace:
>>  [<ffffffff80290ede>] touch_atime+0xde/0x130
>>  [<ffffffff804f338b>] ioctl_standard_call+0x26b/0x3b0
>>  [<ffffffff8802baa0>] :bcm43xx:bcm43xx_wx_set_encoding+0x0/0x10
>>  [<ffffffff8025a029>] find_get_page+0x29/0x60
>>  [<ffffffff8025c684>] filemap_nopage+0x194/0x350
>>  [<ffffffff8802baa0>] :bcm43xx:bcm43xx_wx_set_encoding+0x0/0x10
>>  [<ffffffff804f3775>] wireless_process_ioctl+0x105/0x3d0
>>  [<ffffffff80267675>] __handle_mm_fault+0x465/0xad0
>>  [<ffffffff804e81d6>] dev_ioctl+0x346/0x3c0
>>  [<ffffffff803988f1>] __up_read+0x21/0xb0
>>  [<ffffffff804db750>] sock_ioctl+0x220/0x240
>>  [<ffffffff802885bf>] do_ioctl+0x2f/0xa0
>>  [<ffffffff802888d3>] vfs_ioctl+0x2a3/0x2e0
>>  [<ffffffff80288959>] sys_ioctl+0x49/0x80
>>  [<ffffffff8055184d>] error_exit+0x0/0x84
>>  [<ffffffff8020a03e>] system_call+0x7e/0x83
>>
>>
>> Code: 48 8b 40 10 48 85 c0 0f 84 01 01 00 00 48 8b 30 b9 04 00 00
>> RIP  [<ffffffff88007793>] :ieee80211:ieee80211_wx_set_encode+0x14a/0x4a7
>>  RSP <ffff810032d3fc28>
>> CR2: 0000000000000011

Any oops involving wireless extensions is due to 2.6.20-rc1 and -rc2 not having the fix for softmac
that is necessitated by the 2.6.20 changes in the work structure. The needed patch has now been
pushed by Jeff to Andrew and Linus, and should be in -rc3. In the meantime, it is attached.

Larry

--------------070908010307060504070708
Content-Type: text/plain;
 name="work_struct2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="work_struct2"

From: Ulrich Kunitz <kune@deine-taler.de>

The signature of work functions changed recently from a context
pointer to the work structure pointer. This caused a problem in
the ieee80211softmac code, because the ieee80211softmac_assox_work
function has  been called directly with a parameter explicitly
casted to (void*). This compiled correctly but resulted in a
softlock, because mutex_lock was called with the wrong memory
address. The patch fixes the problem. Another issue was a wrong
call of the schedule_work function. Softmac works again and this
fixes the problem I mentioned earlier in the zd1211rw rx tasklet
patch. The patch is against Linus' tree (commit af1713e0).

Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
Acked-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

John,

This patch should be pushed upstream to 2.6.20. At the moment, the work
struct changes have not yet propagated to wireless-2.6. When they do,
it will be needed there as well.

Larry

 net/ieee80211/softmac/ieee80211softmac_assoc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index eec1a1d..a824852 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -167,7 +167,7 @@ static void
 ieee80211softmac_assoc_notify_scan(struct net_device *dev, int event_type, void *context)
 {
 	struct ieee80211softmac_device *mac = ieee80211_priv(dev);
-	ieee80211softmac_assoc_work((void*)mac);
+	ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 }
 
 static void
@@ -177,7 +177,7 @@ ieee80211softmac_assoc_notify_auth(struc
 
 	switch (event_type) {
 	case IEEE80211SOFTMAC_EVENT_AUTHENTICATED:
-		ieee80211softmac_assoc_work((void*)mac);
+		ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 		break;
 	case IEEE80211SOFTMAC_EVENT_AUTH_FAILED:
 	case IEEE80211SOFTMAC_EVENT_AUTH_TIMEOUT:


--------------070908010307060504070708--
