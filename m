Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUFRX7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUFRX7G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUFRXzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:55:22 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:1177 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S265502AbUFRXvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:51:51 -0400
Date: Sat, 19 Jun 2004 00:51:06 +0100
From: Ian Molton <spyro@f2s.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040619005106.15b8c393.spyro@f2s.com>
In-Reply-To: <1087601363.2078.208.camel@mulgrave>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com>
	<40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave>
	<20040619002522.0c0d8e51.spyro@f2s.com>
	<1087601363.2078.208.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2004 18:29:22 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> > 
> > I wasnt talking about a PCI system here.
> 
> ioremap is used for all bus remote MMIO regions, not just PCI.

Im aware of that but the OHCI core doesnt do that, it uses the DMA API,
which is entirely reasonable, given its tring to access a DMA-able chunk
of memory.

I *could* write a new driver ohci-ioremapped for all these chips but its
needless duplication which is going to result in bugs bveing fixed in
one ohci driver and not the other.

why not simply expand the DMA API to allow DMA to these easily DMA-able
chips ?
