Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTIGW0a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 18:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTIGW0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 18:26:30 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48000 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261566AbTIGW03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 18:26:29 -0400
Subject: Re: Mapping large framebuffers into kernel space
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos@kronoz.cjb.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030907211850.41983.qmail@web14915.mail.yahoo.com>
References: <20030907211850.41983.qmail@web14915.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062973512.19548.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sun, 07 Sep 2003 23:25:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-07 at 22:18, Jon Smirl wrote:
> Is there something preventing kernel framebuffers from being mapped to the high
> end of the 4GB kernel address space? Or do they have to be mapped below 1GB?
> Framebuffer access isn't that performance sensitive, after all it is on the PCI bus.

The kernel has 4Gb of virtual address space. Because of the way x86
works it really wants to keep the user map, the view of main memory and 
io mappings visible at once. For larger objects you have to use kmap and
map them through a window (anyone remember they joys of EMS). On 64bit
this of course all goes away

