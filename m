Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbSKSV63>; Tue, 19 Nov 2002 16:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbSKSV62>; Tue, 19 Nov 2002 16:58:28 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:21986 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267399AbSKSV61>; Tue, 19 Nov 2002 16:58:27 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Sam Ravnborg <sam@ravnborg.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: [RFC/CFT] Separate obj/src dir
Date: Wed, 20 Nov 2002 08:55:18 +1100
User-Agent: KMail/1.4.5
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20021119202931.GA15161@mars.ravnborg.org> <Pine.LNX.3.95.1021119153545.6004A-100000@chaos.analogic.com> <20021119205430.GC15161@mars.ravnborg.org>
In-Reply-To: <20021119205430.GC15161@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211200855.19037.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 20 Nov 2002 07:54, Sam Ravnborg wrote:
> But my point is that there is a good use of different configurations
> based on the same src.
I think that your example for testing is the most valid one.

In development, you normally have different source trees (hardlinked if you 
don't have a terabyte of hard drive space to spare), and use an editor that 
breaks hard-links (eg, emacs). You might as well build in the source 
directory, since you'll likely keep reworking it.

In release testing (aka release engineering, or more accurately: release 
fumbling-in-the-dark), you need to test a few different configurations. Sure, 
you could just build a set of symlink or hardlink trees, but it'd be very 
useful to be able to "make multiconfigs" and have a representative set of 
kernels built (either for later testing, or at least to ensure that the new 
kernel will build without modules, without networking, without IDE, and so 
on). Sure, it will take a while if you build everything, but that is why 
God^WTridge gave us ccache.

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92rNGW6pHgIdAuOMRAmcDAKCnzBOh6/6+zouOlM2bi1z2mcEmSACghEnp
MzXw5OsNmbZfzBMVGrFmNr0=
=7DkQ
-----END PGP SIGNATURE-----

