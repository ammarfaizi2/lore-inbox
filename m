Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263383AbUJ2Scn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbUJ2Scn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUJ2S3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:29:23 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:32948 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263448AbUJ2SY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:24:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/4] Driver core: add driver_probe_device
Date: Fri, 29 Oct 2004 13:24:21 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
References: <200410062354.18885.dtor_core@ameritech.net> <200410120131.38330.dtor_core@ameritech.net> <20041029163714.GB27902@kroah.com>
In-Reply-To: <20041029163714.GB27902@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410291324.22084.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 October 2004 11:37 am, Greg KH wrote:
> On Tue, Oct 12, 2004 at 01:31:36AM -0500, Dmitry Torokhov wrote:
> > #### AUTHOR dtor_core@ameritech.net
> > #### COMMENT START
> > ### Comments for ChangeSet
> > Driver core: rename bus_match into driver_probe_device and export
> >              it so subsystems can bind an individual device to a
> >              specific driver without getting involved with driver
> >              core internals.
> 
> Applied, thanks.
> 

Greg,

What about "bind_mode" device and driver attributes? If you are not going
to apply them then I need to rework driver_probe_device to not call 
bus->match() function. The reason is that if bind_mode is not in the core
then I need to check these attributes in serio's bus match function, but
then I will not be able to use driver_probe_device to force binding when
user requests it. And if I don't check bind_mode in serio_bus_match then
I will have to do all driver/device mathing by hand which I wanted to
avoid in the first place.

Please let me know.

-- 
Dmitry
