Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965305AbWI1Ki4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbWI1Ki4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 06:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWI1Kiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 06:38:55 -0400
Received: from colin.muc.de ([193.149.48.1]:42251 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S965305AbWI1Kiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 06:38:55 -0400
Date: 28 Sep 2006 12:38:53 +0200
Date: Thu, 28 Sep 2006 12:38:53 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
Message-ID: <20060928103853.GB99906@muc.de>
References: <451B64E3.9020900@goop.org> <20060927233509.f675c02d.akpm@osdl.org> <451B708D.20505@goop.org> <20060928000019.3fb4b317.akpm@osdl.org> <20060928071731.GB84041@muc.de> <20060928002610.05e61321.akpm@osdl.org> <20060928101555.GA99906@muc.de> <451BA434.9020409@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451BA434.9020409@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 03:30:12AM -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >But no out of line section. So overall it's smaller, although the cache 
> >footprint
> >is 2 bytes larger. But then is 2 bytes larger really an issue? We don't 
> >have
> >_that_ many BUGs anyways.
> >  
> 
> I think the out of line section is a feature; no point in crufting up 
> the icache with BUG gunk, especially since a number of them are on 
> fairly hot paths.

It's 10 bytes per BUG. 

> 
> >I'll port the x86-64 way over to i386
> 
> It's neat, and it would solve my immediate problem, but I think my way 
> is actually better.

Your way will be even bigger because we would need to add
dwarf2 annotation to the out of line code.

-Andi
