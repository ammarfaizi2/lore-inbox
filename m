Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRCTJkU>; Tue, 20 Mar 2001 04:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRCTJkL>; Tue, 20 Mar 2001 04:40:11 -0500
Received: from samar.sasken.com ([164.164.56.2]:52462 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S129595AbRCTJjy>;
	Tue, 20 Mar 2001 04:39:54 -0500
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-b.sasi.com
From: Praveen Rajendran <rp@sasken.com>
Subject: need help with netlink sockets
Date: Tue, 20 Mar 2001 20:37:32 +0530
Organization: Sasken Communication Technologies Limited
Message-ID: <3AB77234.6D227B47@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: ncc-c.sasi.com 985080988 22952 10.0.35.252 (20 Mar 2001 09:36:28 GMT)
X-Complaints-To: usenet@sasi.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
Xref: ncc-b.sasi.com maillist.linux-kernel:141548
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The NETLINK_ROUTE family deifned as a part of the netlink socket
protocol has the data handler of the sock structure set to
rtnetlinl_rcv. However this function dequeues the data packet ( in the
skb ) from the  receive queue of the sock structure and processes it if
the flag in the nlmsghdr is set ot NLM_F_REQUEST.

While sending information back to the user this flag is not set. So the
packet is dequeued and lost . Arnt there provisions made to handle
packets from the kernel to the user ?

Thanks in advance

Praveen


