Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264315AbTCYXK6>; Tue, 25 Mar 2003 18:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264328AbTCYXK6>; Tue, 25 Mar 2003 18:10:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15286
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264315AbTCYXK6>; Tue, 25 Mar 2003 18:10:58 -0500
Subject: Re: [PATCH 2.5] Make root PCI bus child of system_bus in device
	tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dsaxena@mvista.com
Cc: mochel@osdl.org, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030325231622.GA8231@xanadu.az.mvista.com>
References: <20030325231622.GA8231@xanadu.az.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048638924.29988.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 00:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 23:16, Deepak Saxena wrote:
> All,
> 
> The following patch updates the PCI subsystem so that root PCI host 
> bridges appear as devices hanging off the system bus instead of root 

This seems odd for some systems we support. Older PARISC for example
have PCI busses hanging off gecko. I do agree with you for the general
case. So systems whose root level bridges are 'normal' should reflect
this and I guess others should attach them to the relevant bus.

Over time it seems that PCI is going to become a secondary bus like
ISA did as well. In fact it already has in many ways, its just things
like VLINK and the Intel hub busses look like PCI to us

