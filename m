Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVFBCtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVFBCtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFBCtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:49:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34196 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261576AbVFBCtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:49:52 -0400
Date: Thu, 2 Jun 2005 04:49:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH] Sample fix for hyperthread exploit
Message-ID: <20050602024924.GD27174@elte.hu>
References: <200506012158.39805.kernel@kolivas.org> <1117627597.6271.29.camel@laptopd505.fenrus.org> <200506012213.25445.kernel@kolivas.org> <20050601172505.GM23013@shell0.pdx.osdl.net> <1117654147.6271.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117654147.6271.38.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > Also, uid is not sufficient.  Something more comprehensive (like ability
> > to ptrace) would be appropriate.
> 
> I would go a lot simpler. App says "I want exclusivity" via pctl and 
> NOTHING runs on the other half. Well maybe with exceptions of 
> processes that share the mm with the exclusive one (in practice 
> "threads") since those could just read the memory anyway.

this has the disadvantage of needing changes in the security apps.  
Basing this off the uid (or the ability to ptrace) makes it at least 
automatic - but introduces a permanent penalty not only on multiuser 
boxes, but on basically any server box that runs multiple services.

	Ingo
