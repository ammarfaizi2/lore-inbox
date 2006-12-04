Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937260AbWLDSrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937260AbWLDSrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937262AbWLDSrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:47:53 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50099 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937261AbWLDSrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:47:52 -0500
Message-Id: <200612041846.kB4Ikx2F026455@laptop13.inf.utfsm.cl>
To: Aucoin@Houston.RR.com
cc: "'Horst H. von Brand'" <vonbrand@inf.utfsm.cl>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness 
In-Reply-To: Message from "Aucoin" <Aucoin@Houston.RR.com> 
   of "Mon, 04 Dec 2006 11:49:12 MDT." <200612041749.kB4HnDNw008901@ms-smtp-02.texas.rr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 04 Dec 2006 15:46:59 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 04 Dec 2006 15:46:59 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aucoin <Aucoin@Houston.RR.com> wrote:
> From: Horst H. von Brand [mailto:vonbrand@inf.utfsm.cl]
> > That means that there isn't a need for that memory at all (and so they

> In the current isolated non-production, not actually bearing a load test
> case yes. But if I can't get it to not swap on an idle system I have no hope
> of avoiding OOM on a loaded system.

How do you /know/ it won't just be recycled in the production case?

> > In any case, how do you know it is the tar data that stays around, and not
> > just that the number of pages "in use" stays roughly constant?
> 
> I'm not dumping the contents of memory so I don't.

OK.

> > - What you are doing, step by step
> 
> Trying to deliver a high availability, linearly scalable, clustered iSCSI
> storage solution that can be upgraded with minimum downtime.

That is your ultimate goal, not what you are doing, step by step.

> > - What are your exact requirements

> OOM not to kill anything.

Can't ever guarantee that (unless you have the exact memory requirements
beforehand, and enough RAM for the worst case).

> > - In what exact way is it missbehaving. Please tell /in detail/ how you

> OOM kills important stuff.

What "important stuff"? How come OOM kills it, when there is plenty of
free(able) memory around? Is this in the production setting, or are you
just afraid it could happen by what you see in the "current isolated
non-production, not actually bearing a load test" case?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513



