Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWCAOGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWCAOGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWCAOGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:06:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750979AbWCAOGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:06:36 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060220170913.b232dc20.davi.arnaut@gmail.com> 
References: <20060220170913.b232dc20.davi.arnaut@gmail.com>  <4993.1140431092@warthog.cambridge.redhat.com> <20060218161122.f9d588fb.davi.arnaut@gmail.com> <20060218113602.edc06ce5.davi.arnaut@gmail.com> <3487.1140281089@warthog.cambridge.redhat.com> <5378.1140431896@warthog.cambridge.redhat.com> 
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, vsu@altlinux.ru,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] strndup_user (v3), convert (keyctl) 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 01 Mar 2006 14:06:20 +0000
Message-ID: <4967.1141221980@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davi Arnaut <davi.arnaut@gmail.com> wrote:

> In keyctl_keyring_search() there wasn't a check for type[0] == '.', but your
> mm-patch added one implicitly. Which one is correct ?

Ummm... good point. Key types beginning with a dot are special, and userspace
isn't allowed to create them. I'm not sure whether they should be findable or
not, but I'm happy go for not at the moment (so the patch is correct, not the
original).

There's another minor problem with your patch:

	warthog>grep -r strndup_user *
	warthog1>

I take it that this isn't in Linus's kernel yet... However, I don't want my
patch to be held up too much since there are some awkward holes that need
fixing. I'm definitely in favour of strndup_user() though.

David
