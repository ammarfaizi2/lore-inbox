Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbRFBUHh>; Sat, 2 Jun 2001 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbRFBUH2>; Sat, 2 Jun 2001 16:07:28 -0400
Received: from mout0.freenet.de ([194.97.50.131]:29352 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S262684AbRFBUHP> convert rfc822-to-8bit;
	Sat, 2 Jun 2001 16:07:15 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: Chris Mason <mason@suse.com>
Subject: Re: [2.4.5 and all ac-Patches] massive file corruption with reiser or NFS
Date: Sat, 2 Jun 2001 22:02:14 +0200
X-Mailer: KMail [version 1.2]
Cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
In-Reply-To: <318710000.991506799@tiny>
In-Reply-To: <318710000.991506799@tiny>
MIME-Version: 1.0
Message-Id: <01060221380300.04158@athlon>
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by susi.maya.org id f52K2E900608
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag,  2. Juni 2001 20:33 schrieb Chris Mason:
> On Saturday, June 02, 2001 08:13:44 PM +0200 Andreas Hartmann
>
> <andihartmann@freenet.de> wrote:
> > Am Samstag,  2. Juni 2001 18:42 schrieben Sie:
> >> On Saturday, June 02, 2001 02:41:04 PM +0200 Andreas Hartmann
> >>
> >> >> <andihartmann@freenet.de> wrote:
> >> >
> >> > Am Samstag,  2. Juni 2001 12:52 schrieb Rasmus Bøg Hansen:
> >> >> On Sat, 2 Jun 2001, Andreas Hartmann wrote:
> >> >> > I got massive file corruptions with the kernels mentioned in the
> >> >> > subject. I can reproduce it every time.
> >> >> >
> >> >> > >> >> >> You cannot use NFS on reiserfs unless you apply the knfsd
> >> >> > >> >> >> patch.
> >> >> >>
> >> >> >> Look at
> >> >> >>
> >> >> >> >> www.namesys.com.
> >> >> >> >>
> >> >> >> > > Thank you very much for your advice.
> >> > >
> >> > > I tested your suggestion and run the machine without NFS-mounted
> >> > > devices
> >> > >
> >> > >> > - it  seems to be working fine. > > Anyway - I'm wondering why I
> >> > >> > didn't
> >> >
> >> > get any problem until 2.4.4ac10 with this  configuration without the
> >> > appropriate patch on the client or on the server?
> >> >
> >> >> The problem only happens when the clients do an operation on a file
> >> >> that
> >>
> >> has gone out of cache on the server.  Under light load, this might
> >> happen very rarely.
> >>
> > > The load didn't change. YOu can forget the load, it's very small. It's
> > > my
> >
> > private server and I'm doing always the same thing via NFS - compiling
> > e.g.  This has been working fine until 2.4.4.ac10, afterwards it has been
> > broken.
>
> Ok, there are two different problems here.  The patch you posted to l-k is
> a generic NFS fix for 2.4.5.  ext2 would need this too.
>
> If you are serving NFS from your reiserfs disk, you need an additional
> patch on the server only (this is the one I was talking about).  Checkout
> the FAQ on www.namesys.com for all the details.

Just for my understanding:
While I used 2.2.19 without patch on the server (it serves only reiser-based 
data) and 2.4.[1234]ac[...] on the client (without patch), it has been 
working because of the light load of the server.

Since 2.4.4ac11 something has been broken in the NFS for 2.4.5, so I ran into 
problems.

When this conclusion is right, the following combination should work for 
light load, as I usually have it:
unpatched 2.2.19 on the server (as it has been working with 2.2.4ac10) and 
NFS-patched 2.4.5. The test showed, that it is working.

The actual combination 2.4.5 on the server and on the client with the 
mentioned NFS-patch is the same situation as with the unpatched 2.2.19 on the 
server and the NFS-patch only on the 2.4.5-client.

I hope, that there will be soon a 2.4.5 knfsd-patch for my server, because 
this is the secure way! And I hope, the broken NFS on the client in the 
2.4.5-Kernels will be fixed soon - maybe in the next ac-patch?

Regards,
Andreas Hartmann
