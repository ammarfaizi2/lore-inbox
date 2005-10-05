Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVJEOuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVJEOuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbVJEOuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:50:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965185AbVJEOus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:50:48 -0400
Date: Wed, 5 Oct 2005 07:50:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       Michael C Thompson <mcthomps@us.ibm.com>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Export user-defined keyring operations
In-Reply-To: <1128519178.3116.16.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0510050742550.31407@g5.osdl.org>
References: <OF7208B0E9.0AB77A04-ON87257090.007A1D4E-05257090.007A2207@us.ibm.com>
  <28129.1128509939@warthog.cambridge.redhat.com>  <1128510159.2920.15.camel@laptopd505.fenrus.org>
 <1128519178.3116.16.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Oct 2005, David Woodhouse wrote:
> 
> What's the point? There can be no difference between the meaning of
> EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL() anyway.

I've talked to a lawyer or two, and (a) there's an absolutely _huge_ 
difference and (b) they liked it.

The fact is, the law isn't a blind and mindless computer that takes what 
you say literally. Intent matters a LOT. And using the xxx_GPL() version 
to show that it's an internal interface is very meaningful indeed.

One of the lawyers said that it was a much better approach than trying to 
make the license explain all the details - codifying the intention in the 
code itself is not only more flexible, but a lot less likely to be 
misunderstood.

I think both them said that anybody who were to change a xyz_GPL to the 
non-GPL one in order to use it with a non-GPL module would almost 
immediately fall under the "willful infringement" thing, and that it would 
make it MUCH easier to get triple damages and/or injunctions, since they 
clearly knew about it.

I suspect programmers make horrible lawyers. They nitpick on details that 
sane humans don't. I think programmers often end up forgetting about the 
fact that human interactions don't work that way. Common sense makes a lot 
of difference, and DWIM is not just possible, but it's the only thing that 
matters.

		Linus
