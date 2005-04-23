Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVDWRyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVDWRyt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVDWRyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 13:54:44 -0400
Received: from pop.gmx.de ([213.165.64.20]:38062 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261638AbVDWRy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 13:54:26 -0400
X-Authenticated: #590723
From: Fabian Franz <FabianFranz@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 19:50:39 +0200
User-Agent: KMail/1.5.4
Cc: Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200504231950.43903.FabianFranz@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Samstag, 23. April 2005 19:31 schrieb Linus Torvalds:
> On Sun, 24 Apr 2005, David Woodhouse wrote:
> > Nah, asking Linus to tag his releases is the most comfortable way.
> >
> The reason I've not done tags yet is that I haven't decided how to do
> them.
>
> 	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
> 	tag v2.6.12-rc3
> 	signer Linus Torvalds
>
> 	This is my official original 2.6.12-rc2 release
>
> 	-----BEGIN PGP SIGNATURE-----
> 	....
> 	-----END PGP SIGNATURE-----
>
> If somebody writes a script to generate the above kind of thing (and tells
> me how to validate it), I'll do the rest, and start tagging things
> properly. Oh, and make sure the above sounds sane (ie if somebody has a
> better idea for how to more easily identify how to find the public key to
> check against, please speak up).

To generate those you do:

# cat unsigned_tag

	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
	tag v2.6.12-rc3
	signer Linus Torvalds
	This is my official original 2.6.12-rc2 release

# gpg --clearsign < unsigned_tag > signed_tag # gpg will ask here for the 
secret key phrase

To verify you do:

# gpg --verify < signed_tag

and check exit status.

Hope that helps,

cu

Fabian 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCaorzI0lSH7CXz7MRAr3QAJ45f2CQTgJ0sYfF9kRyrWHbsazVQQCeMqW7
HCsah/llt/I8sQ36dlDnRWg=
=Fgq1
-----END PGP SIGNATURE-----

