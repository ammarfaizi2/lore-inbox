Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966227AbWKNSvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966227AbWKNSvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933476AbWKNSvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:51:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:48613 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933474AbWKNSvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:51:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=mC7zYyCo/kjbqwTH3oZoli9RcDS37zmvjzjCEtNscSTOA33SpJxf7EW4dfaBQBGTtvOn4Kg9MsidvwO10wZ9ckv7ubqhv4TgoW2iZpKGGTEcmNMqF27jnuYhTw1xV3CfoQhE25TJMsbSZWS6GbSYZ7+Oj5ViGdcbITmQZr1FmcI=
From: Christian Hoffmann <chrmhoffmann@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Tue, 14 Nov 2006 19:51:33 +0100
User-Agent: KMail/1.9.5
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611140008.55059.rjw@sisk.pl>
In-Reply-To: <200611140008.55059.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4798411.Y9qFbjklld";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611141951.38949.chrmhoffmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4798411.Y9qFbjklld
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 14 November 2006 00:08, Rafael J. Wysocki wrote:
> On Monday, 13 November 2006 23:08, Christian Hoffmann wrote:
> > > -----Original Message-----
> > > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > > Sent: Monday, November 13, 2006 3:06 PM
> > > To: Christian Hoffmann
> > > Cc: Pavel Machek; Benjamin Herrenschmidt; Andrew Morton;
> > > Solomon Peachy; linux-fbdev-devel@lists.sourceforge.net; LKML
> > > Subject: Re: Fwd: [Suspend-devel] resume not working on acer
> > > ferrari 4005 with radeonfb enabled
> > >
> > > On Monday, 13 November 2006 11:51, Christian Hoffmann wrote:
> > > > > -----Original Message-----
> > > > > From: Pavel Machek [mailto:pavel@ucw.cz]
> > > > > Sent: Sunday, November 12, 2006 1:14 PM
> > > > > To: Benjamin Herrenschmidt
> > > > > Cc: Christian Hoffmann; Andrew Morton; Solomon Peachy; Rafael J.
> > > > > Wysocki; linux-fbdev-devel@lists.sourceforge.net; LKML;
> > > > > Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl
> > > > > Subject: Re: Fwd: [Suspend-devel] resume not working on
> > >
> > > acer ferrari
> > >
> > > > > 4005 with radeonfb enabled
> > > > >
> > > > > Hi!
> > > > >
> > > > > > > Then the radeonfb doesn't kick in at all (guess some
> > >
> > > pci ids are
> > >
> > > > > > > added in that patch).
> > > > > > >
> > > > > > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > > > > >
> > > > > > In that case (vesafb), when does the screen come back
> > > > >
> > > > > precisely ? Do
> > > > >
> > > > > > you get console mode back and then X ? Or it only comes
> > >
> > > back when
> > >
> > > > > > going back to X ? Do you have some userland-type vbetool
> > > > >
> > > > > thingy that
> > > > >
> > > > > > bring it back ?
> > > > >
> > > > > He's using s3_bios+s3_mode, so kernel does some BIOS
> > >
> > > calls to reinit
> > >
> > > > > the video. It should come out in text mode, too.
> > > > >
> > > > > Christian, can you unload radeonfb before suspend/reload it after
> > > > > resume?
> > > >
> > > > Will it work if radeonfb is compiled as module? I think I
> > >
> > > had problems
> > >
> > > > with that, but I'll try again.
> > > >
> > > > > Next possibility is setting up serial console and adding some
> > > > > printks to radeon...
> > > >
> > > > Unfortunatly, the laptop doesn't have serial port. I tried to get a
> > > > USB device (pocketpc) read the USB serial, but I only partially
> > > > succeeded. I can pass console=ttyUSB0 to the kernel and
> > >
> > > load the ipaq
> > >
> > > > serial console driver as it oopses. I am able to echo strings to
> > > > /dev/ttyUSB0  and read them on the ipaq, but I am not able to
> > > > "deviate" the kernel messages to that port. Any hints on how to do
> > > > that would be very appreciated, I didn't find anything
> > >
> > > usefull on the
> > >
> > > > web. (I tried with setconsole /dev/ttyUSB0 but it gives error msg
> > > > about device busy or something)
> > >
> > > Would it be practicable to use netconsole on your box?  If
> > > so, it should work.
> >
> > I tried netconsole, and it somehow works, but when suspending it says in
> > an "infinite" loop:
> >
> > unregister_netdevice: waiting for eth2 to become free. Usage count = 1
>
> Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
>
> Rafael
No, I don't even have your patch installed that gives that option.

Chris

--nextPart4798411.Y9qFbjklld
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARVoQOtonrF4PGGDNAQIc6Q/9F/V1369/stWZWO6KtZ53avvjRkOBpjbV
gwmmTzhH/PMInElIWs8kXK5KsJ4WmAWvwIjLyHx+WwH6N6iaBAwNvCUkDkaOTVgC
SHNi7wbJJfU09WfgKOifetzYoOnWLic3j1CzQ5ZzGQkXdjT8t0CfqhiKviz04LKf
9Ria+Rq+zuQSGL3Wgz6zjtcI/0to5w3xTYcXiZSx/SxQOxn7+kYuXhcQA5zRpmL6
fmItFEhuHLvxBjG/AV5+qOKj1H+31iEJGPbBWVcU0OgI1x8g0+6jZod/DCI1E1Me
YmHUctwWLr/Bn1NyUItZH6d00eIxR7U5TBj6sH/Ndcgb98H5sbGkzKnKLZTLIVD6
1jCjXtFPp67kqLH4MCx88HcFTS34MMY0WHVSldRwdewbY9HWFP59hRpIRD2sxnry
l4OPuQCfdfHJevdKL3kZTn4psYNHBtsLcLvKLAZigu/i1dN+ywvE2tkHHE8LdemU
Pwc3UWIM2YNAbpiVhpe5lkDaQAbFcMFEAcoRved5IlfPG57tU3W8YybzzfhazhyQ
LT4nfrtuJR42hDobsY1vOyhZWTdm4gSP32DdKnhCs5uCJ3/WtKt92wPyQSdDn6dw
cY5azCP+7l8qzFbeDnz8pZhnQhTTz5vXtS9ZoIbD29xyF4cplohJMCPq7Jw5rJFh
vQXpOyo4Aqc=
=Zf1j
-----END PGP SIGNATURE-----

--nextPart4798411.Y9qFbjklld--
