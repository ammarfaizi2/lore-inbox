Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317678AbSGUOah>; Sun, 21 Jul 2002 10:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317680AbSGUOah>; Sun, 21 Jul 2002 10:30:37 -0400
Received: from insgate.stack.nl ([131.155.140.2]:45838 "EHLO skynet.stack.nl")
	by vger.kernel.org with ESMTP id <S317678AbSGUOag>;
	Sun, 21 Jul 2002 10:30:36 -0400
Date: Sun, 21 Jul 2002 16:33:41 +0200 (CEST)
From: Jos Hulzink <josh@stack.nl>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Szakacsits Szabolcs <szaka@sienet.hu>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <Pine.NEB.4.44.0207211438440.11656-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <20020721162011.I69041-100000@turtle.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, Adrian Bunk wrote:

> On 21 Jul 2002, Alan Cox wrote:
>
> > I would suggest you do something quite different. Go and read what K&R
> > had to say about the design of Unix. One of the design goals of Unix is
> > that the system does not think it knows better than the administrator.
> > That is one of the reasons unix works well and is so flexible.
>
> The problem is that at the time K&R said this only real men (tm) were
> administrators of UNIX systems. Nowadays clueless people like me are
> administrators of their Linux system at home.  ;-)
>
> With enough stupidity root can always trash his system but if as Robert
> says the state of the system will be that "no allocations will succeed"
> which seems to be a synonymous for "the system is practically dead" it is
> IMHO a good idea to let "swapoff -a return -ENOMEM".
>

Maybe it is an option to add the --I_know_Im_stupid option to the swapoff
command line ? (Also known as the --force flag). This way we can both
return an error when the OS lacks memory and force a swapoff.

Agreed, the system is practically dead when no allocations will succeed,
but maybe killing user tasks when root needs memory or something is an
option... (Better a few angry users than a crashed server, besides, it is
not something that should happen every day)

Jos

