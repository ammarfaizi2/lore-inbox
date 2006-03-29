Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWC2Uvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWC2Uvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWC2Uvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:51:52 -0500
Received: from iron.cat.pdx.edu ([131.252.208.92]:33154 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1750787AbWC2Uvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:51:51 -0500
Date: Wed, 29 Mar 2006 12:51:12 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200603292051.k2TKpCde027872@baham.cs.pdx.edu>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and thank you for your response.

> From: "David Howells" Wednesday, March 29, 2006 9:54 AM
> 
>  Suzanne Wood wrote:
> 
> > Seems like the subject of "will never happen" is the read from memory for the 
> > asmt to X, but does that sentence say that?  
> 
> "asmt"?

assignment

> I agree that it doesn't make much sense, so how's this instead?
> 
> + However, it is guaranteed that a CPU will be self-consistent: it will see its
> + _own_ accesses appear to be correctly ordered, without the need for a memory
> + barrier.  For instance with the following code:
> + 
> + 	X = *A;
> + 	*A = Y;
> + 	Z = *A;
> + 
> + and assuming no intervention by an external influence, it can be taken that:
> + 
> +  (*) X will end up holding the original value of *A, as
> + 
> +  (*) the load of X from *A will never happen after the store of Y into *A, and
> +      thus
> + 
> +  (*) X will never be given instead the value that was assigned from Y to *A;
> +      and
> + 
> +  (*) Z will always be given the value in *A that was assigned there from Y, as
> + 
> +  (*) the load of Z from *A will never happen before the store, and thus
> + 
> +  (*) Z will never be given instead the value that was in *A initially.
> + 
> + (This ignores the fact that the value initially in *A may appear to be the same
> + as the value assigned to *A from Y).
> 
> I'm not sure I want to split the points up that way, but it does make them
> clearer.  I'm not sure that method of linking them works, since it looks like
> a bunch of incomplete statements.
> 
> Really, this should be described mathematically, if at all.

Do you mean to formalize preconditions on the value of Y and contents of A 
and consider postconditions after the execution of the three statements of 
the example where the value of X is the prior content of A and A contains and 
Z equals the value of Y.

> > It seems to require more effort than necessary to understand in regard to
> > all that is presented in this document.
> 
> Are you referring to my attempt to define a self-consistent CPU?  Or to the
> subject in general?

Sorry to be unclear.  I was just asking about the explanation of the 
self-consistent CPU example.  The other ideas in the document are more
difficult, so thought this part might be simplified.
 
> If the former, you may be right.  I'll look at compressing the whole thing
> down to a single paragraph.
> 
> David

Thanks again.
Suzanne
