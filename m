Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSK0RBO>; Wed, 27 Nov 2002 12:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSK0RBO>; Wed, 27 Nov 2002 12:01:14 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:28839 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP
	id <S263544AbSK0RBM>; Wed, 27 Nov 2002 12:01:12 -0500
Date: Wed, 27 Nov 2002 15:08:28 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
Message-ID: <20021127150828.A12120@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br> <shsy99f16np.fsf@charged.uio.no> <20021003202602.M3869@blackjesus.async.com.br> <15772.60202.510717.850059@charged.uio.no> <20021120120223.A15034@blackjesus.async.com.br> <15835.49194.109931.227732@charged.uio.no> <20021126224123.A9660@blackjesus.async.com.br> <15844.7306.735524.133781@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15844.7306.735524.133781@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Nov 27, 2002 at 02:14:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 02:14:50AM +0100, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > a) ps ax | grep lockd returns:
> 
>      >    94 ?  DW 0:00 [lockd]
> 
>      >     Why would lockd be in state "D"? Looks bad. Can this happen
>      >     in normal usage? It kicks the loadavg up 1 point.
> <snip>
>      >     [ 10-second delay here ]
> 
>      >     09:24:18.988289 violinux.async.com.br.793 >
>      >     anthem.async.com.br.sometimes-rpc4: udp 180 (DF)
> 
>      >     [ 11-second delay here ]
> 
> OK, so you are sending out the RPC request to the server's NLM daemon,
> which is clearly receiving the packet (since tcpdump was able to log
> it), but is never sending a reply. Are you seeing any kernel messages
> in the syslog?

Hmmm. Ran into this again this morning and right now when starting up
one of the boxes. A reboot of the workstation fixed it for the while.

What can I do to help further debug the issue? Try another kernel
version on clients? Server? This is giving me a headache.. :-/

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
