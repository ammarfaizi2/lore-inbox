Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWH2Nrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWH2Nrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWH2Nrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:47:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57043 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750714AbWH2Nrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:47:31 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608281352.58281.arnd.bergmann@de.ibm.com> 
References: <200608281352.58281.arnd.bergmann@de.ibm.com>  <20060825200455.GA2629@uranus.ravnborg.org> <20060825193707.11384.97372.stgit@warthog.cambridge.redhat.com> <22040.1156537104@warthog.cambridge.redhat.com> 
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
       axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] [PATCH] BLOCK: Separate the bounce buffering code from the highmem code [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 14:47:16 +0100
Message-ID: <29516.1156859236@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd.bergmann@de.ibm.com> wrote:

> You could write it as
> 
> bounce-$(CONFIG_MMU) += bounce.o
> obj-$(CONFIG_BLOCK)  += $(bounce-y)

I could, yes, but why?  What does it buy?  I think this:

	ifeq ($(CONFIG_MMU)$(CONFIG_BLOCK),yy)
	obj-y += bounce.o
	endif

is clearer.

David
