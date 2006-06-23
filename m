Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751901AbWFWSg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWFWSg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbWFWSg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:36:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28035 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751901AbWFWSg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:36:28 -0400
Date: Fri, 23 Jun 2006 11:33:16 -0700
From: Greg KH <gregkh@suse.de>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Fault tolerance/bad patch, [was Re: [PATCH 29/30] [PATCH] PCI Hotplug: fake NULL pointer dereferences in IBM Hot Plug Controller Driver]
Message-ID: <20060623183316.GA4529@suse.de>
References: <115075348565-git-send-email-greg@kroah.com> <11507534883521-git-send-email-greg@kroah.com> <11507534914002-git-send-email-greg@kroah.com> <11507534953044-git-send-email-greg@kroah.com> <11507534983982-git-send-email-greg@kroah.com> <11507535021937-git-send-email-greg@kroah.com> <11507535054091-git-send-email-greg@kroah.com> <11507535082418-git-send-email-greg@kroah.com> <11507535123764-git-send-email-greg@kroah.com> <20060623150442.GK8866@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623150442.GK8866@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 10:04:43AM -0500, Linas Vepstas wrote:
> Hi,
> 
> On Mon, Jun 19, 2006 at 02:43:35PM -0700, Greg KH wrote:
> > From: Eric Sesterhenn <snakebyte@gmx.de>
> > 
> > Remove checks for value, since the hotplug core always provides
> > a valid value.
> > 
> > -	if (hotplug_slot && value) {
> > +	if (hotplug_slot) {
> 
> This may be the wrong place to bring up a philosphical issue,

You are right, it is the wrong place for it, please take stuff like this
elsewhere.

value can not be a null value here, it's an impossiblity as that is how
this interface works.

thanks,

greg k-h
