Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbRBLW4T>; Mon, 12 Feb 2001 17:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129233AbRBLW4J>; Mon, 12 Feb 2001 17:56:09 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:61847 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129231AbRBLWz7>; Mon, 12 Feb 2001 17:55:59 -0500
Date: Mon, 12 Feb 2001 22:55:21 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <3A884D72.E0F3D354@transmeta.com>
Message-ID: <Pine.SOL.4.21.0102122158510.22949-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, H. Peter Anvin wrote:
> James Sutherland wrote:
> > 
> My thinking at the moment is to require kernel IP configuration (either
> ip= or RARP/BOOTP/DHCP).  It seems to be the only practical way;
> otherwise you miss too much at the beginning.  However, that mechanism is
> already in place, and shouldn't be too hard to piggy-back on.

Yes: that should be easy enough, specially DHCP and ip=.

> > I'll do a server to receive these sessions - simple text (no vt100 etc),
> > one window per session - and work on the protocol spec. Anyone willing
> > to do the client end of things - lilo, grub, kernel, etc??
> 
> I'll do PXELINUX, for sure.  I'd prefer to do the protocol spec, if you
> don't mind -- having done PXELINUX I think I know the kinds of pitfalls
> that you run into doing an implementation in firmware or firmware-like
> programming (PXELINUX isn't firmware, but it might as well be.)

Fine by me: we seem to agree on the basic concept already, and there isn't
going to be very much protocol involved!

> Doing it in LILO would be extremely difficult, since LILO has no ability
> to handle networking, and no reasonable way to graft it on (you need a
> driver for networking.)  GRUB I can't really comment on.

I haven't seen much of GRUB, but it does seem to have DHCP support, so it
must have some facility for sending/receiving packets. LILO's command-line
approach would be better suited to this, really, though...

> I might just decide to do the kernel as well.
> 
> Hmmm... this sounds like it's turning into a group effort.  Would you (or
> someone else) like to set up a sourceforge project for this?  I would
> prefer not to have to deal with that end myself.

OK, I've filled in the paperwork - we should have a project account
sometime tomorrow. I put the license type as "Other", since the heart of
the project is the protocol, and patches to add support to the kernel,
FreeBSD etc. will have to be under the license of the OS in question.

Title: "Network Console Protocol" for now?


James.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
