Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317135AbSEXPHw>; Fri, 24 May 2002 11:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317136AbSEXPHv>; Fri, 24 May 2002 11:07:51 -0400
Received: from pop.gmx.de ([213.165.64.20]:15471 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317135AbSEXPHu>;
	Fri, 24 May 2002 11:07:50 -0400
Message-ID: <3CEE4937.7C4E37AB@gmx.net>
Date: Fri, 24 May 2002 16:07:51 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers
In-Reply-To: <Pine.LNX.4.44.0205230746500.1824-100000@router-273.sgowdy.org> <3CECFBEE.9010802@evision-ventures.com> <20020523160410.GC11153@kroah.com> <3CED2CF5.5050202@evision-ventures.com> <3CEDF811.9020801@loewe-komp.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:

> Martin Dalecki wrote:
> > Uz.ytkownik Greg KH napisa?:
> >
> >> Anyway, here's the documentation that you need:
> >>     The module usb-ohci is now gone.  Use ohci-hcd instead.
> >>
> >> The people with UHCI controllers have a big more documentation to read:
> >>     The module uhci is now gone.  If you used this module, use
> >>     uhci-hcd instead.  The module usb-uhci is now gone.  If you used
> >>     this module, use usb-uhci-hcd instead.  If you have a preference
> >>     over which UHCI module works better for you, please email
> >>     greg@kroah.com your comments, as one of these modules will be
> >>     going away in the near future.
> >
> >
> > Thank's that is explaining it.
> > But I would have loved it if it appeared with + in front in
> > the patch somewhere. That's the only true problem I had.
> > OK?
> >
> > BTW.> usb-ohci seems to be a more reasonable name, since
> > it tells me directly - hey buddy I'm USB the -hcd doen't
> > tell me anything in addition and is entierly redundant, or
> > is there a ohci.o module there?
> >
> > And why not just doing the following.
> >
> > 1. Rename usb-ohci to usb-ohci-old
> >
> > 2. Rename ohci-hcd to usb-ohci
> >
> > Much less grief and guessing what happens :-).

Second this (in fact "first this").
Elegant solution which would not only habe prevented this thread
but help developers and users no end.

>
> >
> > Just a suggestion.
> >
>
> You do not understand the _cause_ for the rename.

Martin and me understand what hcd means, and we think
it is non-untuitive and user-hostile.


>
>
> hcd stands for Host Controller Device. The names mark them as that.
> Now you can argue, that all the SCSI controller modules do not have
> HBC (host bus controller) in their name - and then look at the
> different naming of the other scsi modules:
>
> scsi_mod.o  sd_mod.o  sg.o  sr_mod.o  st.o
>
> Also not very intuitiv. We could put them in different subdirs...

Obviously you cannot balance between intuitive and user-friendly.

