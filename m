Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWBWVTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWBWVTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWBWVTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:19:33 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:63928 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751777AbWBWVTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:19:32 -0500
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
From: Arjan van de Ven <arjan@linux.intel.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602231611_MC3-1-B91D-9C03@compuserve.com>
References: <200602231611_MC3-1-B91D-9C03@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 22:18:48 +0100
Message-Id: <1140729528.4672.96.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 16:10 -0500, Chuck Ebbert wrote:
> > +     if (pol->policy == MPOL_INTERLEAVE)
> > +             current->cleared_page = alloc_page_interleave(
> > +                     GFP_HIGHUSER | __GFP_ZERO, 0, interleave_nodes(pol));
> 
> ======> else ???
> 
> > +     current->cleared_page = __alloc_pages(GFP_USER | __GFP_ZERO,
> > +                     0, zonelist_policy(GFP_USER, pol));
> > +}
> > +

good catch, thanks!
