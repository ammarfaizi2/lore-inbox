Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVAMXrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVAMXrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVAMXns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:43:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:702 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261810AbVAMXlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:41:32 -0500
Date: Thu, 13 Jan 2005 15:41:28 -0800
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] release_pcibus_dev() crash
Message-ID: <20050113234128.GA2847@kroah.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com> <1105638551.30960.16.camel@sinatra.austin.ibm.com> <20050113181850.GA24952@kroah.com> <200501131021.19434.jbarnes@engr.sgi.com> <20050113183729.GA25049@kroah.com> <1105647135.30960.22.camel@sinatra.austin.ibm.com> <20050113202532.GA30780@kroah.com> <1105649679.30960.27.camel@sinatra.austin.ibm.com> <20050113210501.GA31402@kroah.com> <1105651078.30960.33.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105651078.30960.33.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 03:17:58PM -0600, John Rose wrote:
> > Closer (you forgot a changelog entry too...)
> 
> Just to be a brat, I'll point out that I couldn't find a single user of
> CLASS_DEVICE_ATTR that explicitly cleans things up like we're doing here.  That
> would include firmware and net-sysfs stuff.  Maybe enforcing such a policy upon
> device removal would increase participation :)  But okay, here's another try:

Yeah, I know everyone doesn't do it, but I'm trying to get them all to,
and when I have a chance to point it out and fix it, I am.  Just like
now, thanks for putting up with me :)

> During the course of a hotplug removal of a PCI bus, release_pcibus_dev()
> attempts to remove attribute files from a kobject directory that no longer
> exists.  This patch moves these calls to pci_remove_bus(), where they can work
> as intended.
> 
> Signed-off-by: John Rose <johnrose@austin.ibm.com>

Looks good, applied, thanks.

greg k-h
