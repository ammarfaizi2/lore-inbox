Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279978AbRJ3Pax>; Tue, 30 Oct 2001 10:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279976AbRJ3Paq>; Tue, 30 Oct 2001 10:30:46 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:9199 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S279975AbRJ3Pa2>; Tue, 30 Oct 2001 10:30:28 -0500
Message-ID: <3BDEC82E.C47C88CD@nortelnetworks.com>
Date: Tue, 30 Oct 2001 10:33:02 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lundell <jlundell@pobox.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <Pine.LNX.4.30.0110291831160.9540-100000@anime.net> <p05100304b803c6908755@[10.128.7.49]> <9rl60r$g50$1@cesium.transmeta.com> <p05100309b803cdfa4552@[10.128.7.49]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:

> But what I meant was bonding's use of ARP to determine whether the
> connection is good (or rather, bad, even when the link is up), when
> the connection is routed via level 3. Seems to me you'd need a level
> 3 protocol (say ICMP) rather than ARP.

This is what we've done here at work.  We use a combination of MII for fast
detection of local link loss, and ICMP ping packets to highly available hosts to
test the network path (with somewhat slower response time).

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
