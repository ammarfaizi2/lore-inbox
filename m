Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265590AbUFTPvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUFTPvx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbUFTPvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 11:51:53 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:29877 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S265655AbUFTPvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 11:51:46 -0400
Date: Sun, 20 Jun 2004 16:50:42 +0100
From: Ian Molton <spyro@f2s.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: rmk+lkml@arm.linux.org.uk, david-b@pacbell.net,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040620165042.393f2756.spyro@f2s.com>
In-Reply-To: <1087738680.10858.5.camel@mulgrave>
References: <1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave
	<40D359BB.3090106@pacbell.net>
	<1087593282.2135.176.camel@mulgrave>
	<40D36EDE.2080803@pacbell.net>
	<1087600052.2135.197.camel@mulgrave>
	<40D4849B.3070001@pacbell.net>
	<20040619214126.C8063@flint.arm.linux.org.uk>
	<1087681604.2121.96.camel@mulgrave>
	<20040619234933.214b810b.spyro@f2s.com>
	<1087738680.10858.5.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 2004 08:37:58 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> 
> There's no architecture currently that can't use the DMA API.
> 
> The modification you propose, to make on chip memory visible as normal
> memory can't be done on the IBM iserie, AS/400 as I said in the the
> email you quote:

Those two statements are contradictory. clearly the iseries cant use the
DMA API *now* so I dont see how that makes any difference. We're talking
about adding propper support for *addresssable* memory mapped devices
with limited size DMA-able windows to the DMA API, not adding support
for a whole new weird way of talking to devices. These devices work the
same way as all the other devices that use the DMA API but are simply
restricted in the range of addresses they can DMA from. they require no
special 'accessors'.

iseries cant work the usual way now and wont with these modifications -
so nothing is made worse.
