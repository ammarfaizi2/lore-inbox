Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266706AbUFYKHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266706AbUFYKHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266700AbUFYKGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:06:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15755 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266695AbUFYKFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:05:32 -0400
Date: Fri, 25 Jun 2004 12:05:03 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm2, mmaps rework, buggy apps, setarch
Message-ID: <20040625100503.GA20954@devserv.devel.redhat.com>
References: <20040625082243.GA11515@gamma.logic.tuwien.ac.at> <1088152275.2704.8.camel@laptop.fenrus.com> <20040625100051.GA19905@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20040625100051.GA19905@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 25, 2004 at 12:00:52PM +0200, Norbert Preining wrote:
> Hi Arjan!
> 
> On Fre, 25 Jun 2004, Arjan van de Ven wrote:
> > > Can someone please explain me *what* the effects of a `buggy app' would
> > > be: Segfault I suppose. But what to do with a commerical app where I
> > > cannot check a stack trace or whatever?
> > 
> > basically the applications that break do:
> > 
> > int ptr;
> > ptr = malloc(some_size);
> > if (ptr <= 0) 
> >     handle_no_memory();
> 
> Mmm, this looks very common. What is the `intended' way to handle this?

it's actually not common:
1) it stores a pointer in an int which isn't allowed
2) it uses < operator on a pointer

the correct way is 

void * ptr;
ptr = malloc(some_size);
if (ptr == NULL)
	handle_no_memory();


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2/jPxULwo51rQBIRAtKoAJ4kQfKAYOxCsJ3nXOn9TYnrzo3heQCfVWuV
PJjjUkFmc09xyQB6/hcRMGw=
=Jvz6
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
