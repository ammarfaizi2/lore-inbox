Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281473AbRKVS7O>; Thu, 22 Nov 2001 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281456AbRKVS65>; Thu, 22 Nov 2001 13:58:57 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:59114 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281355AbRKVS6k>; Thu, 22 Nov 2001 13:58:40 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: James A Sutherland <jas88@cam.ac.uk>
To: =?iso-8859-15?q?Fran=E7ois=20Cami?= <stilgar2k@wanadoo.fr>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 18:58:31 +0000
X-Mailer: KMail [version 1.3.1]
Cc: war <war@starband.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111221456020.1491-100000@duckman.distro.conectiva> <3BFD4A42.8090002@wanadoo.fr>
In-Reply-To: <3BFD4A42.8090002@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E166z3N-00020W-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 6:56 pm, François Cami wrote:
> Rik van Riel wrote:
> > On Thu, 22 Nov 2001, James A Sutherland wrote:
> >>Obviously, there are cases where removing swap breaks the system
> >>entirely, but even in other cases, adding swap should *never* degrade
> >>performance. (In theory, anyway; in practice, it still needs
> >>tuning...)
> >
> > Not quite true.  The VM cannot look into the future, so if
> > you have swap it could have just swapped out the application
> > on the desktop you're about to switch to ;)
>
> I tend to agree. Especially since in some cases (i.e. after
> a long compilation (read : lots of code)), the VM has the most
> excellent idea to swap out all the GUI (X+apps) and everyone
> here knows how long it can be to restore the GUI in that case.

Use-once should avoid *most* of that, though not all; all your .c files 
should be read in once each by gcc, and never touched again. Of course the 
headers need to be cached, and the .o files will be accessed multiple times 
too.

> Obviously the problem is very much lessened, in my case, when
> i put the swap partition on the *other* drive than the root fs.
> Both are ATA100 (40GB 60GXPs), and the system is more responsive
> with swap on hdc while / in on hda, than both on hda.

Hmm... if you've experimented with this, how does this setup compare to a 
striped RAID of hda+hdc used for root and swap? (i.e. is the speedup down to 
splitting accesses between two spindles?)


James.
