Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbTL3FD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 00:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbTL3FD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 00:03:58 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:1469 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S264927AbTL3FDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 00:03:54 -0500
Date: Tue, 30 Dec 2003 05:03:29 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm2
In-Reply-To: <200312292315.08854.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.58.0312300454120.7711@student.dei.uc.pt>
References: <20031229013223.75c531ed.akpm@osdl.org> <200312291832.35367.dtor_core@ameritech.net>
 <Pine.LNX.4.58.0312300247570.25540@student.dei.uc.pt>
 <200312292315.08854.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 29 Dec 2003, Dmitry Torokhov wrote:

[..SKIP..]
> OK, I understand your concerns. Synaptics support had its share of problems
> and being incompatible with all other mice "scared" off a lot of people.
> Since then translation from absolute to relative (compatible with other mice)
> mode was added to mousedev. This translation allows userspace see touchpad
> as a regular PS2 mice, bare protocol and no support for tapping or any
> advanced features. This is what you seem to be using at the moment. It is
> there to ease transition from older kernels, the mouse should just work.
> There was a couple quirks with it but they should be resolved in the latest
> bk.
[..SKIP..]
> If for some reason you do not want use your touchpad in native mode you can
> disable it by passing psmouse_proto={bare|imps|exps} to the kernel. Any one
> of them will suffice. It will disable touchpad's absolute mode and will
> switch it to PS/2 hardware emulation, much like in 2.4. Now, in latest -bk
> there is a problem passing parameters to psmouse if its compiled directly
> into the kernel (you have to specify psmouse.psmouse_proto=... instead of
> just psmouse_proto=...) but I will be sending patch for it shortly.
[..SKIP..]

First of all, thanks for the help, my problem is now solved, and it's good to
see the patch you sent so used just have to pass psmouse_proto=... to the
kernel whenever they compiled it as a module or built-in in the kernel.
However the question is still there... I mean: I now know the sollution because
I asked here on lkml, and now I understand what's really happening, but if the
target is to get the work easy for those upgrading from 2.4, then you're
failing... I mean, for those who are in the same sittuation than me they will
just stop having the mouse tap feature with the kernel update, so why don't
just make the psmouse_proto={bare|imps|exps} argument selectable in the kernel
configuration?

Once again, maybe there's something more that I can't see here, but makes
pretty much more sense to me people have to do the choice while compiling the
kernel than having no choice and then having to pass an argument to the
kernel...

Please take that into consideration,
My best regards and keep the good work,

Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/8QclmNlq8m+oD34RAmJzAKC+cR8bmrmeGSOvbQFvd4O/qJSQoQCdFxFT
ImYIFSTdmPj4iun2Bl4VVR0=
=78ue
-----END PGP SIGNATURE-----

