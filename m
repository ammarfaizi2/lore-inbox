Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSFKOb3>; Tue, 11 Jun 2002 10:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317077AbSFKOb2>; Tue, 11 Jun 2002 10:31:28 -0400
Received: from mons.uio.no ([129.240.130.14]:59096 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317073AbSFKOb0>;
	Tue, 11 Jun 2002 10:31:26 -0400
To: Simon Matthews <simon@paxonet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS Client mis-behaviour?
In-Reply-To: <Pine.LNX.4.44.0206102041020.11116-100000@spare>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Jun 2002 16:31:00 +0200
Message-ID: <shs8z5lanvf.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Simon Matthews <simon@paxonet.com> writes:

     > Solution: the Ethernet interface was connected to a switch that
     > only supports half-duplex connecting to a full-duplex switch
     > solved the problem. However, it does seem that the NFS client
     > was not handling the situation well.

The NFS client neither knows nor cares what is going on down in the
ethernet layer. As far as it is concerned, you might as well be using
semaphore to pass messages between the computers.

All the NFS client needs to know is that it should retry the socket
sendmsg() operation when a certain (user defined) timeout value is
reached.

Cheers,
  Trond
