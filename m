Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422885AbWJPUVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422885AbWJPUVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWJPUVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:21:31 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8152 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1422885AbWJPUVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:21:30 -0400
Message-Id: <200610162021.k9GKLOqC015900@laptop13.inf.utfsm.cl>
To: mfbaustx <mfbaustx@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: copy_from_user / copy_to_user with no swap space 
In-Reply-To: Message from mfbaustx <mfbaustx@gmail.com> 
   of "Mon, 16 Oct 2006 14:19:03 CDT." <op.thi3x1mvnwjy9v@titan> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 16 Oct 2006 17:21:24 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 16 Oct 2006 17:21:24 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mfbaustx <mfbaustx@gmail.com> wrote:
> I've been trying to find or derive a definitive answer to this
> question  for a while now but can't quite get over the hump.
> 
> I understand when/why copy_<to|from>_user (and siblings) are required
> (address validation, guaranteeing a process is paged in, etc...).  The
> question is: if you have no swap space (or virtual memory or
> whatever),  can there ever be a case in which any valid pointer to a
> buffer in  user-space would be incorrect as a result of another
> process's PTE being  present?  Put another way: can a process be
> partially paged?

Yes. The executable (including data areas) and shared libraries are demand
paged in (and ro areas could also be evicted), so they can very well be
only partially in memory.

In any case, relying on "this kernel will never have no swap" isn't wise...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
