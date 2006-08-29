Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWH2N7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWH2N7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWH2N7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:59:24 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:31120 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964974AbWH2N7X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:59:23 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 04/18] [PATCH] BLOCK: Separate the bounce buffering code from the highmem code [try #4]
Date: Tue, 29 Aug 2006 15:59:20 +0200
User-Agent: KMail/1.9.1
Cc: Sam Ravnborg <sam@ravnborg.org>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200608281352.58281.arnd.bergmann@de.ibm.com> <22040.1156537104@warthog.cambridge.redhat.com> <29516.1156859236@warthog.cambridge.redhat.com>
In-Reply-To: <29516.1156859236@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608291559.20802.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 15:47, David Howells wrote:
> Arnd Bergmann <arnd.bergmann@de.ibm.com> wrote:
> 
> > You could write it as
> > 
> > bounce-$(CONFIG_MMU) += bounce.o
> > obj-$(CONFIG_BLOCK)  += $(bounce-y)
> 
> I could, yes, but why?  What does it buy?  I think this:
> 
>         ifeq ($(CONFIG_MMU)$(CONFIG_BLOCK),yy)
>         obj-y += bounce.o
>         endif
> 
> is clearer.

I remember having seen the first one in the kernel before
(e.g. in arch/powerpc/kernel/Makefile), but not the other one.

I agree that it doesn't make much difference at all, but it
would be nice to be consistant.

	Arnd <><
