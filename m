Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbTF0W2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTF0W2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:28:49 -0400
Received: from mail47-s.fg.online.no ([148.122.161.47]:41359 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP id S264861AbTF0W2s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:28:48 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org
Subject: Re: TCP send behaviour leads to cable modem woes
Date: Sat, 28 Jun 2003 00:43:25 +0200
User-Agent: KMail/1.5.2
References: <200306272020.57502.svein.ove@aas.no> <200306272224.04335.svein.ove@aas.no> <1056746615.12886.459.camel@slurv.ws.pasop.tomt.net>
In-Reply-To: <1056746615.12886.459.camel@slurv.ws.pasop.tomt.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306280043.26778.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

fredag 27. juni 2003, 22:43, skrev Andre Tomt:
> On fre, 2003-06-27 at 22:24, Svein Ove Aas wrote:
> > > http://lartc.org/wondershaper/
> >
> > I wrote something like that myself once.
> > It's a good shaper, but it works by *capping* up/download speeds and
> > rearranging the priorities locally, which wouldn't help me a bit.
>
> By capping the speed below the link speed most modems will usually avoid
> bursting. IMHO it's mostly a net gain in usability even though you don't
> get the same raw download speeds as without capping.

I'll try it if the F-RTO option doesn't work. Might as well.

It might actually work; the problem at the moment is that as far as the kernel 
is concerned my usual uplink works at 10Mbit/s++ for a fraction of a second 
and then downright drops most of the rest of the data it's sent until the 
next burst. If I cap it sufficiently that it can't overflow either the line 
(on average) or my cable modem's buffers, that should work.

It makes sense.

Now, how come I didn't think of that myself?

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/MiN9OlFkai3rMARArzXAKDTITRw3swGcINfEBAlteJlCS2CiACgpVIw
FpqXUkhx8iJct7nEuLaZ3Xc=
=GisS
-----END PGP SIGNATURE-----

