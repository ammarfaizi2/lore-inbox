Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUFBStY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUFBStY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUFBStY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:49:24 -0400
Received: from eliassen.atmos.colostate.edu ([129.82.48.152]:40659 "EHLO
	eliassen.atmos.colostate.edu") by vger.kernel.org with ESMTP
	id S263820AbUFBSrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:47:37 -0400
Date: Wed, 2 Jun 2004 12:50:54 -0600 (MDT)
From: Saurabh Barve <sa@atmos.colostate.edu>
To: Arthur Perry <kernel@linuxfarms.com>
cc: Red Hat AMD64 Mailing List <amd64-list@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: GART Error 11
In-Reply-To: <Pine.LNX.4.58.0406021355210.14337@tiamat.perryconsulting.net>
Message-ID: <Pine.LNX.4.44.0406021249030.8448-100000@eliassen.atmos.colostate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arthur!

The machine seems to work except for the errors. Is there a way to update 
the drivers in the OS without having to upgrade the kernel. I guess we'll 
first have to find out which driver is misbehaving !!

I'll try the 'mce=off' and 'iommu=off' options again. I'll keep you 
posted.

Thanks again,
Saurabh.

On Wed, 2 Jun 2004, Arthur Perry wrote:

> Hi Saurabh,
> 
> Thanks. It looks like you also have true GART errors as reported by hardware, on CPU0.
> So our common failure mode here is actual GART errors and not something else being reported as a GART error because of erroneous kernel translation.
> 
> It's possible that we are using a device driver somewhere that is misbehaving, which is using the GART or IOMMU improperly somehow, or my guess is that is may be the actual AGP device driver used by RedHat.
> ie, they may have not patched in the most recent version that may contain a lot of fixes.
> 
> Thanks for your feedback.
> 
> As of making your messages go away, I would tell you to disable the GartTableWalk in MCE, but that does not seem to work on my machine.
> I'll let you know what does work without turning off Northbridge MC* entirely once I discover it.
> 
> -Arthur Perry
> 
> 
> 
> On Wed, 2 Jun 2004, Saurabh Barve wrote:
> 
> > Sorry about the delay in my reply. Just got in to work!
> > Here is the output:
> >
> > > pcitweak -r 0:18:3 0x48
> >
> > 0x0005001B
> >
> > > and
> > > pcitweak -r 0:19:3 0x48
> >
> > 0x00000000
> >
> > > While you are at it, can you send us status high as well?
> > >
> > > pcitweak -r 0:18:3 0x4c
> >
> > 0xA4000000
> >
> > > and
> > > pcitweak -r 0:19:3 0x4c
> >
> > 0x00000000
> >
> > I don't know if this would help, but below is a part of my cronwatch log:
> >
> > --------------------- Init Begin ------------------------
> >
> > **Unmatched Entries**
> > Trying to re-exec init
> > Trying to re-exec init
> >
> >  ---------------------- Init End -------------------------
> >
> >
> >  --------------------- Kernel Begin ------------------------
> >
> >
> > WARNING:  Kernel Errors Present
> >      uteval-0098: *** Error: Method executio...:  4Time(s)
> >     psparse-1121: *** Error: Method executio...:  8Time(s)
> >    Error uncorrected...:  538Time(s)
> >    GART error 11...:  538Time(s)
> >    Lost an northbridge error...:  538Time(s)
> >    NB error address 00000000...:  538Time(s)
> >
> >  ---------------------- Kernel End -------------------------
> >
> >
> >  --------------------- ModProbe Begin ------------------------
> >
> >
> > Can't locate these modules:
> >    char-major-10-134: 4 Time(s)
> >    sound-service-0-3: 6 Time(s)
> >    xp0: 3 Time(s)
> >    sound-slot-0: 6 Time(s)
> >    char-major-188: 15 Time(s)
> >
> >  ---------------------- ModProbe End -------------------------
> >
> >
> > Thanks,
> > Saurabh.
> >
> > --
> > ===============================================================================
> > Saurabh Barve                                        Phone:
> > System Administrator/Data Specialist                 970-491-7714 (voice)
> > Montgomery Research Group,                           970-491-8449 (Fax)
> > Atmospheric Sciences Department,
> > Fort Collins, Colorado
> > Colorado State University
> >
> > Mail : sa@atmos.colostate.edu
> > Web  : http://fjortoft.atmos.colostate.edu/~sa
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 

-- 
=============================================================================                                                                                
Saurabh Barve                                        Phone:
System Administrator/Data Specialist                 970-491-7714 (voice)
Montgomery Research Group,                           970-491-8449 (Fax)
Atmospheric Sciences Department,
Fort Collins, Colorado                             
Colorado State University                         

Mail : sa@atmos.colostate.edu
Web  : http://fjortoft.atmos.colostate.edu/~sa 

