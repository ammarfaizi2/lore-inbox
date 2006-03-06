Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWCFVlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWCFVlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWCFVlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:41:09 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:27038 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751317AbWCFVlI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:41:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SOOamYTCGD5n3jwPNAG8e6gHKR7a5ueBHBYLBnAXkMaq3pEgIY6SyTurUQSitvYigHEKOB7JWvEq3zDZ6Lz+sP9Tp20QMZffJUNUmCoNz2AG8Xx9VOEA6cHAgwZCVJ2NroNHcbARBUOOfk2X0lNuCm9itfVJWQBX7unNo6tQS/w=
Message-ID: <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com>
Date: Mon, 6 Mar 2006 22:41:07 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>
In-Reply-To: <20060306203036.GQ4595@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062124.42223.jesper.juhl@gmail.com>
	 <20060306203036.GQ4595@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Jens Axboe <axboe@suse.de> wrote:
[...snip...]
>
> I don't see how it could be, honestly, we would gladly oops in locally
> close places if that was the case. If you disable slab debug/poison, do
> you get a nice NULL pointer dereference instead? There have been some
> reports on a NULL queue for sr devices as of lately, I wonder if some
> SCSI change recently was broken.
>

I just build and booted a plain 2.6.16-rc5-mm2 with the same config
I've used previously, but with the following options disabled :

CONFIG_DEBUG_SLAB
CONFIG_PAGE_OWNER
CONFIG_DEBUG_VM
CONFIG_DEBUG_PAGEALLOC

The resulting kernel boots and runs just fine (no Oops) and leaves
nothing in dmesg.
So, without the debugging options it appears to the user that
everything is OK - nasty.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
