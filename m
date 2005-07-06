Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVGGAXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVGGAXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVGFT7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:59:52 -0400
Received: from graphe.net ([209.204.138.32]:19845 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262234AbVGFQfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:35:36 -0400
Date: Wed, 6 Jul 2005 09:35:32 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
In-Reply-To: <20050706133248.GG21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507060934360.20107@graphe.net>
References: <20050706133248.GG21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> Instead of adding messy kmalloc_node()s everywhere run the 
> PCI driver probe on the node local to the device.
> Then the normal NUMA aware allocators do the right thing.

That depends on the architecture. Some do round robin allocs for periods 
of time during bootup. I think it is better to explicitly place control 
structures.
