Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWCAPRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWCAPRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCAPRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:17:01 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:57135 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932407AbWCAPQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:16:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qCafYiNVa77e5X5iSHoyc2rReGxCYS/I3fcRiWPKkJU2S/AAwybUMJAnhjCjHvEVAMU5oA1M4HeT1wLkpmud8oj/C7rRbBLR33dsvy6W0qvK+k9z/HKLMac71Oe0BluPa8PHTcB6CtD4SGd7wRaQP68OaVAGCWHbslZUpeK5LaE=
Date: Wed, 1 Mar 2006 12:16:51 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, akpm@osdl.org, vsu@altlinux.ru,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] strndup_user (v3), convert (keyctl)
Message-Id: <20060301121651.8e023c8e.davi.arnaut@gmail.com>
In-Reply-To: <4967.1141221980@warthog.cambridge.redhat.com>
References: <20060220170913.b232dc20.davi.arnaut@gmail.com>
	<4993.1140431092@warthog.cambridge.redhat.com>
	<20060218161122.f9d588fb.davi.arnaut@gmail.com>
	<20060218113602.edc06ce5.davi.arnaut@gmail.com>
	<3487.1140281089@warthog.cambridge.redhat.com>
	<5378.1140431896@warthog.cambridge.redhat.com>
	<4967.1141221980@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2006 14:06:20 +0000
David Howells <dhowells@redhat.com> wrote:

> Davi Arnaut <davi.arnaut@gmail.com> wrote:
> 
> > In keyctl_keyring_search() there wasn't a check for type[0] == '.', but your
> > mm-patch added one implicitly. Which one is correct ?
> 
> Ummm... good point. Key types beginning with a dot are special, and userspace
> isn't allowed to create them. I'm not sure whether they should be findable or
> not, but I'm happy go for not at the moment (so the patch is correct, not the
> original).
> 
> There's another minor problem with your patch:
> 
> 	warthog>grep -r strndup_user *
> 	warthog1>
> 
> I take it that this isn't in Linus's kernel yet... However, I don't want my
> patch to be held up too much since there are some awkward holes that need
> fixing. I'm definitely in favour of strndup_user() though.
> 
> David

Andrew, are you willing to merge for .17 ?

--
Davi Arnaut
