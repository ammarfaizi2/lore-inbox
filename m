Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbTBMEKD>; Wed, 12 Feb 2003 23:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267782AbTBMEKC>; Wed, 12 Feb 2003 23:10:02 -0500
Received: from mithra.wirex.com ([65.102.14.2]:56073 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S267778AbTBMEJ6>;
	Wed, 12 Feb 2003 23:09:58 -0500
Message-ID: <3E4B1CD7.30305@wirex.com>
Date: Wed, 12 Feb 2003 20:19:35 -0800
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
Cc: "'Christoph Hellwig'" <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, "Stephen D. Smalley" <sds@epoch.ncsc.mil>,
       greg@kroah.com, linux-security-module@wirex.com,
       magniett <Frederic.Magniette@lri.fr>,
       "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>,
       Charles.Levert@Ericsson.ca, tytso@thunk.org,
       Pete Loscocco <pal@epoch.ncsc.mil>
Subject: Re: What went wrong with LSM, was: Re: [BK PATCH] LSM changes for
 2.5.59
References: <Pine.LNX.4.44.0302131014010.2621-100000@blackbird.intercode.com.au>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enig68C5EEF76CF222A5D6E4A574"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68C5EEF76CF222A5D6E4A574
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Morris wrote:

>On Wed, 12 Feb 2003, 'Christoph Hellwig' wrote:
>
>>And here we see _the_ problem with the LSM process.  LSM wasn't
>>developed as part of the broad kernel community (lkml) but on
>>a rather small, almost private list.
>>    
>>
>Many of the things that you are saying in this discussion are untrue.
>
>The bulk of the development process was carried out for more than two
>years on the LSM development mailing list, which is fully public and open
>to anyone.  It is not "almost private", whatever that is supposed to mean.
>
For the record:

    * The LSM code patches have always been publicly available for
      anonymous checkout via BK from http://lsm.immunix.org/
    * The LSM mailing list is managed by Mailman and is open for anyone
      to subscribe
      <http://mail.wirex.com/mailman/listinfo/linux-security-module>,
      unsubscribe, or view the archives
      <http://mail.wirex.com/pipermail/linux-security-module/>.
    * The LSM mailing list is also independently archived elsewhere
      <http://marc.theaimsgroup.com/?l=linux-security-module&r=1&w=2>.
    * For the first year or so, the LSM mailing list was "closed" in
      that posts from non-subscribers were trapped for moderation. I
      always approved such posts if they were topical, and used the
      moderation only to filter spam.
    * Subsequent to that, I was told that this is "not the linux way"
      and the mailing list was made "open" so that anyone can post, and
      Spamassassin was installed to filter spam (which doesn't quite
      work perfectly
      <http://mail.wirex.com/pipermail/linux-security-module/2002-October:/3658.html>).

It has never, ever been "private" any more than any of the other 
subsystem -devel lists are "private."

>As for "rather small", hundreds of people were involved in discussion
>during the initial development phase (Chris Wright generated some stats on
>this last year).
>
A few days after I opened the list, it had 300 subscribers. Today it has 
607 subscribers. There have been 4183 posts.

>There were specific LSM discussions at two kernel summits, while multiple
>OLS presentations have been given on LSM.
>
To me, the most gratifying result to come out of OLS 2002 
<http://www.linuxsymposium.org/2002/> (apart from Linus accepting the 
first patch :-) was the Ericsson project 
<http://www.linuxsymposium.org/2002/view_txt.php?text=abstract&talk=44>. 
What makes this project so impressive is that AFAIK Ericsson never asked 
the LSM mailing list a single question. They just took the documents and 
the code, and implemented their module. To me, *that* is evidence that 
the abstraction is usable: that an independent 3rd party can code to it 
without help.

>I do agree that we should have worked more closely with maintainers from
>the beginning, but this was not out of trying to be secretive (of which we
>have been accused quite a few times).  This happened out of believing that
>we should reach a design consensus and write some code via the before
>bothering any maintainers.  This approach was clearly flawed, and efforts
>have since been made to rectify this for ongoing development.
>
And in fact we did seek input from Theodore Ts'o in the summer of 2001. 
Most of that guidance was verbal, and it happened 18 months ago, so my 
memory is imperfect, but I think he advised us to keep the invasiveness 
minimal, and to avoid adding features that were just there to support 
audit. Others at that lunch were Chris Wright (WireX) and Pete Loscocco 
(SELinux).

What I've learned from the LSM merge process is that we need to get 
piecewise buy-in from each major subsystem maintainer that will be 
impacted. For instance, the network hooks did not go in as smoothly as 
we would have liked. Thanks to hard work from James Morris and helpful 
feedback from David Miller, they did go in after substantial revisions. 
Next time, we will float a paper design past subsystem maintainers ahead 
of time.

>Claims of a "secret" and non-generalized design process are baseless.
>
Here here.

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                            http://wirex.com/~crispin/
Recruiting for Linux kernel and glibc developers: http://immunix.org/jobs.html


--------------enig68C5EEF76CF222A5D6E4A574
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Sxzf5ZkfjX2CNDARAQsuAKDkh4Yv9fHhVz7VdLnyjJutbhc+eACcDJoC
Kg0FodkirXIITLa5pcVIZ/U=
=ub4X
-----END PGP SIGNATURE-----

--------------enig68C5EEF76CF222A5D6E4A574--

