Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVFHQ1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVFHQ1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVFHQ01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:26:27 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:15139 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261387AbVFHQXu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:23:50 -0400
X-IronPort-AV: i="3.93,183,1115010000"; 
   d="scan'208"; a="252052559:sNHT27477316"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Date: Wed, 8 Jun 2005 11:23:30 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3B6@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Thread-Index: AcVsRJGL2xenYmbbSiy9b3idMvAMrAAABd2g
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <dtor_core@ameritech.net>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>, <ranty@debian.org>
X-OriginalArrivalTime: 08 Jun 2005 16:23:43.0091 (UTC) FILETIME=[6FE7F430:01C56C46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, June 08, 2005 11:10 AM
> To: Salunke, Abhay
> Cc: dtor_core@ameritech.net; linux-kernel@vger.kernel.org;
akpm@osdl.org;
> Domsch, Matt; ranty@debian.org
> Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to
> support nohotplug
> 
> On Wed, Jun 08, 2005 at 11:04:09AM -0500, Abhay_Salunke@Dell.com
wrote:
> > > I think it would be better if you just have request_firmware and
> > > request_firmware_nowait accept timeout parameter that would
override
> > > default timeout in firmware_class. 0 would mean use default,
> > > MAX_SCHED_TIMEOUT - wait indefinitely.
> >
> > But we still need to avoid hotplug being invoked as we need it be a
> > manual process.
> 
> No, hotplug can happen just fine (it happens loads of times today for
> things that people don't care about.)
> 
If hotplug happens the complete function is called which makes the
request_firmware return with a failure. 

Abhay
