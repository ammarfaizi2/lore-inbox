Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVF3RLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVF3RLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 13:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVF3RLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 13:11:35 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:44219 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262838AbVF3RLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 13:11:05 -0400
Date: Thu, 30 Jun 2005 19:10:57 +0200
From: David Weinehall <tao@acc.umu.se>
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Hans Reiser <reiser@namesys.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050630171057.GT16867@khan.acc.umu.se>
Mail-Followup-To: Hubert Chan <hubert@uhoreg.ca>,
	Hans Reiser <reiser@namesys.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
	Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <hubert@uhoreg.ca> <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <87hdfgvqvl.fsf@evinrude.uhoreg.ca> <8783be6605062914341bcff7cb@mail.gmail.com> <42C3615A.9020600@namesys.com> <871x6kv4zd.fsf@evinrude.uhoreg.ca> <20050630062956.GP16867@khan.acc.umu.se> <87psu3vnvc.fsf@evinrude.uhoreg.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psu3vnvc.fsf@evinrude.uhoreg.ca>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 11:57:27AM -0400, Hubert Chan wrote:
> On Thu, 30 Jun 2005 08:29:56 +0200, David Weinehall <tao@acc.umu.se> said:
> 
> > On Thu, Jun 30, 2005 at 12:33:10AM -0400, Hubert Chan wrote:
> >> It's sort of like the way web servers handle index.html, for those
> >> who think it's a stupid idea.  (Of course, some people may still
> >> think it's a stupid idea... ;-) )
> 
> > And guess what?  That's handled on the web server level (userland),
> > not by the file system.  So different web servers can handle it
> > differently (think index.html.sv, index.html.zh, index.php, etc).
> 
> >From the web *browser*'s point of view, it is handled by the
> "filesystem" (which is provided by the various servers).  The browser
> doesn't care how or where the data is stored.  It just requests a file,
> and gets some data back.  So the browser doesn't have to check for
> http://www.example.com/, get a failure (trying to read a directory),
> check for http://www.example.com/index.html, etc.  In this way, the web
> server controls (which I think takes the place of the filesystem in this
> case) what gets shown (index.html.sv, etc.), instead of the leaving it
> up to the browser.
> 
> In the same way, you don't want every single user program to have to
> guess whether it should look at .data, or .contents, or whatever.

For the analogy to be complete:

User has a file browser (say Nautilus)
The file browser sees the userland VFS (say a unified VFS between GNOME
and KDE)
The VFS sees the real file system

This way the userland VFS can be ported to almost any platform.

When toying around on the desktop, an abstraction of what a file
is works fine with me.  When doing serious work (programming,
tar:ing up stuff, etc) I want to be bloody sure that I see the
files in the same way always.  I don't want surprises such as
files suddenly behaving as directories or vice versa.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
