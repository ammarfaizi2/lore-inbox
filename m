Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUDVWX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUDVWX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbUDVWX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:23:28 -0400
Received: from colin2.muc.de ([193.149.48.15]:50706 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261468AbUDVWX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:23:27 -0400
Date: 23 Apr 2004 00:23:26 +0200
Date: Fri, 23 Apr 2004 00:23:26 +0200
From: Andi Kleen <ak@muc.de>
To: James Morris <jmorris@redhat.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Large inlines in include/linux/skbuff.h
Message-ID: <20040422222326.GA81305@colin2.muc.de>
References: <m3y8ooawiq.fsf@averell.firstfloor.org> <Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 11:15:47AM -0400, James Morris wrote:
> On Thu, 22 Apr 2004, Andi Kleen wrote:
> 
> > > How will these changes impact performance?  I asked this last time you 
> > > posted about inlines and didn't see any response.
> > 
> > I don't think it will be an issue. The optimization guidelines
> > of AMD and Intel recommend to move functions that generate 
> > more than 30-40 instructions out of line. 100 instructions 
> > is certainly enough to amortize the call overhead, and you 
> > safe some icache too so it may be even faster.
> 
> Of course, but it would be good to see some measurements.

It's useless in this case. networking is dominated by cache misses
and locks and a modern CPU can do hundreds of function calls in a 
single cache miss.

-Andi
