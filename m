Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTIGTNU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbTIGTNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:13:20 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:61419 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261296AbTIGTNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:13:19 -0400
Subject: Re: Mapping large framebuffers into kernel space
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos@kronoz.cjb.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030907182144.87346.qmail@web14906.mail.yahoo.com>
References: <20030907182144.87346.qmail@web14906.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062961922.19114.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sun, 07 Sep 2003 20:12:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-07 at 19:21, Jon Smirl wrote:
> I'm beginning to wonder if framebuffers should be mapped into kernel space. 
> What's going to happen when I get a 512MB video card? Does the framebuffer have
> to be mapped in the first 1GB of kernel address space?

Yes but it shouldnt be mapping all of it blindly like that. Vesafb was
fixed for this, radeonfb needs fixing

> If the framebuffer is mapped, it's a perfect candidate for a large page table
> entry because it is a very large piece of linear memory that not's going to be paged.

By the time we need to really kernel map 512Mb of frame buffer hopefully
32bit will be dead 8)

