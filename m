Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUHCAGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUHCAGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUHCAGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:06:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:64153 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264560AbUHCAGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:06:40 -0400
Subject: Re: OLS and console rearchitecture
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200408021133.09935.jbarnes@engr.sgi.com>
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
	 <200408021133.09935.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1091491312.7387.85.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 10:01:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> It should probably be a real device driver rather than a sysfs pseudofile.  
> Not sure if it should be dynamic or not though.  It would be nice if apps 
> used the driver to do legacy VGA I/O port accesses as well, since that would 
> make things easier on platforms that unconditionally master abort when a PIO 
> times out, and would probably make it easier to deal with multiple domains.

I strongly agree. Also, access to VGA memory (in case that is necessary)
should be provided via MMAP on this driver too.

There are other reasons than master aborts to go that way, like platforms
that have multiple PCI domains with separate IO spaces that can accomodate
VGA cards in several of them.

Ben.


