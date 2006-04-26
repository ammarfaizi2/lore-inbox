Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWDZH6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWDZH6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 03:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDZH6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 03:58:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17851 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751113AbWDZH6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 03:58:48 -0400
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
	 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 09:58:44 +0200
Message-Id: <1146038324.5956.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 10:30 +0300, Pekka Enberg wrote:
> On 4/25/06, Hua Zhong <hzhong@gmail.com> wrote:
> > diff --git a/mm/slab.c b/mm/slab.c
> > index e6ef9bd..0fbc854 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3380,7 +3380,7 @@ void kfree(const void *objp)
> >         struct kmem_cache *c;
> >         unsigned long flags;
> >
> > -       if (unlikely(!objp))
> > +       if (!objp)
> >                 return;
> 
> NAK. Fix the callers instead.

eh dude... they are being fixed... to remove the NULL check :)


