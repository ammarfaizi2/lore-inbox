Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbRETCXr>; Sat, 19 May 2001 22:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbRETCXh>; Sat, 19 May 2001 22:23:37 -0400
Received: from lpce017.lss.emc.com ([168.159.62.17]:19972 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261375AbRETCXZ>; Sat, 19 May 2001 22:23:25 -0400
Date: Sat, 19 May 2001 22:22:55 -0400
Message-Id: <200105200222.f4K2Mto02608@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <20010520031807.G23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu>
	<E1517Jf-0008PV-00@the-village.bc.nu>
	<200105191851.f4JIpNK00364@mobilix.ras.ucalgary.ca>
	<20010520031807.G23718@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
> On Sat, May 19, 2001 at 12:51:23PM -0600, Richard Gooch wrote:
> > Al, if you really want to kill ioctl(2), then perhaps you should
> > implement a transaction(2) syscall. Something like:
> >     int transaction (int fd, void *rbuf, size_t rlen,
> > 		     void *wbuf, size_t wlen);
> > 
> > Of course, there wouldn't be any practical gain, since we already have
> > ioctl(2). Any gain would be aesthetic.
> 
> I can tell you haven't had to write any 32-bit ioctl emulation code for
> a 64-bit kernel recently.

The transaction(2) syscall can be just as easily abused as ioctl(2) in
this respect. People can pass pointers to ill-designed structures very
easily. The main advantage of transaction(2) is that hopefully, people
will not be so bone-headed as to forget to pass sizeof *structptr
as the size field. So perhaps some error trapping is possible.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
