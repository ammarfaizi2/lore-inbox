Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbSJHBsh>; Mon, 7 Oct 2002 21:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbSJHBsh>; Mon, 7 Oct 2002 21:48:37 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:38670 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262614AbSJHBs0>; Mon, 7 Oct 2002 21:48:26 -0400
Date: Tue, 8 Oct 2002 02:53:59 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: kai@tp1.ruhr-uni-bochum.de
Subject: Re: vpath broken in 2.5.41
Message-ID: <20021008015359.GA38838@compsoc.man.ac.uk>
References: <20021007232852.GA35308@compsoc.man.ac.uk> <Pine.LNX.4.44.0210072037520.32256-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210072037520.32256-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17yjZP-0008rb-00*R5Hw8cGjctI* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 08:39:46PM -0500, Kai Germaschewski wrote:

> > How now can I build the oprofile.o target from two directories ?
> 
> I see in the patch you mailed later that you got it figured out already, 
> using a relative path.
> And yeah, it's not particularly beautiful. But I do not see any nice and 
> easy way, either.

OK. If you say that the vpath support is troublesome, I will believe
you :)

> What would help a lot, of course, would be to split this 
> into two modules, one generic one, one arch-specific one. Have you 
> considered doing that?

I think I said to you before that implementing a runtime solution to a
build time problem is a little bizarre IMHO. I would *much* rather have
4 lines of slightly icky Makefile than complicate *any* runtime code.

I suppose it would not be much more complicated than a request_module()
inside oprofile_init(), but it's still more code for next-to-zero
benefit ...

regards
john
-- 
"I will eat a rubber tire to the music of The Flight of the Bumblebee"
