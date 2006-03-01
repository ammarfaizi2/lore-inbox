Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWCAUtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWCAUtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWCAUtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:49:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751016AbWCAUtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:49:02 -0500
Date: Wed, 1 Mar 2006 12:50:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: dhowells@redhat.com, vsu@altlinux.ru, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] strndup_user (v3), convert (keyctl)
Message-Id: <20060301125053.15a68d59.akpm@osdl.org>
In-Reply-To: <20060301121651.8e023c8e.davi.arnaut@gmail.com>
References: <20060220170913.b232dc20.davi.arnaut@gmail.com>
	<4993.1140431092@warthog.cambridge.redhat.com>
	<20060218161122.f9d588fb.davi.arnaut@gmail.com>
	<20060218113602.edc06ce5.davi.arnaut@gmail.com>
	<3487.1140281089@warthog.cambridge.redhat.com>
	<5378.1140431896@warthog.cambridge.redhat.com>
	<4967.1141221980@warthog.cambridge.redhat.com>
	<20060301121651.8e023c8e.davi.arnaut@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davi Arnaut <davi.arnaut@gmail.com> wrote:
>
> On Wed, 01 Mar 2006 14:06:20 +0000
> David Howells <dhowells@redhat.com> wrote:
> 
> > Davi Arnaut <davi.arnaut@gmail.com> wrote:
> > 
> > > In keyctl_keyring_search() there wasn't a check for type[0] == '.', but your
> > > mm-patch added one implicitly. Which one is correct ?
> > 
> > Ummm... good point. Key types beginning with a dot are special, and userspace
> > isn't allowed to create them. I'm not sure whether they should be findable or
> > not, but I'm happy go for not at the moment (so the patch is correct, not the
> > original).
> > 
> > There's another minor problem with your patch:
> > 
> > 	warthog>grep -r strndup_user *
> > 	warthog1>
> > 
> > I take it that this isn't in Linus's kernel yet... However, I don't want my
> > patch to be held up too much since there are some awkward holes that need
> > fixing. I'm definitely in favour of strndup_user() though.
> > 
> > David
> 
> Andrew, are you willing to merge for .17 ?
> 

Which, strndup_user()?

I guess so - would need to see it again.  But David's
keys-deal-properly-with-strnlen_user.patch should go first, since it
kinda-fixes things.

<remembers that macro, shudders>
