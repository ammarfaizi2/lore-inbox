Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUL2Ry4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUL2Ry4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 12:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbUL2Ry4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 12:54:56 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:2031 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S261382AbUL2RyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 12:54:07 -0500
Message-ID: <41D2EF1F.2020400@mtg-marinetechnik.de>
Date: Wed, 29 Dec 2004 18:53:35 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: Jon Mason <jdmason@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>	 <8924577504121710054331bb54@mail.gmail.com>	 <8924577504121712527144a5cf@mail.gmail.com>	 <41C6E2E1.8030801@mtg-marinetechnik.de>	 <8924577504122009126c40c1fe@mail.gmail.com>	 <41C713EF.8050003@mtg-marinetechnik.de>	 <892457750412201231461415a1@mail.gmail.com>	 <41C7F204.3030503@mtg-marinetechnik.de>	 <89245775041221080238187402@mail.gmail.com>	 <41C93E93.5070704@mtg-marinetechnik.de> <892457750412220654918c785@mail.gmail.com>
In-Reply-To: <892457750412220654918c785@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer 
  full?"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason wrote:
> Richard,
> Yes, I need the tx timeout lines.  Those tell me if the patch was
> successfull in solving the interrupt enablement issue.  From your
> statement below, it appears that it was either unsucessful (and you
> didn't wait long enough for it to timeout) or the root problem lies
> somewhere else.
> 
> Please give it a good 20 minutes (if you can get away with it being
> down for that long) to timeout, as it has been taking 5-10 minutes in
> your previous errors.  There is no set timeframe for it to timeout. 
> It will only timeout after netif_stop_queue has true for a minute.  if
> this never happens, then it leads me to believe that the adapter is
> still functioning.  I know you can't log in to the system because of
> the nfs mounts, but can you see if the system is pingable before you
> reboot it?

Hi Jon!

No, the system is not pingable from the outside but it still responds to 
pings from the inside after the hang happens if i'm logged in.

Here the last hang data. I can't get it to print the "tx timeout" lines.
Two hangs today, I waited 35/40 min and still no "tx timeout". But I got 
"Transmit error, TxStatus ..." lines which were not there in the past 
hangs. I must admit that I did a SuSE kernel update.
I had 2.6.8-24.5 installed now I have 2.6.8-24.10.
The dl2k driver is the same on both versions, your patch applied 
cleanly, the hang is still there.

How can I get "netif_stop_queue to have true for a minute" as you 
described to get the "tx timed out" lines? I can login before the hang 
and stay logged in to give some commands or get any more data that you 
could use to continue searching ...

Thanks, Richard


Dec 29 17:31:08 urutu kernel: eth1: Transmit error, TxStatus 0001, 
FrameId 0.
Dec 29 17:32:03 urutu kdm[4064]: XDMCP socket creation failed, errno 97
Dec 29 17:33:07 urutu kernel: eth1: Transmit error, TxStatus 0005, 
FrameId 0.
Dec 29 17:35:01 urutu /usr/sbin/cron[12663]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 17:37:02 urutu kdm[4064]: XDMCP socket creation failed, errno 97
Dec 29 17:37:32 urutu last message repeated 2 times
Dec 29 17:37:56 urutu kdm: urutu.mtg-marinetechnik.de:6[13087]: 
pam_unix2: session started for user ems2, service xdm
Dec 29 17:38:08 urutu kdm[4064]: XDMCP socket creation failed, errno 97
Dec 29 17:38:09 urutu kdm[4064]: XDMCP socket creation failed, errno 97
Dec 29 17:38:24 urutu kdm: urutu.mtg-marinetechnik.de:7[13254]: 
pam_unix2: session started for user ems2, service xdm
Dec 29 17:38:32 urutu kdm[4064]: XDMCP socket creation failed, errno 97
Dec 29 17:38:32 urutu kdm[4064]: XDMCP socket creation failed, errno 97
Dec 29 17:38:53 urutu kdm: urutu.mtg-marinetechnik.de:8[13548]: 
pam_unix2: session started for user ems2, service xdm
Dec 29 17:40:01 urutu /usr/sbin/cron[14078]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 17:42:03 urutu kdm[4064]: XDMCP socket creation failed, errno 97
Dec 29 17:42:03 urutu kernel: eth1: Transmit error, TxStatus 0007, 
FrameId 0.
Dec 29 17:42:20 urutu kernel: eth1: HostError! IntStatus 0002. 119 107 0 7c2
Dec 29 17:44:06 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 29 17:44:38 urutu last message repeated 3 times
Dec 29 17:44:38 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 29 17:45:01 urutu /usr/sbin/cron[15081]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 17:45:07 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 29 17:50:01 urutu /usr/sbin/cron[15163]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 17:55:01 urutu /usr/sbin/cron[15202]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 17:59:01 urutu /usr/sbin/cron[15211]: (root) CMD ( rm -f 
/var/spool/cron/lastrun/cron.hourly)
Dec 29 18:00:01 urutu /usr/sbin/cron[15218]: (root) CMD ( 
/usr/lib/sa/sa2 -A)
Dec 29 18:00:01 urutu /usr/sbin/cron[15215]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 18:05:01 urutu /usr/sbin/cron[15265]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 18:09:02 urutu login[4286]: FAILED LOGIN 1 FROM /dev/tty3 FOR 
root, Authentication failure
Dec 29 18:10:01 urutu /usr/sbin/cron[15325]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 18:15:01 urutu /usr/sbin/cron[15342]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 18:20:01 urutu /usr/sbin/cron[15376]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 18:25:01 urutu /usr/sbin/cron[15393]: (root) CMD ( 
/root/scripts/reboot-on-network-hang.sh)
Dec 29 18:29:14 urutu syslogd 1.4.1: restart.

-- 
Richard Ems
Tel: +49 40 65803 312
Fax: +49 40 65803 392
Richard.Ems@mtg-marinetechnik.de

MTG Marinetechnik GmbH - Wandsbeker Königstr. 62 - D 22041 Hamburg

GF Dipl.-Ing. Ullrich Keil
Handelsregister: Abt. B Nr. 11 500 - Amtsgericht Hamburg Abt. 66
USt.-IdNr.: DE 1186 70571

