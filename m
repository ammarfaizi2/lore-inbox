Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269775AbRHIMAq>; Thu, 9 Aug 2001 08:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269777AbRHIMAg>; Thu, 9 Aug 2001 08:00:36 -0400
Received: from mons.uio.no ([129.240.130.14]:10190 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S269775AbRHIMAW>;
	Thu, 9 Aug 2001 08:00:22 -0400
To: "Alex Kerkhove" <alex.kerkhove@staff.zeelandnet.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: x86 SMP and RPC/NFS problems
In-Reply-To: <1C48875BDE7ED0469485A5FD49925C4AF01265@zmx.staff.zeelandnet.nl>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Aug 2001 14:00:26 +0200
In-Reply-To: "Alex Kerkhove"'s message of "Wed, 8 Aug 2001 23:09:21 +0200"
Message-ID: <shs66bxigth.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alex Kerkhove <alex.kerkhove@staff.zeelandnet.nl> writes:

     > So my (blunt?) conclusion is that there must be some serious
     > problems with RPC/NFS (I guess RPC) and 2.4 SMP kernels! (and
     > lots of processes doing NFS stuff)


     > Anyone any thoughts on this?  My kernel hacking knowledge is
     > limited, but I'm willing to test patches :)

Could you try out the patch

  http://www.fys.uio.no/~trondmy/src/2.4.3/linux-2.4.3-rpc_smpfixes.dif

and see if it changes things?
The latter straightens out a number of iffy locking issues in the
net/sunrpc/xprt.c
Most of it will only hit you if you're doing NFS over TCP though...

Cheers,
  Trond
