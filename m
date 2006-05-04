Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWEDP2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWEDP2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWEDP2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:28:34 -0400
Received: from mail0.lsil.com ([147.145.40.20]:16637 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751499AbWEDP2d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:28:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] MegaRAID driver management char device moved to misc
Date: Thu, 4 May 2006 09:28:16 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD30@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] MegaRAID driver management char device moved to misc
Thread-Index: AcZvf/H00quuXZOKSn+vbM4KCav/tQAAxWVwAALv53A=
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Ju, Seokmann" <Seokmann.Ju@engenio.com>,
       "Thomas Horsten" <thomas@horsten.com>, <thomas.horsten@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, "Kolli, Neela" <Neela.Kolli@engenio.co>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 04 May 2006 15:28:16.0928 (UTC) FILETIME=[5DAD4200:01C66F8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > > So it now uses a misc device which I named "megadev0" (the
> > > > name that megarc
> > > > expects), and has a dynamic minor (previoulsy a dynamic major
> > > > was used).
> > > The driver can not change device node name for backward 
> > compatibility.
> > > I'm checking with application team inside for further 
> > clarification and update here.
> > 
> > That is an invalid reason: There was no hardcoded device node 
> > previously
> > (it was using a dynamically assigned major).
> You're right.
> I misunderstood the whole idea of creating device node.
> Besides this, I don't have any objection.
> I would accept the patch based on descriptoin in flowing link.
> http://www.us.kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs
I need take back previous comment for accepting the patch.
There are several applications that is running with the driver.
And those applications are need to be verified with this patch before merge it to up-stream.
I'm sorry for creating confusion, today.

I'll update my final comment on the patch once all necessary verifications have done.

Thank you, 

> -----Original Message-----
> From: Ju, Seokmann 
> Sent: Thursday, May 04, 2006 10:05 AM
> To: 'Thomas Horsten'
> Cc: linux-kernel@vger.kernel.org; Kolli, Neela; 
> linux-scsi@vger.kernel.org
> Subject: RE: [PATCH] MegaRAID driver management char device 
> moved to misc
> 
> Hi, 
> > > > So it now uses a misc device which I named "megadev0" (the
> > > > name that megarc
> > > > expects), and has a dynamic minor (previoulsy a dynamic major
> > > > was used).
> > > The driver can not change device node name for backward 
> > compatibility.
> > > I'm checking with application team inside for further 
> > clarification and update here.
> > 
> > That is an invalid reason: There was no hardcoded device node 
> > previously
> > (it was using a dynamically assigned major).
> You're right.
> I misunderstood the whole idea of creating device node.
> Besides this, I don't have any objection.
> I would accept the patch based on descriptoin in flowing link.
> http://www.us.kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs
> 
> Any other comment would be appreciated.
> 
> Thank you,
> 
> > -----Original Message-----
> > From: Thomas Horsten [mailto:thomas@horsten.com] 
> > Sent: Thursday, May 04, 2006 9:38 AM
> > To: Ju, Seokmann
> > Cc: linux-kernel@vger.kernel.org; Kolli, Neela; 
> > linux-scsi@vger.kernel.org
> > Subject: RE: [PATCH] MegaRAID driver management char device 
> > moved to misc
> > 
> > On Thu, 4 May 2006, Ju, Seokmann wrote:
> > 
> > > Hi,
> > >
> > > For following reason, I cannot accept/approve this patch.
> > > I'll update further as I get clear.
> > >
> > > Thank you,
> > >
> > > > So it now uses a misc device which I named "megadev0" (the
> > > > name that megarc
> > > > expects), and has a dynamic minor (previoulsy a dynamic major
> > > > was used).
> > > The driver can not change device node name for backward 
> > compatibility.
> > > I'm checking with application team inside for further 
> > clarification and update here.
> > 
> > That is an invalid reason: There was no hardcoded device node 
> > previously
> > (it was using a dynamically assigned major).
> > 
> > The only tool I know which uses this device is "megarc" from 
> > LSI Logic.
> > This tool uses the char device /dev/megaraid0, which will be created
> > correctly when using my patch and udev (the recommended setup 
> > for Linux
> > 2.6 systems). I have tested this and it works.
> > 
> > User-level applications should not rely on hardcoded device 
> > numbers in any
> > case, but should use the correct device from /dev or search 
> > for the device
> > they need in sysfs.
> > 
> > Thomas
> > 
> > 
