Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSKNT0x>; Thu, 14 Nov 2002 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSKNT0x>; Thu, 14 Nov 2002 14:26:53 -0500
Received: from mons.uio.no ([129.240.130.14]:46267 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264686AbSKNT0w>;
	Thu, 14 Nov 2002 14:26:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15827.64148.272459.600067@helicity.uio.no>
Date: Thu, 14 Nov 2002 20:33:40 +0100
To: root@chaos.analogic.com
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Chuck Lever <cel@citi.umich.edu>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new timeout behavior for RPC requests on TCP sockets
In-Reply-To: <Pine.LNX.3.95.1021114133025.13043B-100000@chaos.analogic.com>
References: <shsd6p8qhul.fsf@charged.uio.no>
	<Pine.LNX.3.95.1021114133025.13043B-100000@chaos.analogic.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:


     > Because all of the RPC stuff was, initially, user-mode
     > code. For performance reasons or otherwise, it was moved into
     > the kernel.  Okay, so far? Now, when something goes wrong with
     > that code, should that code be fixed, or should the unrelated
     > TCP/IP code be modified to accommodate? I think the time-outs
     > should be put at the correct places and not added to generic
     > network code.

No. The kernel RPC code has never been user mode code, nor has it ever
been exported to userland. It exists purely for the benefit of NFS and
friends. It is located in a subdirectory of the network code, but it
is certainly not 'generic network code'.

Cheers,
  Trond
