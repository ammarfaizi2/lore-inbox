Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVFIVLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVFIVLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVFIVLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:11:46 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:43675 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262468AbVFIVLX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:11:23 -0400
X-IronPort-AV: i="3.93,187,1115010000"; 
   d="scan'208"; a="252623957:sNHT77372772"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Date: Thu, 9 Jun 2005 16:11:08 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B0283F204@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Thread-Index: AcVsTHu6pXOc5sF6T2+92wDymh/IQgA6wHiA
From: <Abhay_Salunke@Dell.com>
To: <dtor_core@ameritech.net>, <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <Matt_Domsch@Dell.com>,
       <ranty@debian.org>
X-OriginalArrivalTime: 09 Jun 2005 21:11:19.0781 (UTC) FILETIME=[C81BA150:01C56D37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > On Wed, Jun 08, 2005 at 11:04:09AM -0500, Abhay_Salunke@Dell.com
> > > wrote:
> > > > > > I think it would be better if you just have request_firmware
and
> > > > > > request_firmware_nowait accept timeout parameter that would
> > > override
> > > > > > default timeout in firmware_class. 0 would mean use default,
> > > > > > MAX_SCHED_TIMEOUT - wait indefinitely.
> > > > >
> > > > > But we still need to avoid hotplug being invoked as we need it
be
> a
> > > > > manual process.
> > > >
> > > > No, hotplug can happen just fine (it happens loads of times
today
> for
> > > > things that people don't care about.)
> > > >
> > > If hotplug happens the complete function is called which makes the
> > > request_firmware return with a failure.
> >
> > If this was true, then the current code would not work at all.
> >
> 
> What Abhay is trying to say is that default firmware.agent when it
> does not find requested firmware file writes -1 (abort) to "loading"
> attribute causing firmware_request to fail.
> 
> I think it should be fixed in firmware.agent though, not in kernel -
> the agent shoudl just recognoze that sometimes not having firmware
> file is ok.
> 
Greg, any inputs on whether we change firmware.agent or we patch
firmware_class.c?

Thanks
Abhay
