Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTGTGEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 02:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTGTGEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 02:04:16 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:57870 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262254AbTGTGEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 02:04:15 -0400
Date: Sun, 20 Jul 2003 07:19:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH] missing __KERNEL__ ifdef in include/linux/device.h]
Message-ID: <20030720071913.A22156@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <3F1A139B.3090708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F1A139B.3090708@pobox.com>; from jgarzik@pobox.com on Sat, Jul 19, 2003 at 11:59:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 11:59:23PM -0400, Jeff Garzik wrote:

> Date: Sun, 20 Jul 2003 04:55:29 +0200
> From: Thomas Graf <tgraf@suug.ch>
> Subject: [PATCH] missing __KERNEL__ ifdef in include/linux/device.h
> To: netdev@oss.sgi.com
> 
> Hello
> 
> device.h should be protected with __KERNEL__ because it uses
> __KERNEL__ protected structures. Userspace applications
> including if_arp.h such as iproute2 will fail because
> it finally includes device.h as well.

This is b0rked.  People shouldn't include kernel headers from userspace
for one thing, and if you want to share a single copy of a header for
userspace and kernelspace you have to take of the ifdefs yourself if
including kernel-only headers such as device.h

