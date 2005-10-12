Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbVJLSDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbVJLSDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVJLSDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:03:04 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:50527 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751482AbVJLSDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:03:03 -0400
Date: Wed, 12 Oct 2005 11:03:02 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Felix Oxley <lkml@oxley.org>, OBATA Noboru <noboru.obata.ar@hitachi.com>,
       hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Message-ID: <20051012180302.GA30732@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012100730.GO12682@elf.ucw.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 12:07:31PM +0200, Pavel Machek wrote:
> On St 12-10-05 10:56:46, Felix Oxley wrote:
> > > See Jamie Lokier's description how to *never* slow down. 
> > Sorry, where is this?
> 
> Somewhere on the lkml, *long* ago. Basically idea is to have one
> thread doing writing to disk, and second thread doing compression. If
> no compressed pages are available, just write uncompressed ones. That
> way compression can only speed things up.

That's Message-ID: <20040327144945.GG21884@mail.shareable.org>, dated
2004-03-27 14:49:45.  (Oh look, sendmail encodes the date in the
Message-ID in exactly that format.)

This technique only works for DMA-capable IO -- PIO will make it suck --
but attempting to dump 32GB via PIO would be insane anyways, so...

-andy
