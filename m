Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbSI3Wv4>; Mon, 30 Sep 2002 18:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSI3Wv4>; Mon, 30 Sep 2002 18:51:56 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:30896 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261373AbSI3Wvz>; Mon, 30 Sep 2002 18:51:55 -0400
Date: Tue, 1 Oct 2002 00:57:20 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] break out task_struct from sched.h
In-Reply-To: <200209301216.g8UCGj6g053616@d12relay01.de.ibm.com>
Message-ID: <Pine.LNX.4.33.0210010043090.15829-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Arnd Bergmann wrote:

> I tried something similar before: I seperated out mm_struct from sched.h
> so that mm.h does not have to include sched.h any more. At that time,
> the results were poor, because most of the files that include mm.h but
> not sched.h actually need 'current' or something else from sched.h
> and I then had to include sched.h by hand in them.
> 
> With your work, it probably makes sense to look into this again.

That'd be great.

> Note that 241 of your 614 files that don't need sched.h still include
> it through either linux/mm.h or linux/interrupt.h, so don't gain anything
> there.

Yep, and last time I checked also compile time improvements were poor
(if measurable at all) because of this.
But with further cleanups like what you suggested we'll (slowly, but 
steadily) proceed.
I also intend to redo the analysis after further header file detangling, 
but let's get this applied first.

Tim

