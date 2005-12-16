Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVLPRR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVLPRR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVLPRR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:17:26 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:35112 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932357AbVLPRRZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:17:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t0sC4msrSFxHqjJoBeKC3LVFOpJXmipwrF8C58NAsoiewuJvawZq2NBYLc9Tvfr+JT2HSELwcKfi+mWPY+TcSOAl74c8/PjeRYpZySp7dwpLXbDtjvDsEjDvtw1ky4ZsK4fWNLdYbkFoiilBwNDgar/UxF0owbjyVtl78XYpXAA=
Message-ID: <170fa0d20512160917m7de06442x61bfbe3c3842fc2a@mail.gmail.com>
Date: Fri, 16 Dec 2005 12:17:24 -0500
From: Mike Snitzer <snitzer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <170fa0d20512160902g26eefc2eua519617d3e760de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
	 <1134751589.2992.43.camel@laptopd505.fenrus.org>
	 <170fa0d20512160902g26eefc2eua519617d3e760de@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Mike Snitzer <snitzer@gmail.com>
Date: Dec 16, 2005 12:02 PM
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: Arjan van de Ven <arjan@infradead.org>
Cc: Diego Calleja <diegocg@gmail.com>, Andrew Morton <akpm@osdl.org>,
bunk@stusta.de, linux-kernel@vger.kernel.org



On 12/16/05, Arjan van de Ven <arjan@infradead.org> wrote:
>  On Fri, 2005-12-16 at 14:10 +0100, Diego Calleja wrote:
> > El Thu, 15 Dec 2005 14:00:13 -0800,
> > Andrew Morton <akpm@osdl.org> escribió:
> >
> >
> > > Supporting 8k stacks is a small amount of code and nobody has seen a need
> > > to make changes in there for quite a long time.  So there's little cost to
> > > keeping the existing code.
> > >
> > > And the existing code is useful:
> >
> > Maybe this slighty different approach is better?
> >
> >
> >
> > Signed-off-by: Diego Calleja <diegocg@gmail.com>
>
>
> I like this one; it makes the default 4K while leaving the 8K option for
> those who really want it...
>
> Acked-by: Arjan van de Ven <arjan@infradead.org>

 Any chance that IRQ stacks could be made available with 8K?  Set
default to 4K but expose the _option_ for choice of 8K+IRQ stacks?  I
realize it takes away from the fanatical push toward imposed 4K purity
but Linux is really all about options.
