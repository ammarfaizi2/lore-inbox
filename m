Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVJUGzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVJUGzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 02:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVJUGzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 02:55:08 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:41261 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964885AbVJUGzG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 02:55:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MX75F29gBnasd8htYBnTPcBuL3FSJ+/hb+wLolvWyEqXl1XuDS6sCKQZWC8rg0f5gfLQfwty/UfDvZTuAbPja/OY2hKfE/HccdXzfJH78enEP5TYMhyCSw9z3uy2iroVlnJ04b9VGrWFFevTSP+r2P3lGjHXyz1/fLfjEbkqvLk=
Message-ID: <64c763540510202355r20082c5co6fadb0553b8009b6@mail.gmail.com>
Date: Fri, 21 Oct 2005 12:25:05 +0530
From: Block Device <blockdevice@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Increase priority of a workqueue thread ?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200510210105.20307.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c763540510200612s1e3aa7dvefdac28dd8d24106@mail.gmail.com>
	 <200510210105.20307.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con, Dick,

    Thanks a lot :) ... I'll try it out and see whether it works for me :)

Regards
BD.

On 10/20/05, Con Kolivas <kernel@kolivas.org> wrote:
> On Thu, 20 Oct 2005 23:12, Block Device wrote:
> > Hi,
> >     I am using a custom workqueue thread in my module. How do I increase
> > the priority of the workqueue threads ?
> > I've seen that each workqueue contains an array of per-cpu structures
> > which has a
> > task_struct of the thread on a particular cpu. Since these threads are
> > created from keventd
> > I think they'll have the same priority as keventd.  Also the per-cpu
> > structure is something which is private to the workqueue
> > implementation. Directly using it (from my driver) to increase the
> > priority of the workqueue doesnt seem correct to me. Is there any
> > interface or standard way of changing the priority of a workqueue.
>
> By strange coincidence I was working on a patch to do this. Here's what I have
> so far - I know the code is safe but I don't know if it does as advertised
> yet ;)
>
> Cheers,
> Con
>
>
>
