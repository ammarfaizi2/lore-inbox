Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132473AbRBRJlk>; Sun, 18 Feb 2001 04:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbRBRJla>; Sun, 18 Feb 2001 04:41:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42624 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132473AbRBRJlT>;
	Sun, 18 Feb 2001 04:41:19 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14991.38968.898918.345197@pizda.ninka.net>
Date: Sun, 18 Feb 2001 01:39:04 -0800 (PST)
To: kuznet@ms2.inr.ac.ru
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), roger@kea.GRace.CRi.NZ,
        linux-kernel@vger.kernel.org
Subject: Re: MTU and 2.4.x kernel
In-Reply-To: <200102151933.WAA20558@ms2.inr.ac.ru>
In-Reply-To: <E14TTRF-0000Ul-00@the-village.bc.nu>
	<200102151933.WAA20558@ms2.inr.ac.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kuznet@ms2.inr.ac.ru writes:
 > A. Datagram protocols do not work with mtus not allowing to send
 >    512 byte frames (even DNS).

This smells bad.  Datagram protocol send sizes are only limited by
socket buffer size, nothing more.  Fragmentation makes it work.

If you are really talking about side effects of UDP path-mtu, then I
will turn off UDP path-mtu by default in 2.4.x because it is obviously
very broken either conceptually or in our implementation. :-)

Later,
David S. Miller
davem@redhat.com
