Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271008AbUJUWBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271008AbUJUWBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271004AbUJUV53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:57:29 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:51102 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270836AbUJUVv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:51:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gg3eABhlEcv754t7E7jzUxgqlKVHolFqVl+lTWDFY6qXCODUTdhG+Fb4LgBwNPr9NlRK6pcWbd82tIar1WF2BGSdKDdIePtqIicKIWfQ5/C1KgIvsPJHa0QfCZN59Xu2pT0TvyfJvygtg+m7J89LavWQSZFxRt28eBn7oyaTz4s=
Message-ID: <58cb370e0410211451560cb53a@mail.gmail.com>
Date: Thu, 21 Oct 2004 23:51:54 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE CF adaptor
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4178232B.5000506@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41780393.3000606@rtr.ca>
	 <58cb370e041021121317083a3a@mail.gmail.com> <41781B13.3030803@rtr.ca>
	 <58cb370e041021134269c05f17@mail.gmail.com> <4178232B.5000506@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 16:59:23 -0400, Mark Lord <lkml@rtr.ca> wrote:
> Hi Bartlomiej!
> 
> Bartlomiej Zolnierkiewicz wrote:
> >
> > Just port it to 2.6.x...
> 
>  From my current negative experiences with 2.6.xx, I'll pass.
> That kernel breaks suspend/resume on my notebooks,
> and is a dog for disk performance.  Still, I'd happily

bug reports / patches are the way to go

> port this new driver to it if there was a hope in hell
> that the effort wouldn't be a total waste of my time.

2.4.x is a total waste of my time 8)

>  > ide_unregister() is disallowed, unless IDE locking is fixed
> 
> That just happens to be the existing interface used by the existing
> PCMCIA layer.  The new delkin_cb driver simply does exactly the
> same calls to link in/out of the kernel as ide-cs does today.

"other drivers use it so it must be OK", no it is not
it was discussed few times already...

> I suppose that means we should remove ide-cs as well.

Not adding new users is sufficient for now.

Cheers,
Bartlomiej
