Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbRA3Wan>; Tue, 30 Jan 2001 17:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbRA3Wac>; Tue, 30 Jan 2001 17:30:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12422 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132703AbRA3WaR>;
	Tue, 30 Jan 2001 17:30:17 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14967.16395.42967.978677@pizda.ninka.net>
Date: Tue, 30 Jan 2001 14:28:27 -0800 (PST)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A76D6A4.2385185E@uow.edu.au>
In-Reply-To: <3A76B72D.2DD3E640@uow.edu.au>
	<3A728475.34CF841@uow.edu.au>
	<3A726087.764CC02E@uow.edu.au>
	<20010126222003.A11994@vitelus.com>
	<14966.22671.446439.838872@pizda.ninka.net>
	<14966.47384.971741.939842@pizda.ninka.net>
	<3A76D6A4.2385185E@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > The box has 130 mbyte/sec memory write bandwidth, so saving
 > a copy should save 10% of this.   (Wanders away, scratching
 > head...)

Are you sure your measurment program will account properly
for all system cycles spent in softnet processing?  This is
where the bulk of the cpu cycle savings will occur.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
