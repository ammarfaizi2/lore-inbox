Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbTBEAyP>; Tue, 4 Feb 2003 19:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTBEAyP>; Tue, 4 Feb 2003 19:54:15 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:2743 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP
	id <S267635AbTBEAyL>; Tue, 4 Feb 2003 19:54:11 -0500
Date: Wed, 5 Feb 2003 01:03:44 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030205010344.GG1200@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com> <20030204232101.GA9034@work.bitmover.com> <20030204235112.GB17244@unthought.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline
In-Reply-To: <20030204235112.GB17244@unthought.net>
User-Agent: Mutt/1.4i
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2003 at 12:51:12AM +0100, Jakob Oestergaard wrote:
> On Tue, Feb 04, 2003 at 03:21:01PM -0800, Larry McVoy wrote:
> > I can't offer any immediate help with this but I want the same thing.  At
> > some point, we're planning on funding some extensions into GCC or whatever
> > reasonable C compiler is around:
> > 
> >     - regular expressions
> > 
> >       {
> >       	  char	*foo = "blech";
> > 
> > 	  if (foo =~ /regex are nice/) {
> > 	  	printf("Well isn't that special?\n");
> > 	  }
> >       }
> 
> Ok, I can't help you with that.

   I wanted something like that a while ago, so I wrote a couple of
classes in C++ to handle regexps. Some of the test code looks like
this:

        string str = "fum foo";
	rejex exp("f(o*)");
	// Search for a regex
	if( s/exp )
		cout << "Found it!" << endl;
	// Count matches
	cout << s/exp << " matches" << endl;

	replace rep("g$0");

	// Search & replace
	str/exp/rep;
	cout << s << endl;

	// All in one
	"foo bar"/rejex("ba")/replace();

   It's not perfect by any stretch of the imagination, but it works.
I've not released it, because I haven't had a chance to get it into a
releasable form yet. Actually, looking at it, I should probably play a
couple of tricks with overloading operators to give you instead

   str =~ search/replace;

or even

   "str" =~ "search"/"replace";

> You have probably seen a Perl program before... Now imagine a two
> million line Perl program... That is why the above is not a good idea ;)
> 
> It's still your right to want it of course...

   That's a good point, but I've always felt that the main problem
with perl isn't the regexes, but the rest of the language(*).

   Hugo.

(*) Some may feel that, coming from a C++ programmer, this is a case
of the pot calling the kettle black. :)

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- Our so-called leaders speak/with words they try to jail ya/ ---   
        They subjugate the meek/but it's the rhetoric of failure.        
                                                                         

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+QGLwssJ7whwzWGARAo4KAKCjutuCnjF5sK0tWLI/6WF3zX53+gCgjLt9
76hxwxh8qXaDNe/lskMB1pU=
=tZtj
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--
