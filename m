Return-Path: <linux-kernel-owner+w=401wt.eu-S1754819AbWLVMe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbWLVMe3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 07:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbWLVMe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 07:34:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:54803 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbWLVMe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 07:34:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MK3yU5ILD+QZR6KlmI974d+H15O63nftWTDGs5t/CHrXohSWoNt7ZBJ5sc+EXCc3R8f0ce8v3Pl7iNzfyI1sbq6RMAbd8rWw2pqTj7mseL5OQaGa8XHSSvWyqaLUtTEbQfFpz/AwQ5KJOUi49BmOYd5YZAnULI2R+8SFDjAWX/o=
Message-ID: <653402b90612220434y6862e737je383ee41fd48a93e@mail.gmail.com>
Date: Fri, 22 Dec 2006 13:34:27 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH update9] drivers: add LCD support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061220211322.cc5661f3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061220151000.27602c37.maxextreme@gmail.com>
	 <20061220211322.cc5661f3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 20 Dec 2006 15:10:00 +0100
> Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
>
> > Andrew, another one for drivers-add-lcd-support saga. Thanks you.
>
> This patch appears to be against some private tree of yours, not against -mm.
>
> Which tells me that it hasn't been tested against the patches in -mm and,
> more importantly, that probably nobody is testing the patches which are
> in -mm.
>
> I'd prefer that you do so, please - there's always a possibility that the
> patches got mangled in flight, or that some other pending change in -mm
> means that the patches work in your tree, but won't work when I merge them
> up.
>
> Thanks.
>

On 12/21/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 20 Dec 2006 15:10:00 +0100
> Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
>
> > --- a/drivers/auxdisplay/Kconfig
> > +++ b/drivers/auxdisplay/Kconfig
> > @@ -65,6 +65,7 @@ config KS0108_DELAY
> >  config CFAG12864B
> >         tristate "CFAG12864B LCD"
> >         depends on X86
> > +       depends on FB
> >         depends on KS0108
> >         default n
> >         ---help---
> > @@ -74,6 +75,8 @@ config CFAG12864B
> >           For help about how to wire your LCD to the parallel port,
> >           check Documentation/auxdisplay/cfag12864b
> >
> > +         Depends on the x86 arch and the framebuffer support.
>
> heh, that was clever.
>
> scripts/kconfig/conf -m arch/i386/Kconfig
> drivers/auxdisplay/Kconfig:81:warning: multi-line strings not supported
> drivers/auxdisplay/Kconfig:78: unknown option "Depends"
> drivers/auxdisplay/Kconfig:80: unknown option "The"
> drivers/auxdisplay/Kconfig:81: unknown option "It"
> drivers/auxdisplay/Kconfig:82: unknown option "of"
> drivers/auxdisplay/Kconfig:84: unknown option "To"
> drivers/auxdisplay/Kconfig:85: unknown option "the"
> drivers/auxdisplay/Kconfig:87: unknown option "If"
> make[1]: *** [allmodconfig] Error 1
>
> you broke Roman's parser.
>
>
> Oh, your patch used spaces where tabs should have been.  Please don't do
> that.
>

Hum, I have checked the patch again and it applies cleanly against
2.6.20-rc1-mm1. Moreover, it works for me and I see I didn't make any
mistake.

...?

Oh. Right. All tabs were converted to spaces when copying it from the
console to the mail client... Sorry about that.

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
