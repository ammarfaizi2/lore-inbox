Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131255AbRCNJcZ>; Wed, 14 Mar 2001 04:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRCNJcO>; Wed, 14 Mar 2001 04:32:14 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:36101 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131255AbRCNJcB>;
	Wed, 14 Mar 2001 04:32:01 -0500
Date: Wed, 14 Mar 2001 10:31:02 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux 2.4.2ac20
To: Nathan Walp <faceprint@faceprint.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3AAF3A56.C4EA2A95@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3AAE4DB6.8349ACBA@uni-mb.si> <3AAE7406.283D2411@faceprint.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Walp wrote:
> 
> David Balazic wrote:
> >
> > Nathan Walp (faceprint@faceprint.com) wrote :
> >
> > > Also, sometime between ac7 and ac18 (spring break kept me from testing
> > > stuff inbetween), i assume during the new aic7xxx driver merge, the
> > > order of detection got changed, and now the ide-scsi virtual host is
> > > host0, and my 29160N is host1. Is this on purpose? It messed up a
> > > bunch of my stuff as far as /dev and such are concerned.
> >
> > SCSI adapters are enumerated randomly(*) , relying on certain numbering
> > will get you into trouble, sooner or later.
> > There is no commonly accepted solution, AFAIK.
> > The same thing can happent to disk enumeration ( sdb becomes sdc )
> > or partition enumeration ( hda6 becomes hda5 ).
> >
> > * - theoreticaly no, but practicaly yes ( most of the time )
> >
> > --
> > David Balazic
> > --------------
> > "Be excellent to each other." - Bill & Ted
> > - - - - - - - - - - - - - - - - - - - - - -
> 
> SCSI adapters are given host numbers in a random order?  Even with no
> hardware changes?  Does this make less than sense to anyone else?  Every
> kernel EVER up till now has had the real scsi cards (in some particular
> order) then ide-scsi.  Have I just been lucky???
> 
> Nathan

What I mean that too many factors are affecting the enumeration,
so that you can not rely on it :

-  kernel changes
-  driver changes ( partly overlaps with the previous poit )
-  hardware changes
-  something else ?

There is no policy for this enumeration ( AFAIK ) , so there is
nothing to rely on , except luck :-)

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
