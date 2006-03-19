Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWCSVDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWCSVDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 16:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWCSVDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 16:03:30 -0500
Received: from waste.org ([64.81.244.121]:15534 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750997AbWCSVD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 16:03:29 -0500
Date: Sun, 19 Mar 2006 14:52:32 -0600
From: Matt Mackall <mpm@selenic.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>
Subject: Re: + stack-corruption-detector.patch added to -mm tree
Message-ID: <20060319205232.GA31656@waste.org>
References: <200603082041.k28Kf7H1027435@shell0.pdx.osdl.net> <Pine.LNX.4.63.0603082215330.4484@cuia.boston.redhat.com> <20060319182648.GE25452@waste.org> <1142798807.3018.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142798807.3018.29.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 09:06:46PM +0100, Arjan van de Ven wrote:
> On Sun, 2006-03-19 at 12:26 -0600, Matt Mackall wrote:
> > On Wed, Mar 08, 2006 at 10:16:50PM -0500, Rik van Riel wrote:
> > > On Wed, 8 Mar 2006, akpm@osdl.org wrote:
> > > 
> > > > -			memset(ret, 0, THREAD_SIZE);		\
> > > > +			memset(ret, 0x55, THREAD_SIZE);		\
> > > 
> > > Xen uses 0x55 as a poison pattern too.  I wonder if we should
> > > change this one (this one's newer ;)) to something else.
> > 
> > I think we should have a central poison.h file.
> 
> sure
> 
> but it's not like xen is anywhere near mergable, so xen should change if
> anything ;)

Well Xen is a separate problem. But figuring out what poison value
came from where and which values are already used is getting to be an
ugly problem for the kernel itself. 

-- 
Mathematics is the supreme nostalgia of our time.
