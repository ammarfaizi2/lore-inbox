Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269321AbUJFQBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbUJFQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269323AbUJFQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:01:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:43697 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269321AbUJFQBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:01:23 -0400
Date: Wed, 6 Oct 2004 08:59:28 -0700
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: root@chaos.analogic.com, joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006085928.63b44be6.pj@sgi.com>
In-Reply-To: <20041006082145.7b765385.davem@davemloft.net>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	<20041006080104.76f862e6.davem@davemloft.net>
	<Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
	<20041006082145.7b765385.davem@davemloft.net>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
> So like I said, there is no such guarentee.

The select(2) man page states:

  more precisely, to see if a read will not block

It doesn't say _which_ read won't block.  Seems to me that the
successful non-block read in the other thread qualifies as the
promised non-blocking read.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
