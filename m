Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVLMVQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVLMVQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVLMVQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:16:27 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:22795 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932398AbVLMVQ0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:16:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dtW5sPphOE2dd5xFVIlvYYjTz3LSYQsSrCd57omV0i8s+WeJHpVH81a0lAwgTfMgd/2xvEfd/rga0EGeJWJyfJYvc1Z7dMtwnFaQHLzrWWqGbhF4QftBYMdb685WqqtWFPjh1o6OVejpYyR2+sGP7wbqj71LOjEMaIAOUbhCgVg=
Message-ID: <9a8748490512131316p26e68a4ek41503679d709ad1a@mail.gmail.com>
Date: Tue, 13 Dec 2005 22:16:18 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Yet more display troubles with 2.6.15-rc5-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <439E181D.4090409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>
	 <439CBE49.2090901@gmail.com>
	 <9a8748490512121031p11beaa51l7445ce1a5b31c3c6@mail.gmail.com>
	 <439E181D.4090409@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jesper Juhl wrote:
> > On 12/12/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> Also, these 2 patches are present in mm but not in Linus' tree.  Can
> >> you check which of these are the culprit, if any?
> >>
> >> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/broken-out/vgacon-fix-doublescan-mode.patch
> >> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/broken-out/vgacon-workaround-for-resize-bug-in-some-chipsets.patch
> >>
> >
> > Since this is 2.6.15-rc5-mm2 I grabbed these two instead:
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/broken-out/vgacon-fix-doublescan-mode.patch
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/broken-out/vgacon-workaround-for-resize-bug-in-some-chipsets.patch
> >
> > Reverting both patches didn't fix the problem. Starting X then
> > switching back to a text mode console still results in a completely
> > messed up text console. X is fine, I can switch back to it no problem,
> > but text consoles go bye-bye...
> >
> > Would there be any point in trying a kernel with just one of the
> > patches reverted?
>
> Those 2 patches are independent, so it's possible that their side
> effects can cancel each other out.  So yes, try reversing one patch
> at a time.
>
I just tried two 2.6.15-rc5-mm2 kernels; the first with only the
vgacon-fix-doublescan-mode.patch backed out and the second one with
only the vgacon-workaround-for-resize-bug-in-some-chipsets.patch one
backed out. Both kernels still had the problem, so I think we can
conclude that these two atches are innocent since reverting both of
them or just one or the other does not resolve the issue.

For what it's worth, I also just build a 2.6.15-rc5-git3 kernel and
that one works perfectly, so it's clearly something still left in -mm.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
