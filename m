Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUHOU2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUHOU2e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUHOU2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:28:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266891AbUHOU2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:28:23 -0400
Date: Sun, 15 Aug 2004 16:27:22 -0400
From: Alan Cox <alan@redhat.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: PATCH: fixup incomplete ident blocks on ITE raid volumes
Message-ID: <20040815202722.GA29861@devserv.devel.redhat.com>
References: <20040815144527.GA7983@devserv.devel.redhat.com> <1092601693.8976.140.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092601693.8976.140.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 10:28:13PM +0200, Martin Schlemmer wrote:
> > +		}
> > +		id->cyls = 1 + id->lba_capacity_2 / (id->heads * id->sectors);
> > +		/* LBA28 is ok, DMA is ok, UDMA data is valid */

Change that to use sector_div() and it should be fine. My gcc didn't end
up generating internal gcc library helpers for that so I didnt notice.
