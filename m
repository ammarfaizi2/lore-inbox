Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbSISREk>; Thu, 19 Sep 2002 13:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271844AbSISREj>; Thu, 19 Sep 2002 13:04:39 -0400
Received: from packet.digeo.com ([12.110.80.53]:22680 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S271798AbSISREi> convert rfc822-to-8bit;
	Thu, 19 Sep 2002 13:04:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: CDCether.c
Date: Thu, 19 Sep 2002 10:09:37 -0700
Message-ID: <4C568C6A13479744AA1EA3E97EEEB3231B7DDF@schumi.digeo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CDCether.c
Thread-Index: AcJfpZ9qFs+31pCzRRih/4BTCKUyuQAR6ufgAARy+IA=
From: "Michael Duane" <Mike.Duane@digeo.com>
To: "Michael Duane" <Mike.Duane@digeo.com>,
       "Brad Hards" <bhards@bigpond.net.au>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have duplicated the problem with a stock Redhat 7.3
installation using a Toshiba PCX2200 cable modem connected
to standard PC hardware via USB


> -----Original Message-----
> From: Michael Duane 
> Sent: Thursday, September 19, 2002 8:23 AM
> To: Brad Hards; linux-kernel@vger.kernel.org
> Subject: RE: CDCether.c
> 
> 
> 
> 
> > -----Original Message-----
> > From: Brad Hards [mailto:bhards@bigpond.net.au]
> > Sent: Wednesday, September 18, 2002 11:21 PM
> > To: Michael Duane; linux-kernel@vger.kernel.org
> > Subject: Re: CDCether.c
> > 
> > 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On Thu, 19 Sep 2002 09:49, Michael Duane wrote:
> > > Who is the maintainer of CDCEther.c?  I am having a problem
> > > with packets getting "wedged" somewhere on the way out
> > > and need to know if others have reported this problem.
> > Others have reported probems that normally look something 
> > like "it works fine 
> > for some minutes to days, and then all connectivity stops, 
> > till I reboot or 
> > re-insert the module", but I can't duplicate. Does this match 
> > your problem?
> 
> No, this is quite different. It appears to be a function of packet 
> size. ping -s <size> <host> will generate packet loss up to 100 
> percent with any size of (86+(64*n)).  All other values work fine.
> tcpdump on the linux side sees multiple packet retries with 
> correct back-off timeing, but the network side never sees the
> packet. Now for the odd part - any network activity on another
> session to the same box will free the "wedged" packet and the
> network will recieve the last packet sent in the linux retry
> sequence.
> 
> I don't know that it is in the CDCEther driver, but here are the
> combinations I have tried:
> 
>     linux -> usb -> cdcether -> broadcom modem -> network : FAILS
>     linux -> usb -> pegasus -> linksys adaptor -> 3com DOCSIS 
> -> network : OKAY
>     windows -> usb -> broadcom driver -> broadcom modem -> 
> network : OKAY
> 
> > 
> > > I'm running the 2.4.17 kernel and using a Broadcom DOCSIS
> > > modem based around a 3345.
> > Most people have reported the problem with Via UHCI chipsets, 
> > and usb-uhci 
> > driver. Does this match your configuration?
> 
> I'm using usb-uhci with an Intel 810e2.  I have tried the 2.4.19
> kernel with the same results. This is a proprietary hardware platform
> and I haven't been able to get the 2.5.36 kernel to boot yet.
> 
> > 
> > You might care to upgrade the kernel too.
> > 
> > Brad
> > 
> > - -- 
> > http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. 
> > Birds in Black.
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.0.6 (GNU/Linux)
> > Comment: For info see http://www.gnupg.org
> > 
> > iD8DBQE9iWzJW6pHgIdAuOMRAvXrAJ9JfDSnx25dKI7yXvQC2XjNEydS+wCgpKMe
> > kSP0H8AB5Sj8Ebo6SGAPVNs=
> > =RTI4
> > -----END PGP SIGNATURE-----
> > 
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
