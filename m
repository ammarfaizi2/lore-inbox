Return-Path: <linux-kernel-owner+w=401wt.eu-S1750985AbXAFAyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbXAFAyL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXAFAyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:54:10 -0500
Received: from iabervon.org ([66.92.72.58]:2930 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbXAFAyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:54:09 -0500
Date: Fri, 5 Jan 2007 19:54:06 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Petr Vandrovec <petr@vandrovec.name>
cc: Roland Dreier <rdreier@cisco.com>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Unbreak MSI on ATI devices
In-Reply-To: <459E1535.5020105@vandrovec.name>
Message-ID: <Pine.LNX.4.64.0701051902090.20138@iabervon.org>
References: <20061221075540.GA21152@vana.vc.cvut.cz> <ada4pr61mie.fsf@cisco.com>
 <459E1535.5020105@vandrovec.name>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Petr Vandrovec wrote:

> Hi,
>   unfortunately it is not everything :-(
> 
> I cannot get MSI to work on IDE interface under any circumstances - in legacy
> mode it always uses IRQ14/15 regardless of whether MSI is enabled or not
> (that's probably correct), but in native mode as soon as I enable MSI it
> either does not deliver interrupts at all (definitely not through IRQ14/15,
> and, if I got routing right, also not through its INTA#), or it delivers them
> somewhere else than where programmed.  As my boot device is connected to this
> adapter, and it is a notebook, it is not easy to debug what's really going on
> :-(

Are you doing this with INTx left on or turned off? Have you determined 
whether turning off INTx does anything useful on these devices when you're 
not using MSI? (There are only a few places in the kernel which disable 
INTx, mostly associated with enabling MSI.)

It might be easier to test if you boot off a USB storage device of some 
sort.

	-Daniel
*This .sig left intentionally blank*
