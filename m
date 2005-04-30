Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVD3OVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVD3OVA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 10:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVD3OU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 10:20:59 -0400
Received: from user-0c6slog.cable.mindspring.com ([24.110.87.16]:24450 "EHLO
	sleekfreak.ath.cx") by vger.kernel.org with ESMTP id S261230AbVD3OU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 10:20:26 -0400
Date: Sat, 30 Apr 2005 09:38:54 -0400 (EDT)
From: shogunx <shogunx@sleekfreak.ath.cx>
To: James.Smart@Emulex.Com
cc: alexdeucher@gmail.com, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: RE: Emulex fibre channel HBA support and SAN connection
In-Reply-To: <9BB4DECD4CFE6D43AA8EA8D768ED51C2062986@xbl3.ad.emulex.com>
Message-ID: <Pine.LNX.4.44.0504300936350.4175-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005 James.Smart@Emulex.Com wrote:

> Alex,
>
> We are looking into it further.  Linux on Sparc has not been a platform that we have supported in the past, although we know of no issue why it would not be.

Having some problems with the ip over fc on power64 also.

Scott


>
> -- James S
>
> > -----Original Message-----
> > From: Alex Deucher [mailto:alexdeucher@gmail.com]
> > Sent: Friday, April 29, 2005 6:42 PM
> > To: Smart, James
> > Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> > Subject: Re: Emulex fibre channel HBA support and SAN connection
> >
> >
> > FWIW, this seems to be a sparc64 issue.  after upgrading the firmware
> > and testing in a x86 box, all is well, at least on x86.  I'll test on
> > AMD64 next week.
> >
> > Alex
> >
> > On 4/29/05, Alex Deucher <alexdeucher@gmail.com> wrote:
> > > On 4/29/05, James.Smart@emulex.com <James.Smart@emulex.com> wrote:
> > > > Based on the "Unknown IOCB command data" message, this
> > appears to be out of date firmware on the adapter. See
> > http://www.emulex.com/ts/indexemu.html.  There are some hints
> > on downloading firmware at the tail end of
> > http://sourceforge.net/forum/forum.php?thread_id=1130082&forum
> > _id=355154.
> > > >
> > > > Note: lpfc issues are best posted to the help areas on
> > http://sourceforge.net/projects/lpfcxxxx/
> > >
> > > James,
> > >
> > >     I just upgraded to the latest firmware on the Emulex website
> > > (3.92a2) and I still get the same error:
> > > Emulex LightPulse Fibre Channel SCSI driver 8.0.28
> > > scsi2 :  on PCI bus 00 device 20 irq 8132864
> > > lpfc 0001:00:04.0: 0:1303 Link Up Event x1 received Data:
> > x1 xf7 x8 x0
> > > lpfc 0001:00:04.0: 0:0321 Unknown IOCB command Data: x0,
> > xa2 x0 x600 x2900
> > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> > > iotag x0 not found
> > > ...
> > > lpfc 0001:00:04.0: 0:0748 abort handler timed out waiting
> > for abort to
> > > complete. Data: x0 x0 x0 x1
> > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> > > iotag x700 not found
> > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> > > iotag x0 not found
> > >
> > > Any ideas?
> > >
> > > >
> > > > Thanks.
> > > >
> > > > -- James Smart
> > > >    Emulex
> > > >
> > > > > -----Original Message-----
> > > > > From: linux-scsi-owner@vger.kernel.org
> > > > > [mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of
> > Alex Deucher
> > > > > Sent: Thursday, April 28, 2005 6:03 PM
> > > > > To: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> > > > > Subject: Emulex fibre channel HBA support and SAN connection
> > > > >
> > > > >
> > > > > Can someone point me to some documentation on setting up a fibre
> > > > > channel HBA in linux?  I can't seem to find any useful
> > information.  I
> > > > > have a Sun 220R running 2.6.12-rc3 with an emulex
> > LP9000 HBA connected
> > > > > to a Nexsan ATABEAST SAN.  I'm using the HBA driver
> > included with the
> > > > > 2.6.12rc3 kernel.  I cannot find any information about the GPLed
> > > > > emulex driver as far as configuration goes.  The driver
> > seems to come
> > > > > up ok, but then I get a series of error codes:
> > > > >
> > > > > Emulex LightPulse Fibre Channel SCSI driver 8.0.28
> > > > > scsi0 :  on PCI bus 00 device 20 irq 8255744
> > > > > lpfc 0001:00:04.0: 0:1303 Link Up Event x1 received
> > Data: x1 x1 x8 x2
> > > > > lpfc 0001:00:04.0: 0:0321 Unknown IOCB command Data: x0, xa2
> > > > > x0 x900 x2600
> > > > > ...
> > > > > lpfc 0001:00:04.0: 0:0748 abort handler timed out
> > waiting for abort to
> > > > > complete. Data: x0 x0 x0 x1
> > > > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command
> > completion for
> > > > > iotag xa00 not found
> > > > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command
> > completion for
> > > > > iotag x0 not found
> > > > > lpfc 0001:00:04.0: 0:0713 SCSI layer issued LUN reset (0, 0)
> > > > > Data: x2 x0 x0
> > > > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command
> > completion for
> > > > > iotag xb00 not found
> > > > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command
> > completion for
> > > > > iotag x0 not found
> > > > > lpfc 0001:00:04.0: 0:0714 SCSI layer issued Bus Reset
> > Data: x2003
> > > > > scsi: Device offlined - not ready after error recovery:
> > host 0 channel
> > > > > 0 id 0 lun 0
> > > > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command
> > completion for
> > > > > iotag x0 not found
> > > > >
> > > > > I noticed here:
> > > > > http://marc.theaimsgroup.com/?l=linux-scsi&m=111383889908554&w=2
> > > > > that there is a new FC API. Was this merged into rc3 or
> > will this
> > > > > happen after 2.6.12?  If it's not supported yet in rc3,
> > how does one
> > > > > go about configuring it?  I'm willing to test any
> > available tools.
> > > > >
> > > > > Any help will be greatly appreciated.  I'll be able to
> > test on SPARC64
> > > > > right now and on AMD64 in the next few days.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Alex
> > > > >
> > > > > PS, please CC: me as I'm not subscribed.
> > >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

sleekfreak pirate broadcast
http://sleekfreak.ath.cx:81/

