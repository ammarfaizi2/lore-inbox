Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUH2VH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUH2VH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268327AbUH2VH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:07:27 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:11218 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S268312AbUH2VEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:04:37 -0400
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Subject: Re: Linux Incompatibility List
Date: Sun, 29 Aug 2004 17:04:21 -0400
User-Agent: KMail/1.7
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <87r7q0th2n.fsf@dedasys.com> <200408282143.05304.public@mikl.as> <1093749701.7064.37.camel@sherbert>
In-Reply-To: <1093749701.7064.37.camel@sherbert>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1575478.sYUiadIyjC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408291704.24820.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1575478.sYUiadIyjC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,


On August 28, 2004 11:21 pm, Gianni Tedesco wrote:
<snip>
> OK, exactly which drivers were you using to do this? When I had the
> interface brought up in win2k-server with the bcmwl5.sys driver I was
> seeing every few hundred milliseconds a batch of say 12 2-byte reads on
> the register space to check status...

I was never able to get it going myself (If I remember correctly, there was=
=20
some issue with how the interrupts were being routed on my notebook.  We we=
re=20
doing some strange stuff to forward interrupts from the host kernel into=20
Bochs that didn't work on all configurations.)

However, Frank Cornelis was using the Windows 98 drivers running under Win9=
8=20
on pcidev+Bochs.  Kendall Blake was using the Windows XP drivers and a=20
modified ndiswrapper running under Linux also on pcidev+Bochs.  Kendall tol=
d=20
me that he generated about 400 megs of logs just looking at the card=20
initialization.  I think it was at this point I decided that decompiling th=
e=20
thing would be easier.  :)

Anyway, you could try asking Frank and Kendall for some of the data they=20
gathered.

kendallb () eden rutgers edu
fcorneli () pandora be


<snip>
>
> Hrm, you're sure those variations aren't trivial? Although theres lots
> of checks, I would have thought they would just be stuff like "card A
> supports X, Y and Z features"?

The differences between radio chips (ex. a vs. g) aren't going to be trivia=
l. =20
That is to say, entirely different code paths are executed in the wlc_phy.o=
=20
component.  The variations caused by different board configurations don't=20
appear to be too big (at least from the code I've looked at).  Some of the=
=20
variations (probably bug fixes) caused by different revisions of the chips=
=20
are also a little large.  But, I think it will be pretty difficult to=20
determine how the differences in the dumps relate to differences in the=20
hardware configuration.


>
> The approach that makes the most sense to me is get 1 card working to
> the point where it sends/receives packets, then look at the binaries to
> see what the variations are, and how they apply to what cards and just
> go fill in the blanks...

The problem is that all Broadcom's wireless hardware is supported by one bi=
g=20
driver.  If you wanted to be able to see the differences between what code =
is=20
executed against each device, you'd pretty much have to decompile the whole=
=20
thing, or at least do some serious debugger work.  Assuming you don't want =
to=20
do that, it seems you're left with doing the capture analysis on every=20
variation, which doesn't seem practical.


<snip>
> Also, you mention DMA and sending/receiving packets, exactly how much
> progress have you made so far?

I'm pretty sure that they were able to get packets to go back and forth.  B=
ut,=20
the last I heard from anyone using the capture method with pcidev and Bochs=
=20
was about six months ago.


=2D- Andrew

--nextPart1575478.sYUiadIyjC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Key ID: EC3F6CCD (www.keyserver.net)

iD8DBQBBMkTYTHKGaOw/bM0RAsDwAJ4g7uGjslv/xAvCBamfC4NdNbLmegCguHY8
9U1ada4sVTFed9xDBF/w6q8=
=dDow
-----END PGP SIGNATURE-----

--nextPart1575478.sYUiadIyjC--
