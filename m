Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVBFMkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVBFMkn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVBFMkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:40:43 -0500
Received: from canuck.infradead.org ([205.233.218.70]:42757 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261195AbVBFMkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:40:37 -0500
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, drepper@redhat.com
In-Reply-To: <20050206123355.GB30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de>
	 <20050206114758.GA8437@infradead.org>
	 <20050206123355.GB30109@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 13:40:22 +0100
Message-Id: <1107693622.22680.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 13:33 +0100, Andi Kleen wrote:
> > Your main objection is that *incorrect* programs that assume they can
> > execute malloc() code without PROT_EXEC protection. For legacy binaries
> > keeping this behavior makes sense, no objection from me.
> > 
> > For newly compiled programs this is just wrong and incorrect.
> 
> That's not true as the grub/mono/... experience shows. 

both those apps are buggy and incorrect though and should be fixed.

> > You mention grub (which has RWE and the patch below thus makes that work)
> > and mono. mono has patches for this on their mailinglist and bugzilla since
> > 2003 according to google, I'm surprised the novell mono guys haven't fixed
> > this bug in their code.
> 
> There are probably more.

I consider that unlikely. Anything remotely portable (either to other
architectures which required since in linux since day one, or to OpenBSD
or similar which require this even for x86) already is correct. And this
is there since 2.6.6.. it's not like this is new

(and for the non-RWE case, fedora has had this behavior all along with
execshield, and that even lead to a patch to fix mono fwiw)


