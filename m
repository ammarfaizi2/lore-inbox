Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVAaIYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVAaIYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVAaIYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 03:24:40 -0500
Received: from canuck.infradead.org ([205.233.218.70]:29965 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261839AbVAaIYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 03:24:35 -0500
Subject: Re: inter-module-* removal.. small next step
From: Arjan van de Ven <arjan@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de
In-Reply-To: <1107132112.783.219.camel@baythorne.infradead.org>
References: <20050130180016.GA12987@infradead.org>
	 <1107132112.783.219.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 09:24:29 +0100
Message-Id: <1107159869.4221.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 00:41 +0000, David Woodhouse wrote:
> On Sun, 2005-01-30 at 18:00 +0000, Arjan van de Ven wrote:
> > Hi,
> > 
> > intermodule is deprecated for quite some time now, and MTD is the sole last
> > user in the tree. To shrink the kernel for the people who don't use MTD, and
> > to prevent accidental return of more users of this, make the compiling of
> > this function conditional on MTD.
> 
> Please get the dependencies right -- it's not core MTD code, but the NOR
> chip drivers and the old DiskOnChip drivers which use this. 

that's just a slightly more finegrained thing, not sure if it's worth
going that deep, esp since it become 2 deps not one, making a bigger
mess than needed.

now if one of the two can go (obsolete) it'd make sense


