Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937224AbWLDRIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937224AbWLDRIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937225AbWLDRIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:08:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45639 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937224AbWLDRIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:08:37 -0500
Message-Id: <200612041707.kB4H7Mnh020665@laptop13.inf.utfsm.cl>
To: Aucoin@Houston.RR.com
cc: "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness 
In-Reply-To: Message from "Aucoin" <Aucoin@Houston.RR.com> 
   of "Mon, 04 Dec 2006 08:39:24 MDT." <200612041439.kB4EdGFn025092@ms-smtp-03.texas.rr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 04 Dec 2006 14:07:22 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 04 Dec 2006 14:07:23 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aucoin <Aucoin@Houston.RR.com> wrote:

[...]

> The definition of perfectly good here may be up for debate or
> someone can explain it to me. This perfectly good data was
> cached under the tar yet hours after the tar has completed the
> pages are still cached.

That means that there isn't a need for that memory at all (and so they stay
around; why actively delete data (using up resources!) needlessly when it
would be a win to have them around in the (admittedly remote) case they'll
be needed again?), or the whole memory handling in Linux is very broken.
I'd vote for the former, i.e., your problems have nothing to do with memory
pressure and swapping. That would explain why your maneuvres didn't make a
difference...

In any case, how do you know it is the tar data that stays around, and not
just that the number of pages "in use" stays roughly constant?

Please explain again:

- What you are doing, step by step
- What are your exact requirements
- In what exact way is it missbehaving. Please tell /in detail/ how you
  determine the real behaviour, not your deductions.

[Yes, I'm in my "dense" day today.]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
