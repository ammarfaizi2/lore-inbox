Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263918AbUDVWeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbUDVWeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUDVWeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:34:11 -0400
Received: from colin2.muc.de ([193.149.48.15]:23560 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263918AbUDVWeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:34:02 -0400
Date: 23 Apr 2004 00:34:01 +0200
Date: Fri, 23 Apr 2004 00:34:01 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@muc.de>, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Large inlines in include/linux/skbuff.h
Message-ID: <20040422223401.GB81305@colin2.muc.de>
References: <m3y8ooawiq.fsf@averell.firstfloor.org> <Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com> <20040422222326.GA81305@colin2.muc.de> <20040422152525.28ee1d5f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422152525.28ee1d5f.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 03:25:25PM -0700, David S. Miller wrote:
> On 23 Apr 2004 00:23:26 +0200
> Andi Kleen <ak@muc.de> wrote:
> 
> > > Of course, but it would be good to see some measurements.
> > 
> > It's useless in this case. networking is dominated by cache misses
> > and locks and a modern CPU can do hundreds of function calls in a 
> > single cache miss.
> 
> Indeed, this change does influence the I-cache footprint of the
> networking, so I conclude that it is relevant in this case.

All it does it is to lower the cache foot print, not enlarge it.
So even if it made a difference it could only get better.
It's extremly unlikely to make it detectable worse.

-Andi
