Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWHHODh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWHHODh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWHHODh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:03:37 -0400
Received: from web25219.mail.ukl.yahoo.com ([217.146.176.205]:7337 "HELO
	web25219.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932587AbWHHODg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:03:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=iape6AquyX+ZVPd3VxLSC2u13fpd+O6Q4S9SWbfwwT93d44dGuOK+ucY0qn6Fh8PLtTnoMhiMuaX1MgHM1OKbdU3bcdqDj36dQ7yIa+ipjZI/IP1H42We2+mc83d+bVPH1E0b/1XV4qp3fuOEmV39f0dZyIWfmskst7bIzUrezc=  ;
Message-ID: <20060808140335.81959.qmail@web25219.mail.ukl.yahoo.com>
Date: Tue, 8 Aug 2006 16:03:35 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
To: Andi Kleen <ak@suse.de>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <p733bc7pj48.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> ha scritto: 

> Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:
> 
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > 
> > We have never used this flag and recently one user experienced a
> complaining
> > warning about this (there was a symbol in the positive half of
> the address space
> > IIRC). So fix it.
> 
> You can't use kernel cmodel in user space.  It requires running on
> negative
> virtual addresses. I would be surprised if it worked for you.

Argh, yes, I didn't test the patch and I didn't think to it a lot. So
what about the following bug? Should we hack our own module loader
based on x86-64's one?

Moreover, who has recently tested module loading in x86-64 uml
kernels? I don't remember doing such testing recently...

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=115125101012707&w=2


Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
