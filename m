Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262613AbSITNk2>; Fri, 20 Sep 2002 09:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262644AbSITNk2>; Fri, 20 Sep 2002 09:40:28 -0400
Received: from mailg.telia.com ([194.22.194.26]:23796 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S262613AbSITNk1> convert rfc822-to-8bit;
	Fri, 20 Sep 2002 09:40:27 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ahlberg <aliz@telia.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PACKET_MMAP
Date: Fri, 20 Sep 2002 15:45:30 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209201545.30950.aliz@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't know if this is already known or if I'm wrong, but here it is:

I ran nessus on my local servers and for some hosts it reported:

"Vulnerability found on port general/tcp


      The remote host seems to generate Initial Sequence Numbers
      (ISN) in a weak manner which seems to solely depend
      on the source and dest port of the TCP packets.

      The Raptor Firewall is known to be vulnerable to this flaw,
      as may others be.

      An attacker may use this flaw to establish spoofed connections
      to the remote host.


      Solution : If you are using a Raptor Firewall, see
      
http://www.symantec.com/techsupp/bulletin/archive/firewall/082002firewall.html
      or else contact your vendor for a patch

Risk factor : High"

and 

"Warning found on port general/tcp


      The remote host uses non-random IP IDs, that is, it is
      possible to predict the next value of the ip_id field of
      the ip packets sent by this host.

      An attacker may use this feature to determine if the remote
      host sent a packet in reply to another request. This may be
      used for portscanning and other things.

      Solution : Contact your vendor for a patch
Risk factor : Low"

Since I didn't get this on all my hosts I began wondering what caused this. A 
quick look at the config files showed that when the host had been compiled 
with CONFIG_PACKET_MMAP=y nessus found these problems. All servers tested are 
running 2.4.18 or 2.4.19.
