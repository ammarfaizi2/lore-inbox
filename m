Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUCFRQz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 12:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUCFRQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 12:16:55 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:20096 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S261725AbUCFRQy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 12:16:54 -0500
Subject: Re: NFS problems with 2.6.4-rc1-mm2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1078571454.3811.3.camel@twins>
References: <1078430862.3793.5.camel@twins> <1078500855.3809.12.camel@twins>
	 <20040305143727.5397d76e.akpm@osdl.org>  <1078571454.3811.3.camel@twins>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1078593407.2027.2.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 12:16:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 06/03/2004 klokka 06:10, skreiv Peter Zijlstra:
> The bad guy is: 
> 	nfs-tunable-rpc-slot-table.patch
> without that patch nfs works fine for me.
> 
> As said I use NFSv3 over TCP, and its a SMP machine
> that has the problem, I haven't tried any UP box.

I have no such problems on my SMP boxes. Could you try just resetting
the default TCP slot size to 16?

sysctl -w sunrpc.tcp_slot_table_entries=16

that should in theory give you the same settings as without the above
patch.

Cheers,
  Trond
