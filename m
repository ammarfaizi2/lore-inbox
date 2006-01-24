Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWAXKvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWAXKvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 05:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWAXKvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 05:51:35 -0500
Received: from mail.gmx.de ([213.165.64.21]:26586 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030446AbWAXKve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 05:51:34 -0500
X-Authenticated: #428038
Date: Tue, 24 Jan 2006 11:51:29 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060124105129.GB26042@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	arjan@infradead.org, linux-kernel@vger.kernel.org
References: <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <20060123203010.GB1820@merlin.emma.line.org> <1138092761.2977.32.camel@laptopd505.fenrus.org> <43D5EEA2.nailCE7111GPO@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D5EEA2.nailCE7111GPO@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-24:

> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > > And because this requirement is not specified in the relevant standards,
> > > it is wrong to assume valloc() returns locked pages. 
> >
> > is it? I sort of doubt that (but I'm not a standards expert, but I'd
> > expect that "lock all in the future" applies to all memory, not just
> > mmap'd memory
> 
> I concur:
> 
> Locking pages into core is a property/duty of the VM subsystem.

But where is this laid down in the standard? There must be some part
that defines this, else we cannot rely on it. The wording for malloc()
and mmap() or mlock() is different. One talks about address space and
mapping, whereas malloc() talks about "storage".

Only I haven't got time to look for it now. Just that Solaris happens to
do it doesn't make it a standard.

-- 
Matthias Andree
