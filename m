Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130004AbRCGEDI>; Tue, 6 Mar 2001 23:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRCGECt>; Tue, 6 Mar 2001 23:02:49 -0500
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:63250 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S130004AbRCGECp>; Tue, 6 Mar 2001 23:02:45 -0500
Message-ID: <3AA5B24E.D0ED2206@ixiacom.com>
Date: Tue, 06 Mar 2001 20:00:14 -0800
From: Bryan Rittmeyer <bryan@ixiacom.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: conducting TCP sessions with non-local IPs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

> I didn't pick-up on the fact that you planned on have other computers
> listening with those addresses.

We won't--without getting into the specifics (NDA) we are developing a
TCP/IP load balance tester that needs to act--similtaneously--as many
machines. It is certainly not designed to run on your average LAN, but
rather on a carefully prepared test network using data assigned by a
user who (presumably) has ensured the IPs we are using are not already
assigned to other machines.

> This won't work without support from your routing device if you actually
> have hosts on the addresses, just because of ARP.

We have hacks in place for promiscous ARPing on any of the IPs we may
want to use :)

So, if I configure the interface as suggested ("/sbin/ip addr add
10.0.0.0/24 dev eth0") can I really bind to any IP in 10.0.0.0/24 and
conduct TCP sessions (as a client or server) using that IP--assuming all
the ARP, etc, issues are worked out?

Regards,

Bryan
-- 
Bryan Rittmeyer
mailto:bryan@ixiacom.com
Ixia Communications
26601 W. Agoura Rd.
Calabasas, CA 91302
