Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUGIGZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUGIGZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 02:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUGIGZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 02:25:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264382AbUGIGZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 02:25:36 -0400
Date: Fri, 9 Jul 2004 08:24:03 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040709062403.GA15585@devserv.devel.redhat.com>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au> <20040708120719.GS21264@devserv.devel.redhat.com> <20040708205225.GI28324@fs.tum.de> <20040708210925.GA13908@devserv.devel.redhat.com> <1089324501.3098.9.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <1089324501.3098.9.camel@nigel-laptop.wpcb.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 09, 2004 at 08:08:21AM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2004-07-09 at 07:09, Arjan van de Ven wrote:
> > the problem I've seen is that when gcc doesn't honor normal inline, it will
> > often error out if you always inline....
> > I'm open to removing the < 4 but as jakub said, 3.4 is quit good at honoring
> > normal inline, and when it doesn't there often is a strong reason.....
> 
> I'm busy for the next couple of days, but if you want, I'll make
> allyesconfig next week and go through fixing the compilation errors so
> that the < 4 can be removed. Rearranging code so that inline functions
> are defined before they're called or not declared inline if they can't
> always be inlined seems to me to be the right thing to do. (Feel free to
> say I'm wrong!).

one thing to note is that you also need to monitor stack usage then :)
inlining somewhat blows up stack usage so do monitor it...

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA7joDxULwo51rQBIRAmi9AJwOmZzJUEyHtm39DEo8PHqBQn+zGQCghCjt
9fFoHxSzLdWcs2gSjOXcm6o=
=amQB
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
