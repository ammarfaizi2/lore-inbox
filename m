Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVFHQaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVFHQaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVFHQ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:28:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:19346 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261386AbVFHQ1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:27:22 -0400
Date: Wed, 8 Jun 2005 09:26:32 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com, ranty@debian.org
Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Message-ID: <20050608162632.GA1588@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3B6@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3B6@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 11:23:30AM -0500, Abhay_Salunke@Dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Wednesday, June 08, 2005 11:10 AM
> > To: Salunke, Abhay
> > Cc: dtor_core@ameritech.net; linux-kernel@vger.kernel.org;
> akpm@osdl.org;
> > Domsch, Matt; ranty@debian.org
> > Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to
> > support nohotplug
> > 
> > On Wed, Jun 08, 2005 at 11:04:09AM -0500, Abhay_Salunke@Dell.com
> wrote:
> > > > I think it would be better if you just have request_firmware and
> > > > request_firmware_nowait accept timeout parameter that would
> override
> > > > default timeout in firmware_class. 0 would mean use default,
> > > > MAX_SCHED_TIMEOUT - wait indefinitely.
> > >
> > > But we still need to avoid hotplug being invoked as we need it be a
> > > manual process.
> > 
> > No, hotplug can happen just fine (it happens loads of times today for
> > things that people don't care about.)
> > 
> If hotplug happens the complete function is called which makes the
> request_firmware return with a failure. 

If this was true, then the current code would not work at all.
