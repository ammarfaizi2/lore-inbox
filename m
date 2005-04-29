Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbVD2WmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbVD2WmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbVD2WmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:42:23 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:5071 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263036AbVD2Wlq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:41:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kEXw9FaiSdD7v1wzuH9aQAA/GBnYLXRvzapr7vnv9gxo25Yi/ddqFSfOrN3ki0HZxDzR3LN3YJaaU+NZAXnlRJ+9QCcIaKuTW7nmTfVyCFn39508ws2akgMjEuIcFI+1NyVy0tJO0gMp4U3pyBsKxjP8hAkq3AyYtps1lGI2wGY=
Message-ID: <a728f9f9050429154158fa2718@mail.gmail.com>
Date: Fri, 29 Apr 2005 18:41:44 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: "James.Smart@emulex.com" <James.Smart@emulex.com>
Subject: Re: Emulex fibre channel HBA support and SAN connection
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <a728f9f90504291311178728bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201ABC8@xbl3.ad.emulex.com>
	 <a728f9f90504291311178728bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, this seems to be a sparc64 issue.  after upgrading the firmware
and testing in a x86 box, all is well, at least on x86.  I'll test on
AMD64 next week.

Alex

On 4/29/05, Alex Deucher <alexdeucher@gmail.com> wrote:
> On 4/29/05, James.Smart@emulex.com <James.Smart@emulex.com> wrote:
> > Based on the "Unknown IOCB command data" message, this appears to be out of date firmware on the adapter. See http://www.emulex.com/ts/indexemu.html.  There are some hints on downloading firmware at the tail end of  http://sourceforge.net/forum/forum.php?thread_id=1130082&forum_id=355154.
> >
> > Note: lpfc issues are best posted to the help areas on http://sourceforge.net/projects/lpfcxxxx/
> 
> James,
> 
>     I just upgraded to the latest firmware on the Emulex website
> (3.92a2) and I still get the same error:
> Emulex LightPulse Fibre Channel SCSI driver 8.0.28
> scsi2 :  on PCI bus 00 device 20 irq 8132864
> lpfc 0001:00:04.0: 0:1303 Link Up Event x1 received Data: x1 xf7 x8 x0
> lpfc 0001:00:04.0: 0:0321 Unknown IOCB command Data: x0, xa2 x0 x600 x2900
> lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> iotag x0 not found
> ...
> lpfc 0001:00:04.0: 0:0748 abort handler timed out waiting for abort to
> complete. Data: x0 x0 x0 x1
> lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> iotag x700 not found
> lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> iotag x0 not found
> 
> Any ideas?
> 
> >
> > Thanks.
> >
> > -- James Smart
> >    Emulex
> >
> > > -----Original Message-----
> > > From: linux-scsi-owner@vger.kernel.org
> > > [mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of Alex Deucher
> > > Sent: Thursday, April 28, 2005 6:03 PM
> > > To: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> > > Subject: Emulex fibre channel HBA support and SAN connection
> > >
> > >
> > > Can someone point me to some documentation on setting up a fibre
> > > channel HBA in linux?  I can't seem to find any useful information.  I
> > > have a Sun 220R running 2.6.12-rc3 with an emulex LP9000 HBA connected
> > > to a Nexsan ATABEAST SAN.  I'm using the HBA driver included with the
> > > 2.6.12rc3 kernel.  I cannot find any information about the GPLed
> > > emulex driver as far as configuration goes.  The driver seems to come
> > > up ok, but then I get a series of error codes:
> > >
> > > Emulex LightPulse Fibre Channel SCSI driver 8.0.28
> > > scsi0 :  on PCI bus 00 device 20 irq 8255744
> > > lpfc 0001:00:04.0: 0:1303 Link Up Event x1 received Data: x1 x1 x8 x2
> > > lpfc 0001:00:04.0: 0:0321 Unknown IOCB command Data: x0, xa2
> > > x0 x900 x2600
> > > ...
> > > lpfc 0001:00:04.0: 0:0748 abort handler timed out waiting for abort to
> > > complete. Data: x0 x0 x0 x1
> > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> > > iotag xa00 not found
> > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> > > iotag x0 not found
> > > lpfc 0001:00:04.0: 0:0713 SCSI layer issued LUN reset (0, 0)
> > > Data: x2 x0 x0
> > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> > > iotag xb00 not found
> > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> > > iotag x0 not found
> > > lpfc 0001:00:04.0: 0:0714 SCSI layer issued Bus Reset Data: x2003
> > > scsi: Device offlined - not ready after error recovery: host 0 channel
> > > 0 id 0 lun 0
> > > lpfc 0001:00:04.0: 0:0327 Rsp ring 0 error -  command completion for
> > > iotag x0 not found
> > >
> > > I noticed here:
> > > http://marc.theaimsgroup.com/?l=linux-scsi&m=111383889908554&w=2
> > > that there is a new FC API. Was this merged into rc3 or will this
> > > happen after 2.6.12?  If it's not supported yet in rc3, how does one
> > > go about configuring it?  I'm willing to test any available tools.
> > >
> > > Any help will be greatly appreciated.  I'll be able to test on SPARC64
> > > right now and on AMD64 in the next few days.
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > > PS, please CC: me as I'm not subscribed.
>
