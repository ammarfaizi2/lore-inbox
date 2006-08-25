Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422887AbWHYUSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422887AbWHYUSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWHYUSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:18:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932236AbWHYUSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:18:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060825200455.GA2629@uranus.ravnborg.org> 
References: <20060825200455.GA2629@uranus.ravnborg.org>  <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com> <20060825193707.11384.97372.stgit@warthog.cambridge.redhat.com> 
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] [PATCH] BLOCK: Separate the bounce buffering code from the highmem code [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 21:18:24 +0100
Message-ID: <22040.1156537104@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:

> > +ifeq ($(CONFIG_MMU),y)
> > +obj-y			+= bounce.o
> > +endif
> 
> CONFIG_MMU is a bool so you can do this much more elegant:
> obj-$(CONFIG_MMU) += bounce.o

In patch 18/18, this changes to:

	ifeq ($(CONFIG_MMU)$(CONFIG_BLOCK),yy)

So the elegence in the end is irrelevant.

David
