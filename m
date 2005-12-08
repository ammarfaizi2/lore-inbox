Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVLHWRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVLHWRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVLHWRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:17:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:33452 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751247AbVLHWRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:17:50 -0500
Date: Thu, 8 Dec 2005 16:13:52 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Grover <andrew.grover@intel.com>, <netdev@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <john.ronciak@intel.com>,
       <christopher.leech@intel.com>
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
In-Reply-To: <4384F3AD.4080105@pobox.com>
Message-ID: <Pine.LNX.4.44.0512081606060.24134-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Jeff Garzik wrote:

> Alan Cox wrote:
> >>Additionally, current IOAT is memory->memory.  I would love to be able 
> >>to convince Intel to add transforms and checksums, 
> > 
> > 
> > Not just transforms but also masks and maybe even merges and textures
> > would be rather handy 8)
> 
> 
> Ah yes:  I totally forgot to mention XOR.
> 
> Software RAID would love that.

A number of embedded processors already have HW that does these kinda of
things.  On Freescale PPC processors there have been general purpose DMA
engines for mem<->mem and more recently and additional crypto engines that
allow for hashing, XOR, and security.

I'm actually searching for any examples of drivers that deal with the 
issues related to DMA'ng directly two and from user space memory.

I have an ioctl based driver that does copies back and forth between user 
and kernel space and would like to remove that since the crypto engine has 
full scatter/gather capability.

The only significant effort I've come across is Peter Chubb's work for 
user mode drivers which has some code for handling pinning of the user 
space memory and what looks like generation of a scatter list.

- kumar

