Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265758AbUFRXW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265758AbUFRXW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUFRXUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:20:54 -0400
Received: from hera.kernel.org ([63.209.29.2]:35013 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264965AbUFRXJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:09:10 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: upcalls from kernel code to user space daemons
Date: Fri, 18 Jun 2004 23:08:29 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cavsld$bem$1@terminus.zytor.com>
References: <1087236468.10367.27.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1087600109 11735 127.0.0.1 (18 Jun 2004 23:08:29 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 18 Jun 2004 23:08:29 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1087236468.10367.27.camel@stevef95.austin.ibm.com>
By author:    Steve French <smfltc@us.ibm.com>
In newsgroup: linux.dev.kernel
>
> Is there a good terse example of an upcall from a kernel module (such as
> filesystem) to an optional user space helper daemon?   The NFS RPC
> example seems more complicated than what I would like as does the
> captive ioctl approach which I see in a few places.
> 

autofs does this by having the kernel write to the write-end of a
pipe, and have the userspace daemon read from the read end of the same
pipe.

The same thing can be done with sockets.

	-hpa

