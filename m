Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUH1QrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUH1QrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267503AbUH1QqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:46:06 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:18185 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267476AbUH1QpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:45:25 -0400
Date: Sat, 28 Aug 2004 18:49:31 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Helge Hafting <helge.hafting@hist.no>, Matt Mackall <mpm@selenic.com>,
       Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040828164931.GA24868@hh.idb.hist.no>
References: <helge.hafting@hist.no> <412D9FFA.6030307@hist.no> <200408261817.i7QIH35O002702@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408261817.i7QIH35O002702@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:17:03PM -0400, Horst von Brand wrote:
> Helge Hafting <helge.hafting@hist.no> said:
> > Matt Mackall wrote:
> 
> [...]
> 
> > >Find some silly person with an iBook and open a shell on OS X. Use cp
> > >to copy a file with a resource fork. Oh look, the Finder has no idea
> > >what the new file is, even though it looks exactly identical in the
> > >shell. Isn't that _wonderful_? 
> 
> > It is what I'd expect.
> 
> Great. That means that all the tools of the trade stop working. Sounds like
> show-killer feature to me.
>
All wrong.  Feel free to dislike the concept all you want, but don't provide 
false arguments.  I am sure you can think up some _good_ ones, if
you feel so strongly about this.

_No_ tool "stop working" with such a fs.  Of course the new
feature (file-as-directory) may not be supported - which is a problem
only for files that use the new feature.  Stick a lot of ordinary
files and directories in such a fs, and the tools works as before
with no breakage.  People obviously won't deploy new features before
they are useable - the fs have to come first.  Then the tools,
and widespread use only after that.  This is similiar to other extensions 
like ACLs which many tools don't understand.  They're still useable though.

Of course file-as-directory can have pilot uses like the often
mentioned thumbnails - because it doesn't matter if those aren't
backed up or get lost at random during the experimental phase.

 
> >                         Now, use cp -R to copy  the file
> > _with its directory_,
> 
> Either it is a file or a directory. Make up your mind. 

Wrong again.  The file-as-directory concept means that
a filename refers to something that is a file, or a directory,
or both.  That's the point of it.  Being both isn't
possible with current filesystems (except reiser4) of course, 
but file-as-directory is a proposed _extension_.  

> If you have no clear
> distinction, you'll only get messed up. Badly.
>
The distinction is clear enough - three options instead of two.
 
> Excuse me, I must grab my sickness bag here.

Oh, very impressive.  Please take a look at what we're talking
about before attacking.   

Helge Hafting



