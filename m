Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131414AbRCNPOP>; Wed, 14 Mar 2001 10:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRCNPOF>; Wed, 14 Mar 2001 10:14:05 -0500
Received: from think.faceprint.com ([166.90.149.11]:22534 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S131414AbRCNPNz>; Wed, 14 Mar 2001 10:13:55 -0500
Message-ID: <3AAF8A71.1C71D517@faceprint.com>
Date: Wed, 14 Mar 2001 10:12:49 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Balazic <david.balazic@uni-mb.si>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac20
In-Reply-To: <3AAE4DB6.8349ACBA@uni-mb.si> <3AAE7406.283D2411@faceprint.com> <3AAF3A56.C4EA2A95@uni-mb.si>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic wrote:
> 
> Nathan Walp wrote:
> >
> > David Balazic wrote:
> > >
> > > Nathan Walp (faceprint@faceprint.com) wrote :
> > >
> > > > Also, sometime between ac7 and ac18 (spring break kept me from testing
> > > > stuff inbetween), i assume during the new aic7xxx driver merge, the
> > > > order of detection got changed, and now the ide-scsi virtual host is
> > > > host0, and my 29160N is host1. Is this on purpose? It messed up a
> > > > bunch of my stuff as far as /dev and such are concerned.
> > >
> > > SCSI adapters are enumerated randomly(*) , relying on certain numbering
> > > will get you into trouble, sooner or later.
> > > There is no commonly accepted solution, AFAIK.
> > > The same thing can happent to disk enumeration ( sdb becomes sdc )
> > > or partition enumeration ( hda6 becomes hda5 ).
> > >
> > > * - theoreticaly no, but practicaly yes ( most of the time )
> > >
> > > --
> > > David Balazic
> > > --------------
> > > "Be excellent to each other." - Bill & Ted
> > > - - - - - - - - - - - - - - - - - - - - - -
> >
> > SCSI adapters are given host numbers in a random order?  Even with no
> > hardware changes?  Does this make less than sense to anyone else?  Every
> > kernel EVER up till now has had the real scsi cards (in some particular
> > order) then ide-scsi.  Have I just been lucky???
> >
> > Nathan
> 
> What I mean that too many factors are affecting the enumeration,
> so that you can not rely on it :
> 
> -  kernel changes
> -  driver changes ( partly overlaps with the previous poit )
> -  hardware changes
> -  something else ?
> 
> There is no policy for this enumeration ( AFAIK ) , so there is
> nothing to rely on , except luck :-)

See, that all makes sense.  You can't depend on hardware to detect in
the same order, whether it's SCSI cards, network cards, or anything
really.  But the software psuedo-device that is ide-scsi, shouldn't that
pick a spot before or after the hardware and stay there?  That's my
point, i guess.

Nathan
