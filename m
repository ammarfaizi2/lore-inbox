Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVGGAXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVGGAXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVGFT7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:59:49 -0400
Received: from graphe.net ([209.204.138.32]:16773 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262263AbVGFQee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:34:34 -0400
Date: Wed, 6 Jul 2005 09:34:28 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
In-Reply-To: <20050706133052.GF21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507060933330.20107@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> -	q = blk_init_queue_node(do_ide_request, &ide_lock,
> -				pcibus_to_node(drive->hwif->pci_dev->bus));
> +	int node = 0; /* Should be -1 */

Why is this not -1?

> +		int node = 0; 
> +		if (hwif->drives[0].hwif) { 

Also needs to be -1.

