Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVEZRJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVEZRJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVEZRJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:09:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2512 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261610AbVEZRCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:02:40 -0400
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Carsten Otte <cotte@freenet.de>
Cc: suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <4295CCDF.9070302@freenet.de>
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com>
	 <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com>
	 <20050524093029.GA4390@in.ibm.com> <42930B64.2060105@freenet.de>
	 <20050524133211.GA4896@in.ibm.com> <42933B7A.3060206@freenet.de>
	 <1117043475.26913.1540.camel@dyn318077bld.beaverton.ibm.com>
	 <20050526132251.GA5067@in.ibm.com>  <4295CCDF.9070302@freenet.de>
Content-Type: text/plain
Organization: 
Message-Id: <1117125787.26913.1546.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 May 2005 09:43:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 06:19, Carsten Otte wrote:
> Suparna Bhattacharya wrote:
> 
> > To get a complete picture, how did you want to handle direct io ?
> >
> >Regards
> >Suparna
> >  
> >
> Just through the regular xip path, O_DIRECT doesn't have any effect
> on those files since we do a direct memcpy to disk in the end anyway.
> That has the user-visible effect that unalligned reads/writes work with
> O_DIRECT.

Well, my changes won't handle O_DIRECT the way you are expecting to.
Generic routines handle direct-io first, so you need to fix that.
(or clear the O_DIRECT flag for xip files).

Thanks,
Badari

