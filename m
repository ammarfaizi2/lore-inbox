Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVEMXfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVEMXfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVEMXeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:34:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:9410 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262625AbVEMXbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:31:48 -0400
Subject: Re: [PATCH 7/8] ppc64: SPU file system
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
In-Reply-To: <200505132129.07603.arnd@arndb.de>
References: <200505132117.37461.arnd@arndb.de>
	 <200505132129.07603.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 14 May 2005 09:31:18 +1000
Message-Id: <1116027079.5128.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> /run	A stub file that lets us do ioctl. The only ioctl
> 	method we need is the spu_run() call. spu_run suspends
> 	the current thread from the host CPU and transfers
> 	the flow of execution to the SPU.
> 	The ioctl call return to the calling thread when a state
> 	is entered that can not be handled by the kernel, e.g.
> 	an error in the SPU code or an exit() from it.
> 	When a signal is pending for the host CPU thread, the
> 	ioctl is interrupted and the SPU stopped in order to
> 	call the signal handler.

ioctl's are generally considered evil ... what about a write() method
writing a command ?

Ben.


