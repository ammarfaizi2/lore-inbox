Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVIGORa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVIGORa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVIGORa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:17:30 -0400
Received: from kanga.kvack.org ([66.96.29.28]:51100 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751219AbVIGORa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:17:30 -0400
Date: Wed, 7 Sep 2005 10:16:51 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: =?iso-8859-1?Q?M=E0rius_Mont=F3n?= <Marius.Monton@uab.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'virtual HW' into kernel (SystemC)
Message-ID: <20050907141651.GA10075@kvack.org>
References: <431EC16B.2040604@uab.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431EC16B.2040604@uab.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 12:31:07PM +0200, Màrius Montón wrote:
> At this point, we plan to develop a pci device driver to act as a bridge
> between kernel PCI subsystem and SystemC simulator (in user space).
> 
> Do you think this implementation is fine? Maybe it's better to register
> a new bus
> subsystem and link to a daemon to user space to run SystemC simulations?
> We are open to any idea or suggestion about it.

That's actually quite a difficult approach to take as you aren't able to 
fully simulate how the hardware interacts with the system, making concerns 
like timing very difficult to accurately model.  A better approach is to 
tie into a full system simulator -- qemu makes it very easy to add a new 
pci device into the system.  This way your hardware simulator doesn't have 
to worry about the complexities of kernel programming, and the resulting 
device drivers doesn't need hooks for the simulator as it would see the 
pci device as if it were installed in a system.

Btw, do you know of any inexpensive ways to be introduced SystemC 
development on FPGAs?  Cheers,

		-ben
