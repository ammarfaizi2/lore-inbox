Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVGGQaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVGGQaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVGGQ2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:28:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:55688 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261355AbVGGQYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:24:44 -0400
Date: Thu, 7 Jul 2005 18:24:42 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Message-ID: <20050707162442.GI21330@wotan.suse.de>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507070912140.27066@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 09:21:55AM -0700, Christoph Lameter wrote:
> On Wed, 6 Jul 2005, Andi Kleen wrote:
> 
> > Without this patch a dual Xeon EM64T machine would oops on boot
> > because the hwif pointer here was NULL. I also added a check for
> > pci_dev because it's doubtful that all IDE devices have pci_devs.
> 
> Here is IMHO the right way to fix this. Test for the hwif != NULL and
> test for pci_dev != NULL before determining the node number of the pci 
> bus that the device is connected to. Maybe we need a hwif_to_node for ide 
> drivers that is also able to determine the locality of other hardware?

Hmm? Where is the difference? 

This is 100% equivalent to my code except that you compressed
it all into a single expression.

The former one was more readable.

-Andi

