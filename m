Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVGGQmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVGGQmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVGGQkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:40:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261454AbVGGQig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:38:36 -0400
Date: Thu, 7 Jul 2005 09:38:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
In-Reply-To: <Pine.LNX.4.62.0507070912140.27066@graphe.net>
Message-ID: <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jul 2005, Christoph Lameter wrote:
> 
> Here is IMHO the right way to fix this. Test for the hwif != NULL and
> test for pci_dev != NULL before determining the node number of the pci 
> bus that the device is connected to.

I think this is pretty unreadable.

If you make it use a trivial inline function for the thing, I think that 
would be ok, though.

Complex expressions are bad.

		Linus
