Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSDOUZx>; Mon, 15 Apr 2002 16:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313207AbSDOUZw>; Mon, 15 Apr 2002 16:25:52 -0400
Received: from ns.suse.de ([213.95.15.193]:11272 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313206AbSDOUZu>;
	Mon, 15 Apr 2002 16:25:50 -0400
Date: Mon, 15 Apr 2002 22:25:49 +0200
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, Dominik Kubla <kubla@sciobyte.de>,
        linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020415222549.A25140@wotan.suse.de>
In-Reply-To: <20020409184605.A13621@cecm.usp.br.suse.lists.linux.kernel> <200204100041.g3A0fSj00928@saturn.cs.uml.edu.suse.lists.linux.kernel> <20020410092807.GA4015@duron.intern.kubla.de.suse.lists.linux.kernel> <p73adsbpdaz.fsf@oldwotan.suse.de> <20020408203515.B540@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 08:35:16PM +0000, Pavel Machek wrote:
> Hi
> 
> > > The background  fsck capability, just  like journalling or  logging, are
> > > typically only in needed in 24/7 systems (sure, they are nice to have in
> > > your home  system, but do  you _REALLY_ need  them? i don't!)  and those
> > > system  typically are  run on  proven  hardware which  is operated  well
> > > within the specs. So please don't construct these kinds of arguments.
> > 
> > You can already do background fsck on a linux system today. Just do it on
> > a LVM/EVMS snapshot.
> 
> How do you fix errors you find by such background fsck?

You umount the file system (that is the best you can do with a random
error anyways, BSD doesn't do any better except in the special case
of lost blocks in the bitmap) and fsck it again on the real volume.

In theory you could build a mechanism to pass some state from the 
first fsck to the second to speed the second up, but it is probably not 
worth it.


-Andi
