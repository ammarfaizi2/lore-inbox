Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264342AbTCYXSg>; Tue, 25 Mar 2003 18:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264353AbTCYXSg>; Tue, 25 Mar 2003 18:18:36 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:50159 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264342AbTCYXSf>; Tue, 25 Mar 2003 18:18:35 -0500
Date: Tue, 25 Mar 2003 16:31:18 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dsaxena@mvista.com, mochel@osdl.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] Make root PCI bus child of system_bus in device tree
Message-ID: <20030325233118.GA16920@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <20030325231622.GA8231@xanadu.az.mvista.com> <1048638924.29988.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048638924.29988.21.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26 2003, at 00:35, Alan Cox was caught saying:
> On Tue, 2003-03-25 at 23:16, Deepak Saxena wrote:
> > All,
> > 
> > The following patch updates the PCI subsystem so that root PCI host 
> > bridges appear as devices hanging off the system bus instead of root 
> 
> This seems odd for some systems we support. Older PARISC for example
> have PCI busses hanging off gecko. I do agree with you for the general
> case. So systems whose root level bridges are 'normal' should reflect
> this and I guess others should attach them to the relevant bus.
> 
> Over time it seems that PCI is going to become a secondary bus like
> ISA did as well. In fact it already has in many ways, its just things
> like VLINK and the Intel hub busses look like PCI to us

Sounds like more reasoning to just force the caller to provide a parent.
'normal' is a moving target and I'd rather not have the code making 
assumptions and let the platform's kernel developer explictly map
the PCI bridge into the system.

~Deepak

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com

