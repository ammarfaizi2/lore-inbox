Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWASP5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWASP5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWASP5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:57:52 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:39219 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161060AbWASP5w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:57:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A6db+WCD/tdqbt3Ikdw+yZIDM2m1Jc1yJ1wNPESovyLw5bmmGYyVa7yosmUeu0rZzaNJlKC6snLc5hCP5jkOJei0KXfXU3bq8oUriKDYOfPWo+2NPodhv+RSq0IopaOGfSq4rG1G5QDyA01eJDwYUp5tg2KUELXXrU/krdJlfCI=
Message-ID: <84144f020601190757p24f5e454weea88df835f7861a@mail.gmail.com>
Date: Thu, 19 Jan 2006 17:57:49 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: c-otto@gmx.de, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Kernel BUG at include/linux/gfp.h:80
In-Reply-To: <20060119161033.GB12518@carsten-otto.halifax.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060119161033.GB12518@carsten-otto.halifax.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

On 1/19/06, Carsten Otto <c-otto@gmx.de> wrote:
> My kernel panics at every boot, see screenshot[1].
>
> I upgraded my CPU to an Opteron 175 (Dual Core) and enabled SMP in the
> kernel. With "nosmp" the kernel boots (but has problems finding one hard
> disk later on, some IRQ timeout?). The kernel version is 2.6.15.1,
> config see here[2].
>
> With my current non-SMP-kernel (2.6.14.4) everything works.
>
> Please tell me what that BUG message means and how I can get my system
> running.
>
> Addition information regarding the hardware can be found here[3].
>
> Thanks a lot,
> Carsten
>
> [1]: http://c-otto.de/panic.jpg
> [2]: http://c-otto.de/config.txt
> [3]: http://c-otto.de/index.php?x=hardware#teile

I think the problem is related to the following changeset where we
potentially allocate with GFP_DMA and GFP_DMA32 set at the same time.
Andi?

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=47492d3667ec519172ab978bd8231b8c7152fa9d

                                   Pekka
