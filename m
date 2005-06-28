Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVF1PCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVF1PCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVF1PCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:02:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28831 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261958AbVF1PA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:00:28 -0400
Date: Tue, 28 Jun 2005 17:00:27 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Christopher Li <hg@chrisli.org>
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050628150027.GB1275@pasky.ji.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624123819.GD9519@64m.dyndns.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Fri, Jun 24, 2005 at 02:38:19PM CEST, I got a letter
where Christopher Li <hg@chrisli.org> told me that...
> On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> > > 5.1) undo the last commit or pull
> > > 
> > > $ hg undo
> > 
> > $ cg-admin-uncommit
> > 
> > Note that you should never do this if you already pushed the changes
> > out, or someone might get them. (That holds for regular Git too.) See
> > 
> > $ cg-help cg-admin-uncommit   # (or cg-admin-uncommit --help)
> > 
> > for details. (That's another Cogito's cool feature. Handy docs! ;-)
> > 
> 
> Does it still works if the last commit was interrupted  or due to error for some
> reason?

If the last commit was interrupted, it didn't happen, so your tree stays
in the same state as before doing the commit, as well as the repository.
You can just try again. If you want to get rid of dirty stuff,
cg-cancel.

> Undo pull is pretty cool because you might pull a lot of commit
> in one blow. Get rid of commit one by one is going to be painful. Some times
> the object you pull has more than one chain of history it will be very nasty
> if you want to clean it up.

If it was a tree merge, cg-admin-uncommit will undo it. If it was
fast-forward merge, there is no direct way to uncommit it, but you can
find the first fast-forwarded commit and pass it as argument to
cg-admin-uncommit; it will then rewind all the commits up to (including)
the given commit.

> Mercurial's undo is taking a snapshot of all the changed file's repo file length
> at every commit or pull.  It just truncate the file to original size and undo 
> is done.

"Trunactes"? That sounds very wrong... you mean replace with old
version? Anyway, what if the file has same length? It just doesn't make
much sense to me.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
