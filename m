Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267862AbRGRLtn>; Wed, 18 Jul 2001 07:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267861AbRGRLte>; Wed, 18 Jul 2001 07:49:34 -0400
Received: from mailserv.intranet.GR ([146.124.14.106]:24748 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id <S267860AbRGRLtX>; Wed, 18 Jul 2001 07:49:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: anpol <anpol@intracom.gr>
Organization: INTRACOM S.A.
To: linux-kernel@vger.kernel.org
Subject: Delayed acks in Linux 2.2.14
Date: Wed, 18 Jul 2001 14:52:59 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01071814525900.00834@patdpd21.intranet.gr>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I am studying delayed acks in linux 2.2.14 and i come to the following 
conclusions.

In bulk data transfer between two linux boxes i never saw a delayed ack. The 
server sends an ack every 2 full sized segments. This is fine but in 
transactional data transfer (e.g. a telnet session) i also do not see a 
delayed ack. What i see is this:

1. Client sends a character
2. Server echoes the character
3. Client sends an ack for the echo

The time between segment 2 and 3 is never above 20ms even when i have a large 
RTT (say 560 ms). This is a small delay(??) but its not enough to say that 
the ack is delayed. I also could never see the max delay of HZ/2 on an ACK. 
So delaying an ack does not depend on the RTT of the connection. Is that 
correct? And if yes where does it depend? Has anyone seen the HZ/2 delay on 
an ACK?

Thank you in advance

Tasos

p.s. please Cc your answer to my e-mail address <anpol@intracom.gr>
