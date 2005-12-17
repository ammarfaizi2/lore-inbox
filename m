Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVLQWkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVLQWkq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 17:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVLQWkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 17:40:46 -0500
Received: from lame.durables.org ([64.81.244.120]:33945 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S964997AbVLQWkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 17:40:45 -0500
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217123833.1aa430ab.akpm@osdl.org>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	 <200512161548.lRw6KI369ooIXS9o@cisco.com>
	 <20051217123833.1aa430ab.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 14:40:43 -0800
Message-Id: <1134859243.20575.84.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 12:38 -0800, Andrew Morton wrote:
> Roland Dreier <rolandd@cisco.com> wrote:
> >
> > + 	.globl ipath_dwordcpy
> > +/* rdi	destination, rsi source, rdx count */
> > +ipath_dwordcpy:
> > +	movl %edx,%ecx
> > +	shrl $1,%ecx
> > +	andl $1,%edx	
> > +	cld
> > +	rep 
> > +	movsq 
> > +	movl %edx,%ecx
> > +	rep
> > +	movsd
> > +	ret
> 
> err, we have a portability problem.

Any chance we could get these moved into the x86_64 arch directory,
then?  We have to do double-word copies, or our chip gets unhappy.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


