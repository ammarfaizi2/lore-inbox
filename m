Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVGFXxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVGFXxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVGFUHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:07:16 -0400
Received: from graphe.net ([209.204.138.32]:40391 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262457AbVGFS27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:28:59 -0400
Date: Wed, 6 Jul 2005 11:28:57 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
In-Reply-To: <20050706181349.GN21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507061125410.31145@graphe.net>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net>
 <20050706175603.GL21330@wotan.suse.de> <Pine.LNX.4.62.0507061058260.30702@graphe.net>
 <20050706181349.GN21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> > > Patching every driver in existence? That sounds like a lot of
> > > work. 
> > 
> > No just patch those that would benefit from it. The existing 
> 
> This would be "all devices that SGI ships on Altixes" ?

Anyone can patch devices drivers. High performance drivers suffer the most 
from wrong node placement. These are most likely 10G ethernet, high speed 
scsi etc.

The main concern at this point are the higher abstraction layers. These 
are generic and if they do the right thing then we have already come a 
long way.

> IMHO all can benefit.

Absolutely. 
