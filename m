Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSKMQmz>; Wed, 13 Nov 2002 11:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSKMQmz>; Wed, 13 Nov 2002 11:42:55 -0500
Received: from mons.uio.no ([129.240.130.14]:15754 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262129AbSKMQmy>;
	Wed, 13 Nov 2002 11:42:54 -0500
To: root@chaos.analogic.com
Cc: Chuck Lever <cel@citi.umich.edu>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new timeout behavior for RPC requests on TCP sockets
References: <Pine.LNX.3.95.1021113113943.2196A-100000@chaos.analogic.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Nov 2002 17:49:30 +0100
In-Reply-To: <Pine.LNX.3.95.1021113113943.2196A-100000@chaos.analogic.com>
Message-ID: <shsd6p9mn39.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:

     > If the application "chooses to drop the request", the kernel is
     > not required to fix that application. The RPC cannot retransmit
     > if it has been shut-down or disconnected, which is about the
     > only way the application could "choose to drop the request". So
     > something doesn't smell right here.

An NFS server is perfectly free to drop an RPC request if it doesn't
have the necessary free resources to service it (i.e. if it is out of
memory). If the client doesn't time out + retry, you lose data. Not a
good idea...

Cheers,
  Trond
