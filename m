Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTFXJ62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 05:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTFXJ62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 05:58:28 -0400
Received: from benzin.geggus.net ([213.146.112.23]:19980 "EHLO
	benzin.geggus.net") by vger.kernel.org with ESMTP id S261801AbTFXJ6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 05:58:20 -0400
Date: Tue, 24 Jun 2003 12:12:27 +0200
From: Sven Geggus <sven@gegg.us>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.21: NFS client Freeze
Message-ID: <20030624101227.GA21744@benzin.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-giggls-priority: very high :P
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

After mounting an NFS-Volume exported from a Windows Machine
(Hummingbird-NFS Maestro Server) a simple ls of the mount point causes an
almost complete freeze of the system (ping does still work, but nothing
else).

This did work fine in 2.4.20 but does not work on 2.4.21 anymore!

Here is the debug output I produced using:

echo 3 >/proc/sys/sunrpc/rpc_debug
echo 3 >/proc/sys/sunrpc/nfs_debug

RPC:   24 call_start nfs3 proc 1 (sync)
RPC:   24 call_reserve
RPC:   24 reserved req df16d078 xid 81c60017
RPC:   24 xprt_reserve returns 0
RPC:   24 call_reserveresult (status 0)
RPC:   24 call_allocate (status 0)
RPC:   24 call_encode (status 0)
RPC:   24 call_transmit (status 0)
RPC:   24 xprt_transmit(81c60017)
RPC:   24 xprt_cwnd_limited cong = 0 cwnd = 512
RPC:      xprt_sendmsg(0) = 108
RPC:      udp_data_ready...
RPC:      udp_data_ready client df16d000
RPC:   24 received reply
RPC:      cong 256, cwnd was 512, now 512
RPC:   24 has input (112 bytes)
RPC:   24 xmit complete
RPC:   24 call_status (status 112)
RPC:   24 call_decode (status 112)
RPC:   24 call_decode result 0
RPC:   24 release request df16d078
RPC:      rpc_release_client(dfd6b480, 2)
NFS: refresh_inode(7/395120 ct=1 info=0x6)
RPC:   25 call_start nfs3 proc 4 (sync)
RPC:   25 call_reserve
RPC:   25 reserved req df16d078 xid 81c60018
RPC:   25 xprt_reserve returns 0
RPC:   25 call_reserveresult (status 0)
RPC:   25 call_allocate (status 0)
RPC:   25 call_encode (status 0)
RPC:   25 call_transmit (status 0)
RPC:   25 xprt_transmit(81c60018)
RPC:   25 xprt_cwnd_limited cong = 0 cwnd = 512
RPC:      xprt_sendmsg(0) = 112
RPC:   25 xmit complete
RPC:      udp_data_ready...
RPC:      udp_data_ready client df16d000
RPC:   25 received reply
RPC:      cong 256, cwnd was 512, now 512
RPC:   25 has input (36 bytes)
RPC:   25 call_status (status 36)
RPC:   25 call_decode (status 36)
RPC:   25 call_decode result 0
RPC:   25 release request df16d078
RPC:      rpc_release_client(dfd6b480, 2)
NFS: readdir_search_pagecache() searching for cookie 0
NFS: find_dirent_page() searching directory page 0
NFS: nfs_readdir_filler() reading cookie 0 into page 0.
RPC:   26 call_start nfs3 proc 16 (sync)
RPC:   26 call_reserve
RPC:   26 reserved req df16d078 xid 81c60019
RPC:   26 xprt_reserve returns 0
RPC:   26 call_reserveresult (status 0)
RPC:   26 call_allocate (status 0)
RPC:   26 call_encode (status 0)
RPC:   26 call_transmit (status 0)
RPC:   26 xprt_transmit(81c60019)
RPC:   26 xprt_cwnd_limited cong = 0 cwnd = 512
RPC:      xprt_sendmsg(0) = 128
RPC:   26 xmit complete
RPC:      udp_data_ready...
RPC:      udp_data_ready client df16d000
RPC:   26 received reply
RPC:      cong 256, cwnd was 512, now 512
RPC:   26 has input (760 bytes)
RPC:   26 call_status (status 760)
RPC:   26 call_decode (status 760)

Regards

Sven

-- 
.. this message has been created using an outdated OS (UNIX-like) with an 
outdated mail- or newsreader (text-only) :-P

/me is giggls@ircnet, http://sven.gegg.us/ on the Web

