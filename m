Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286401AbRLTVhh>; Thu, 20 Dec 2001 16:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286402AbRLTVhZ>; Thu, 20 Dec 2001 16:37:25 -0500
Received: from pc-62-30-67-59-az.blueyonder.co.uk ([62.30.67.59]:19440 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S286413AbRLTVgb>; Thu, 20 Dec 2001 16:36:31 -0500
Date: Thu, 20 Dec 2001 21:32:22 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Pavel Machek <pavel@suse.cz>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Quinn Harris <quinn@nmt.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Message-ID: <20011220213222.B9116@kushida.jlokier.co.uk>
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <20011213030107.L940@lynx.no> <20011213221712.A129@elf.ucw.cz> <E16GnIg-0000V5-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16GnIg-0000V5-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Dec 19, 2001 at 09:26:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> > > Consider the _very_ common case (that nobody has mentioned yet) where you
> > > are editing a large file.  When you write to the file, the editor copies
> > > the file to a backup, then immediately truncates the original file and
> > > writes the new data there.  What would be _far_ preferrable is to
> > > just
> > 
> > Are you sure? I think editor just _moves_ original to backup.
> 
> It would be so nice if all editors did that, but most don't according to the 
> tests I've done, especially the newer ones like kedit, gnome-edit etc.  I 
> think this is largely due to developers not knowing why it's good to do it 
> this way.

Moving the original to make a backup is a _bad_ thing if the original
might be hard-linked and you'd like all instances to be written to.
OTOH it'a a good thing if you're using hard links for poor man's version
control (`cp -rl').  Hey :)

Emacs does this perfectly with `backup-by-copying-when-linked' (an
option you can change, but I like it on).

-- Jamie
