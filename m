Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTBDFXO>; Tue, 4 Feb 2003 00:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTBDFXO>; Tue, 4 Feb 2003 00:23:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14022 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267052AbTBDFXN>;
	Tue, 4 Feb 2003 00:23:13 -0500
Date: Mon, 03 Feb 2003 21:19:33 -0800 (PST)
Message-Id: <20030203.211933.27826107.davem@redhat.com>
To: greearb@candelatech.com
Cc: john@grabjohn.com, cfriesen@nortelnetworks.com, ahu@ds9a.nl,
       linux-kernel@vger.kernel.org
Subject: Re: problems achieving decent throughput with latency.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E3EAF04.9010308@candelatech.com>
References: <200302031611.h13GBl9D019119@darkstar.example.net>
	<3E3EAF04.9010308@candelatech.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Mon, 03 Feb 2003 10:03:48 -0800
   
   Also, if it's as simple as allocating a few more buffers for tcp, maybe we
   should consider defaulting to higher in the normal kernel?  (I'm not suggesting
   **my** numbers..)

The current values are the only "safe" defaults.  Here "safe" means
that if you have thousands of web connections, clients cannot force
the serve to queue large amounts of traffic per socket.

The attack goes something like: Open N thousand connections to
server, ask for large static object, do not ACK any of the data
packets.  Server must thus hold onto N thousnad * maximum socket
write buffer bytes amount of memory.


