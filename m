Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263439AbSJGVfn>; Mon, 7 Oct 2002 17:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263441AbSJGVfn>; Mon, 7 Oct 2002 17:35:43 -0400
Received: from pc132.utati.net ([216.143.22.132]:43681 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S263439AbSJGVfl>; Mon, 7 Oct 2002 17:35:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Matt Porter <porter@cox.net>, "David S. Miller" <davem@redhat.com>
Subject: Re: The end of embedded Linux?
Date: Mon, 7 Oct 2002 12:41:08 -0400
X-Mailer: KMail [version 1.3.1]
Cc: giduru@yahoo.com, andre@linux-ide.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021005.212832.102579077.davem@redhat.com> <20021007092212.B18610@home.com>
In-Reply-To: <20021007092212.B18610@home.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021007214053.36F16622@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 12:22 pm, Matt Porter wrote:
> On Sat, Oct 05, 2002 at 09:28:32PM -0700, David S. Miller wrote:

> > The common areas, like smaller hashtables or whatever, sure put a
> > CONFIG_SMALL_KERNEL option in there and start submitting the
> > one-liners here and there that do it.
>
> Ahhh, but you just defeated the ideal of being able to customize
> to task.  This is where the hallowed "the user is dumb" theory
> bites us in the ass.  A single option to control all these sizing
> issues reduces flexibility and that is what the embedded system
> designer is looking for.

Or it the Great Big Lever gives them something to grep for if they want to do 
fine-tuned tweaking and need to find all the places it might pay to give a 
closer look to.

> The ideal situation is if as we work
> on all these areas where we can reduce size, we provide fine
> grained options to tweak them (with a default desktop/server value
> and a default "tiny" value).

8000 controls you have to individually tweak to do anything is not 
necessarily an improvement over a single "do what I want" button.  (User 
Interface Design 101.)

The doorknob is a wonderful user interface...

> You can have this CONFIG_TINY or
> whatever, but then we should also provide the ability to tweak
> the values exactly how we want in a specific application.  The
> tweaking options can be buried under advanced kernel options
> with the appropriate disclaimers about shooting yourself in
> the foot.

Or they could play in the source code if their needs are sufficiently 
unusual, which more or less by definition they will be in this case.  No 
matter how thorough you are here, there will be things they want to tweak (or 
would if they knew about them) that there is no config option for.  "make 
menuconfig" is not a complete replacement for knowing C in all cases.

> Regards,

Rob
