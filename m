Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261935AbSI3GRQ>; Mon, 30 Sep 2002 02:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbSI3GRQ>; Mon, 30 Sep 2002 02:17:16 -0400
Received: from dp.samba.org ([66.70.73.150]:4256 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261935AbSI3GRP>;
	Mon, 30 Sep 2002 02:17:15 -0400
Date: Mon, 30 Sep 2002 16:22:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Orinoco-devel] Re: Orinoco driver update
Message-ID: <20020930062243.GH10265@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020927025227.GC1898@zax> <3D94B7F5.6030401@pobox.com> <20020930050846.GG10265@zax> <3D97E30E.50703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D97E30E.50703@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 01:37:18AM -0400, Jeff Garzik wrote:
> David,
> 
> Linus applied 0.13a and that fixes things, thanks.
> 
> Two quick comments:
> * you need pci_set_drvdata(pdev,NULL) after pci_disable_disable in your 
> pci_driver::remove hook

Ok, I've added that before kfree()ing the net_device structure in both
orinoco_pci.c and orinoco_plx.c

> * I think it would look better to remove the struct pci_driver ->suspend 
> and ->resume hook references, if they are NULL (0)...

Hmm... I'd kind of prefer to leave them there, to remind me that the
suspend/resume hooks need to be implemented.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
