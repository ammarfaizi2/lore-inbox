Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbTBDToT>; Tue, 4 Feb 2003 14:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTBDToS>; Tue, 4 Feb 2003 14:44:18 -0500
Received: from fmr04.intel.com ([143.183.121.6]:14819 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267403AbTBDToR>; Tue, 4 Feb 2003 14:44:17 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A154@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: John Bradford <john@grabjohn.com>
Cc: ambx1@neo.rr.com, perex@perex.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk
Subject: RE: PnP model
Date: Tue, 4 Feb 2003 11:53:40 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: John Bradford [mailto:john@grabjohn.com] 
> > I think the people who want to manually configure their device's
> > resources need to step up and justify why this is really necessary.
> 
> Prototyping an embedded system, maybe, where you have devices in the
> test box that won't be in the production machine.  You would want them
> to use resources other than those that you want the hardware which
> will be present to use.

Ok fair enough. But I think the drivers should always think things are
handled in a PnP manner, even if they really aren't. ;-) For example,
between the stages where PnP enumerates the devices and the stage where
drivers get device_add notifications as a result of that, we will be
assigning the system resources to each device, but we could also
implement a way at this stage for people to manually alter things. I
think this is the right place to do this, as opposed to having all the
drivers implement code to probe for themselves.

Thoughts?

Regards -- Andy
