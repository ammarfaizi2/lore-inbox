Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbUKLDzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbUKLDzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 22:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUKLDzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 22:55:42 -0500
Received: from ozlabs.org ([203.10.76.45]:40395 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262432AbUKLDzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 22:55:37 -0500
Subject: Re: 2.6.10-rc1-mm5: yenta_socket issue
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411111311.44664.rjw@sisk.pl>
References: <20041111012333.1b529478.akpm@osdl.org>
	 <200411111311.44664.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 12 Nov 2004 14:55:54 +1100
Message-Id: <1100231754.27128.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 13:11 +0100, Rafael J. Wysocki wrote:
> On Thursday 11 of November 2004 10:23, Andrew Morton wrote:
> > 
> > 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/
> 
> On an AMD64 box (Athlon 64 + NForce3) I get these messages from yenta_socket:
> 
> yenta_socket: Unknown symbol dead_socket
> yenta_socket: Unknown symbol pcmcia_register_socket
> yenta_socket: Unknown symbol pcmcia_socket_dev_resume
> yenta_socket: Unknown symbol pcmcia_parse_events
> yenta_socket: Unknown symbol pcmcia_socket_dev_suspend
> yenta_socket: Unknown symbol pcmcia_unregister_socket
> 
> but the module loads.

Well, if it spits that out it won't load.  Sounds like a modprobe.conf
doing something tricky (like trying to load yenta_socket, which fails,
then loading what it needs).

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

