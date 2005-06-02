Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVFBC4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVFBC4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVFBC4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:56:04 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:13999 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261577AbVFBCz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:55:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Sample fix for hyperthread exploit
Date: Thu, 2 Jun 2005 12:57:51 +1000
User-Agent: KMail/1.8.1
Cc: Arjan van de Ven <arjan@infradead.org>, Chris Wright <chrisw@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200506012158.39805.kernel@kolivas.org> <1117654147.6271.38.camel@laptopd505.fenrus.org> <20050602024924.GD27174@elte.hu>
In-Reply-To: <20050602024924.GD27174@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021257.51662.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005 12:49 pm, Ingo Molnar wrote:
> * Arjan van de Ven <arjan@infradead.org> wrote:
> > > Also, uid is not sufficient.  Something more comprehensive (like
> > > ability to ptrace) would be appropriate.
> >
> > I would go a lot simpler. App says "I want exclusivity" via pctl and
> > NOTHING runs on the other half. Well maybe with exceptions of
> > processes that share the mm with the exclusive one (in practice
> > "threads") since those could just read the memory anyway.
>
> this has the disadvantage of needing changes in the security apps.
> Basing this off the uid (or the ability to ptrace) makes it at least
> automatic - but introduces a permanent penalty not only on multiuser
> boxes, but on basically any server box that runs multiple services.

The performance penalty of the sample patch without extra communication or 
code would be substantial and I should make it clear to any onlookers that it 
is not recommended you use it in any real environment.

Cheers,
Con
