Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWACRyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWACRyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWACRyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:54:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:18359 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932351AbWACRyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:54:24 -0500
Date: Tue, 3 Jan 2006 09:27:32 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
Message-ID: <20060103172732.GA9170@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com> <20051230080002.GA7438@kroah.com> <1135984304.13318.50.camel@serpentine.pathscale.com> <20051231001051.GB20314@kroah.com> <1135993250.13318.94.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135993250.13318.94.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 05:40:50PM -0800, Bryan O'Sullivan wrote:
> On Fri, 2005-12-30 at 16:10 -0800, Greg KH wrote:
> 
> > But we (the kernel community), don't really accept that as a valid
> > reason to accept this kind of code, sorry.
> 
> Fair enough.  I'd like some guidance in that case.  Some of our ioctls
> access the hardware more or less directly, while others do things like
> read or reset counters.
> 
> Which of these kinds of operations are appropriate to retain as ioctls,
> in your eyes, and which are best converted to sysfs or configfs
> alternatives?

Idealy, nothing should be new ioctls.  But in the end, it all depends on
exactly what you are trying to do with each different one.

> As an example, take a look at ipath_sma_ioctl.  It seems to me that
> receiving or sending subnet management packets ought to remain as
> ioctls, while getting port or node data could be turned into sysfs
> attributes.  Lane identification could live in configfs.  If you think
> otherwise, please let me know what's more appropriate.

I really don't know what the subnet management stuff involves, sorry.
But doesn't the open-ib layer handle that all for you already?

thanks,

greg k-h
