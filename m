Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVLAVQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVLAVQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVLAVQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:16:38 -0500
Received: from cantor.suse.de ([195.135.220.2]:36522 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932476AbVLAVQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:16:38 -0500
Date: Thu, 1 Dec 2005 22:16:28 +0100
From: Andi Kleen <ak@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davej@redhat.com
Subject: Re: [PATCH] Fix bytecount result from printk()
Message-ID: <20051201211628.GD997@wotan.suse.de>
References: <438F1D05.5020004@rtr.ca> <20051201175732.GD19433@redhat.com> <20051201.121554.130875743.davem@davemloft.net> <p737jaofg1o.fsf@verdi.suse.de> <438F6699.1080506@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438F6699.1080506@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I grep the 2.6.15-rc3 kernel tree, the *only* use of vprintk
> seems to be for doing printk().  It does not seem to be used for
> the sprintf/snprintf functions.  Actually it is the other way around,
> where vprintk() calls those functions.
> 
> So no problem there, and vprintk() really doesn't need to return anything.

That seems wrong. I'm pretty sure we don't have two different printf formatting engines.

-Andi
