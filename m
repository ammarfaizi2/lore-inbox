Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbUKKXVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbUKKXVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUKKXVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:21:13 -0500
Received: from hera.cwi.nl ([192.16.191.8]:23535 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262475AbUKKXTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:19:39 -0500
Date: Fri, 12 Nov 2004 00:19:35 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove if !PARTITION_ADVANCED condition in defaults
Message-ID: <20041111231935.GC13442@apps.cwi.nl>
References: <200411112302.iABN2Pu01711@apps.cwi.nl> <Pine.LNX.4.58.0411111507090.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411111507090.2301@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 03:11:00PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 12 Nov 2004 Andries.Brouwer@cwi.nl wrote:
> > 
> > So, the below advises people "Say Y here" for MSDOS_PARTITION,
> > and does not change the default choices when PARTITION_ADVANCED
> > is selected.
> 
> Actually, we should make MSDOS_PARTITION not ask at all, unless 
> CONFIG_EMBEDDED is set. 

I think that is going too far.
It must be possible to deselect it on an old non-i386 machine
without USB, or an old i386 machine with BSD or minix partition
table, or ...

> That way PARTITION_ADVANCED really _does_ mean "do you want some
> additional choices"

That is what it means right now (after my patch).
And one of the additional choices is to deselect MSDOS_PARTITION.

Andries
