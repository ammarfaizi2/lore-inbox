Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVFZVMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVFZVMa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 17:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVFZVMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 17:12:30 -0400
Received: from h80ad261f.async.vt.edu ([128.173.38.31]:23171 "EHLO
	h80ad261f.async.vt.edu") by vger.kernel.org with ESMTP
	id S261577AbVFZVMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 17:12:16 -0400
Message-Id: <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Sun, 26 Jun 2005 14:58:07 CDT."
             <42BF08CF.2020703@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
            <42BF08CF.2020703@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119819931_3659P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Jun 2005 17:05:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119819931_3659P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Jun 2005 14:58:07 CDT, David Masover said:

> "Plugins" is a bad word.  This user's combination of plugins is most
> likely identical to other users', it's just which ones are enabled, and
> which aren't?  If they are all included, I assume they play nice.

Which ones are enabled. Exactly.

> And just because they are called "plugins" doesn't mean the EA looks
> different every week.

They do if the one enabled this week is "make EAs look like symlinks", and
last week's was "make EAs look like folders".

(Don't blame me, *you're* the one that said "EAs can look like any other object"..)


> > And 'cat crypto/raw/foo' or 'crypto/inflated/foo.gz' gets you what, exactly
?
> > 
> > Now throw some .bz2 and .zip files into the mix... ;)
> 
> Interface is the same.  Only, zip files aren't just compression, so
> maybe the interface changes a little there.

Right. So please explain what crypto/raw/foo and crypto/inflated/foo.gz give you.

> Point is, now you have a standard interface for any program to access
> any simple lossless compression, transparently.
> 
> >>Another possibility, if you like file-as-a-directory:
> >>
> >>cat foo.gz			# raw
> >>cat foo.gz/inflated		# decompressed
> >>
> >>One could easily imagine things like these two potentially equivalent
> >>commands:
> >>
> >>cp foo bar.zip/
> >>zip bar foo

> > Unless of course the user had done 'mkdir sorted.by.city.zip' to make
> > a directory of files containing data sorted by USPS Zip code.
> 
> What's this got to do with anything?

It's got a *LOT* to do with it if I created a *DIRECTORY*, to use *AS A DIRECTORY*,
the way Unix-style systems have done for 3 decades, and suddenly my system is
running like a pig because the kernel decided that it's a .zip file.

> > And what happens if the user has a file 'bar' that's not a ZIP file,
> > and a directory 'bar.zip' isn't a view into 'bar'?
> 
> In file-as-a-directory (which is probably NOT happening soon), bar.zip
> is both the actual zipfile and the view inside, depending on whether you
> try to open() it directly or peek inside it as a directory.

Ahem.  "bar.zip' is a *DIRECTORY*. I said 'mkdir bar.zip' - why is it not
acting like a directory?
 
> However, let's not discuss this now.  I do NOT want to start another
> "silent semantic changes with reiser4" thread.  File-as-directory is not
> happening this time, so don't worry about it -- this time.

Fish or cut bait.  You are the one who started handwaving the 'file-as-directory'.
If you don't want it discussed, don't mention it.

> > Most of the time, if I have a file 'linux-2.6.12.tar.bz2' and a
> > directory 'linux-2.6.12', what is under the directory is *NOT* the same
> > data as what's in the .bz2 - I've done 'make oldconfig' and a few builds
> > and some variable amount of patching, usually with rejects, and I *don't*
> > want that .bz2 being updated during all this (hint - what's my next command
> > after 'rm -rf linux-2.6.12' likely to be, and why, and  what expectations
> > do I have when I do it?)
> 
> You're misunderstanding.  man zip.
> $ zip bar foo
> creates/modifies a file named "bar.zip", not "bar", which contains the
> file "foo".

No. *YOU* are misunderstanding.  I have a directory 'linux-2.6.12', and
I have a file 'linux-2.6.12.tar.bz2', and I do *NOT* want directory operations
to be silently converted into "let's scribble into the middle of this tar file
and then compress it".  (Hint - work out how long a kernel 'make' would take
if you were doing it inside a .tar.bz2).

> > You want to think this sort of thing through *really* thoroughly, because
> > there's a *lot* of things, both users and programs, that have expectations
> > about The Way Things Work.
> 
> Or, I can avoid those issues altogether, and simply delegate this kind
> of stuff to user-created-but-magic directories.  For instance, I could
> have a directory called "/foo" which contains encrypted files, and
> "/foo/decrypted" which has transparently decrypted representations of them.

So rather than everything working in a funky manner, a program gets to guess
how funky, and in what direction, a given magical directory is....

--==_Exmh_1119819931_3659P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCvxibcC3lWbTT17ARAmdDAKCl03u+0C3DbpXJ1w7PZrP65g3zSQCeO7gk
oQrsDYtfrhfdEmwbRCFZpN4=
=2HPw
-----END PGP SIGNATURE-----

--==_Exmh_1119819931_3659P--
