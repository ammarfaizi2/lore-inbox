Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTBKXzk>; Tue, 11 Feb 2003 18:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbTBKXzk>; Tue, 11 Feb 2003 18:55:40 -0500
Received: from pat.uio.no ([129.240.130.16]:26806 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S266840AbTBKXzj>;
	Tue, 11 Feb 2003 18:55:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15945.36788.945931.141582@charged.uio.no>
Date: Wed, 12 Feb 2003 01:05:08 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Oleg Drokin <green@namesys.com>, David Ford <david+powerix@blue-labs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Current NFS issues (2.5.59)
In-Reply-To: <15945.30044.444455.162630@notabene.cse.unsw.edu.au>
References: <3E46E1D6.20709@blue-labs.org>
	<15944.30340.955911.798377@notabene.cse.unsw.edu.au>
	<20030211100011.A5850@namesys.com>
	<15944.60247.512630.175678@charged.uio.no>
	<20030211163119.A24157@namesys.com>
	<15945.30044.444455.162630@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Neil Brown <neilb@cse.unsw.edu.au> writes:


     > Feb 12 09:11:35 kamen kernel: RPC: udp_data_ready...  Feb 12
     > 09:11:35 kamen kernel: RPC: udp_data_ready client e6219000 Feb

     > which seems to suggest that the reply is coming back from the
     > server (RPC: udp_data_ready) but there is no sign of the client
     > getting it...

On the contrary. The above shows that the client is indeed receiving
some data, but for some reason it is not accepting that data as a
valid reply. It looks as if either skb_recv_datagram() or
xprt_lookup_rqst() is failing.

BTW: I'm still not seeing any such trouble with these loopback mounts
on my own machine. Could it be an SMP problem?

Cheers,
  Trond
