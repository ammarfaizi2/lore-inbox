Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293748AbSCKN7n>; Mon, 11 Mar 2002 08:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293746AbSCKN7e>; Mon, 11 Mar 2002 08:59:34 -0500
Received: from pat.uio.no ([129.240.130.16]:51373 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S293747AbSCKN7S>;
	Mon, 11 Mar 2002 08:59:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15500.47144.705329.809604@charged.uio.no>
Date: Mon, 11 Mar 2002 14:59:04 +0100
To: Oleg Drokin <green@namesys.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, trond.myklebust@fys.uio.no,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <20020311165140.A1839@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311155937.A1474@namesys.com>
	<20020311154852.3981c188.skraw@ithnet.com>
	<20020311165140.A1839@namesys.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Oleg Drokin <green@namesys.com> writes:

     > Trod, do you think that'll work or should some other non-ext2
     > fs be tried?

Ext2 should work fine: I've never seen any problems such as that which
Stephan describes, and certainly not with 2.4.18 clients.

In any case, any occurence of an ESTALE error *must* first have
originated from the server. The client itself cannot determine that a
filehandle is stale.

Cheers,
  Trond
