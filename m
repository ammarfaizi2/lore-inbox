Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRCFUd1>; Tue, 6 Mar 2001 15:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRCFUdJ>; Tue, 6 Mar 2001 15:33:09 -0500
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:26887 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S129424AbRCFUcy>; Tue, 6 Mar 2001 15:32:54 -0500
Message-ID: <3AA54902.AFF8550@ixiacom.com>
Date: Tue, 06 Mar 2001 12:30:58 -0800
From: Bryan Rittmeyer <bryan@ixiacom.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: conducting TCP sessions with non-local IPs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

Is there any way to conduct TCP sessions (IE have a userland process
connect out, or accept connections) using non-local IPs? By "non-local"
I just mean IPs that aren't assigned to an interface, but do fall into
the network range of a running interface (so netmask, gateway, etc are
"known").

For example, I want to bring up an interface for 10.0.0.0/255.255.255.0
and assign it IP 10.0.0.1 Then, I want a process to accept TCP
connections on, say, 10.0.0.2:1234 or 10.0.0.200:4567 even though these
IPs are not assigned to any interface. Also, I want to be able to
connect out with source IP 10.0.0.2 or 10.0.0.200, etc. I will need to
be able to do this for potentially all IPs in the network, so bringing
up a new IP-aliased interface (eth0:0, eth0:1, etc) is not feasible.
Compound that with the fact that I could need to do this for many
networks, and clearly doing an "ifconfig up" on all possible IPs is not
a very efficient option.

I have tried enabling "ip_nonlocal_bind" and that prevents a bind call
to a non-local IP from failing. However, I don't think that's sufficient
to conduct full TCP/IP sessions from any IP on the network.

This is a really wierd question, but I'm curious if its possible with
current 2.4.X kernels and, if it's not, how difficult would it be to add
support for. What areas of the network stack would require modification?

Thanks!

Regards,

Bryan Rittmeyer

-- 
Bryan Rittmeyer
mailto:bryan@ixiacom.com
Ixia Communications
26601 W. Agoura Rd.
Calabasas, CA 91302
