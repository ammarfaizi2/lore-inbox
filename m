Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129416AbQJaUVn>; Tue, 31 Oct 2000 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbQJaUVe>; Tue, 31 Oct 2000 15:21:34 -0500
Received: from k2.llnl.gov ([134.9.1.1]:34559 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S129050AbQJaUVS>;
	Tue, 31 Oct 2000 15:21:18 -0500
Message-ID: <39FEE2C8.1CC82DF2@scs.ch>
Date: Tue, 31 Oct 2000 07:18:32 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FCB09E.93B657EC@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I'm following this thread, you guys seem to forget the _basics_:
The Linux networking stack sucks!

Everybody tries to work around the networking stack. We just recently
developped a rpc protocol which makes 180MBytes/second (over a Quadrics
Network) because the linux network layer was way too slow. At speeds
above 100MBytes/s, copies start to hurt.

Why not solve the problem at the source and completely redesign the
network stack? Get rid of the old sk_buff & co! Rip the whole network
layer out! Redesign it and give the user a possibility of Zero-Copy
networking!

Reto
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
