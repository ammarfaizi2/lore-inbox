Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSK0BHr>; Tue, 26 Nov 2002 20:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSK0BHr>; Tue, 26 Nov 2002 20:07:47 -0500
Received: from mons.uio.no ([129.240.130.14]:42945 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261978AbSK0BHr>;
	Tue, 26 Nov 2002 20:07:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15844.7306.735524.133781@charged.uio.no>
Date: Wed, 27 Nov 2002 02:14:50 +0100
To: Christian Reis <kiko@async.com.br>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, NFS@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
In-Reply-To: <20021126224123.A9660@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br>
	<shsy99f16np.fsf@charged.uio.no>
	<20021003202602.M3869@blackjesus.async.com.br>
	<15772.60202.510717.850059@charged.uio.no>
	<20021120120223.A15034@blackjesus.async.com.br>
	<15835.49194.109931.227732@charged.uio.no>
	<20021126224123.A9660@blackjesus.async.com.br>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > a) ps ax | grep lockd returns:

     >    94 ?  DW 0:00 [lockd]

     >     Why would lockd be in state "D"? Looks bad. Can this happen
     >     in normal usage? It kicks the loadavg up 1 point.
<snip>
     >     [ 10-second delay here ]

     >     09:24:18.988289 violinux.async.com.br.793 >
     >     anthem.async.com.br.sometimes-rpc4: udp 180 (DF)

     >     [ 11-second delay here ]

OK, so you are sending out the RPC request to the server's NLM daemon,
which is clearly receiving the packet (since tcpdump was able to log
it), but is never sending a reply. Are you seeing any kernel messages
in the syslog?

BTW: the tcpdumps you're showing are all UDP, not TCP...

Cheers,
  Trond
