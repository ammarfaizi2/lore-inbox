Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbQLMUum>; Wed, 13 Dec 2000 15:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbQLMUub>; Wed, 13 Dec 2000 15:50:31 -0500
Received: from ra.lineo.com ([204.246.147.10]:8902 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S130113AbQLMUuX>;
	Wed, 13 Dec 2000 15:50:23 -0500
Message-ID: <3A37D9F2.6FB11D82@Rikers.org>
Date: Wed, 13 Dec 2000 13:20:02 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: alex@foogod.com
CC: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] I-Opener fix (again)
In-Reply-To: <20001211152331.M10618@draco.foogod.com> <Pine.LNX.4.10.10012122217440.4894-100000@master.linux-ide.org> <20001213114046.B19902@draco.foogod.com>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 12/13/2000
 01:19:57 PM,
	Serialize complete at 12/13/2000 01:19:57 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

What are the "laptops that have CFA devices that do not come on channels
in a pair" systems you refer to?

This patch fixes the iopener and other systems here at Lineo that have
2nd drive flash. The only other way we have been booting these is with
"hdb=noprobe" which just disables the 2nd drive flash. hdb=flash does
not fix it.

alex@foogod.com wrote:
> 
> On Tue, Dec 12, 2000 at 10:47:35PM -0800, Andre Hedrick wrote:
> >
> > Basically if the setting of
> >
> >  * "hdx=flash"          : allows for more than one ata_flash disk to be
> >  *                              registered. In most cases, only one device
> >  *                              will be present.
> >
> > fails then I will look into this but, the breaking of laptops that have
> > CFA devices that do not come on channels in a pair canb not happen.
> > If you have a vender unique setting that will follow always the way
> > I-Opener's are setup then that is better.
> 
> Ok, there are two things here:
> 
> 1) "hdx=flash" _does_ fail, because the flash-related code clobbers hda
>    _after_ hda's detection phase, when it's looking at hdb (which is flash).
> 
> 2) I can see no situation where hdb detection should ever override the
>    _already_performed_ detection of hda in this way.
> 
> Basically, as is, the kernel finds hda (traditional IDE device), configures it
> normally, then finds hdb (flash), and clobbers all the correct info it already
> detected for hda.  This seems just plain wrong.
> 
> -alex
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
