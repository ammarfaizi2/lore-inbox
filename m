Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbUKVKt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUKVKt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUKVKmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:42:08 -0500
Received: from [220.248.27.114] ([220.248.27.114]:32485 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262034AbUKVKjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:39:24 -0500
Date: Mon, 22 Nov 2004 18:32:41 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041122103240.GA11323@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122102612.GA1063@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 11:26:12AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > Here is the patch relative to your big diff. It tested pass with my x86
> > > > pc, But the sysfs interface can't works, I using reboot system call.
> > > 
> > > Without PREEMPT and HIGHMEM it worked okay on an idle system. When I
> > > started kernel compilation while trying to swsusp, it crashed on
> > > resume.
> > 
> > Here is my big diff relative to your big diff. :), It works.
> > 
> > - Not need continuous page for pagedir.
> >   Swsusp using continuous page (pagedir), to save the new address, old
> >   address and swap offset, but in current implemention, it using
> >   continuous page as array, so if has so many pages to save, we have to
> >   allocate many (>5) continuous pages, most it it will failed.
> >  
> >   I using a easy link struct to resolve it.
> 
> Yes, I'd like to get rid of "too many continuous pages" problem
> before. Small problem is that it needs to update x86-64 too, but I
I have not x86-64, so I have no chance to do it.

> guess that's okay. I'd like that version to go in *before* that
> page-cache stuff (it actually fails a lot in wild).
Yes, I agree.

> 
> Could you possibly put page-cache stuff into separate file? It would
> be even nicer to have it configurable (run-time or compile-time) so
> that if swsusp fails, I can tell people "try again with page-cache
> stuff turned off"...
> 								Pavel
I'll do that. :)

--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
