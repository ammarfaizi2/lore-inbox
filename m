Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267231AbSK3Lcj>; Sat, 30 Nov 2002 06:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267232AbSK3Lcj>; Sat, 30 Nov 2002 06:32:39 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:39119 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267231AbSK3Lci>; Sat, 30 Nov 2002 06:32:38 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Sat, 30 Nov 2002 12:11:31 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: [2.5] ipsec + iptables
Message-ID: <20021130111131.GA30922@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi *,

Is there any documentation on how the new 2.5 ipsec plays together with
itables?  How do ipsec packets traverse the tables?  Where is the
encryption/decryption of the packets done?  In transport mode?  In
tunnel mode?

The freeswan documentation is quite clear about this:  For example
incoming packets:  The paket filters see the packets twice:  Once from
the physical device (eth0, ppp0, whatever), with data still encrypted
and protocol 50/51, and once from the attached virtual ipsec<n> device,
after decryption in cleartext (so iptables actually sees what tcp/udp
port it is addressed to, ...).

How does the new ipsec code work compared to that?  Probably different
as there is no virtual ipsec<n> device any more, but how exactly?

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
