Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281484AbRKZG7p>; Mon, 26 Nov 2001 01:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281489AbRKZG7f>; Mon, 26 Nov 2001 01:59:35 -0500
Received: from quechua.inka.de ([212.227.14.2]:22110 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S281484AbRKZG7W>;
	Mon, 26 Nov 2001 01:59:22 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: net/ipv4/arp.c: arp_rcv, rfc2131 BREAKS communication
In-Reply-To: <20011125181921.A16765@panama>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E168Fjc-0008H6-00@calista.inka.de>
Date: Mon, 26 Nov 2001 07:59:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011125181921.A16765@panama> you wrote:
> Shows a pseudo-code that indicates a check should
> be performed to see if THA is "ours" and if not, discard the packet

Ethernet cards are dropping other addresses, but if it is in promisc mode it
may catch some miss addressed. Therefore Linux Kernel is checking all
incoming frames and mark them OTHERHOST. This means they can travel up the
packet capture sockets, but are never handed to application tcp/udp sockets.

Greetings
Bernd
