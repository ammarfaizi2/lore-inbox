Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWCSUG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWCSUG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 15:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWCSUG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 15:06:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37774 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750867AbWCSUG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 15:06:58 -0500
Subject: Re: + stack-corruption-detector.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060319182648.GE25452@waste.org>
References: <200603082041.k28Kf7H1027435@shell0.pdx.osdl.net>
	 <Pine.LNX.4.63.0603082215330.4484@cuia.boston.redhat.com>
	 <20060319182648.GE25452@waste.org>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 21:06:46 +0100
Message-Id: <1142798807.3018.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-19 at 12:26 -0600, Matt Mackall wrote:
> On Wed, Mar 08, 2006 at 10:16:50PM -0500, Rik van Riel wrote:
> > On Wed, 8 Mar 2006, akpm@osdl.org wrote:
> > 
> > > -			memset(ret, 0, THREAD_SIZE);		\
> > > +			memset(ret, 0x55, THREAD_SIZE);		\
> > 
> > Xen uses 0x55 as a poison pattern too.  I wonder if we should
> > change this one (this one's newer ;)) to something else.
> 
> I think we should have a central poison.h file.

sure

but it's not like xen is anywhere near mergable, so xen should change if
anything ;)


