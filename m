Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUFNSJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUFNSJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUFNSJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:09:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28872 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263714AbUFNSJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:09:34 -0400
Subject: upcalls from kernel code to user space daemons
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1087236468.10367.27.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Jun 2004 13:07:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a good terse example of an upcall from a kernel module (such as
filesystem) to an optional user space helper daemon?   The NFS RPC
example seems more complicated than what I would like as does the
captive ioctl approach which I see in a few places.

I simply need to poke a userspace daemon (e.g. launched by mount) to do
in userspace these two optional functions which are not available in
kernel and pass a small (under 64K) amount of data back to the kernel
module:
1) getHostByName:  when the kernel cifs code detects a server crashes
and fails reconnecting the socket and the kernel code wants to see if
the hostname now has a new ip address.
2) package a kerberos ticket ala RFC2478 (SPNEGO)

And an only very loosely related question - 
The proc interface for returning debug information or stats is somewhat
awkward to use for returned data greater than about 1K - I had trouble
finding a good example of kernel code using /proc to return debug data
larger than that since it involves repeated calls into the pseudofile's
proc read function with careful setting of some offset/lengths which can
be hard when iterating through dynamically generated variable length
debug information.  Is there a good example of that?



