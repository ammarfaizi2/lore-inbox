Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTAEIia>; Sun, 5 Jan 2003 03:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTAEIia>; Sun, 5 Jan 2003 03:38:30 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:40132 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263977AbTAEIi3>; Sun, 5 Jan 2003 03:38:29 -0500
Subject: Re: [PATCH] Make ide-probe more robust to non-ready devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1041756574.642.35.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 05 Jan 2003 09:49:35 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 21:48, Alan Cox wrote: 
> On Sat, 2003-01-04 at 09:34, Benjamin Herrenschmidt wrote:
> > I don't expect this patch to break any existing working configuration,
> > so please send to Linus for 2.5. If you accept it, I'll then send a 2.4
> > version to Marcelo as well. This have been around for some time and,
> > imho, should really get in now.
> 
> There is a ton of stuff pending for 2.5 IDE. Unfortunately 2.5 isn't in
> a state I can do any usable testing so it will have to wait. The Marcelo
> 2.4 tree is current and I'm doing the work in 2.4 first now.
> 
> Rusty seems to have a lot of the module stuff in hand so hopefully I'll
> get back onto 2.5 after LCA

Well, actually, I'd like to see this patch in 2.4 asap too ;) It should
apply "as is" with some offset.

As Eric W. Biederman noticed, it may not be enough for some really
broken devices, but will not harm neither on these, and will fix the
problem on a whole lot of better ones. It's definitely necessary with
some WD hard disks and the "combo" DVD/CDRW drive shipped  by Apple on
some ibooks (Apple firmware typically does a reset of all drives just
before booting the kernel, without waiting)


Ben.



