Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWB0TLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWB0TLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWB0TLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:11:08 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:30114
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751734AbWB0TLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:11:07 -0500
Date: Mon, 27 Feb 2006 11:11:08 -0800
From: Greg KH <gregkh@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227191108.GA9221@suse.de>
References: <20060227190150.GA9121@kroah.com> <1141067298.2992.154.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141067298.2992.154.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 08:08:18PM +0100, Arjan van de Ven wrote:
> On Mon, 2006-02-27 at 11:01 -0800, Greg KH wrote:
> > Hi all,
> > 
> > As has been noticed recently by a lot of different people, it seems like
> > we are breaking the userspace<->kernelspace interface a lot.  Well, in
> > looking back over time, we always have been doing this, but no one seems
> > to notice (proc files changing format and location, netlink library
> > bindings, etc.)
> 
> 
> 2 remarks
> 
> 1) it would make sense to keep track of "removed" interfaces as well

Good idea, removed/ should be where things go to after obsolete so
people can find things in the future.

> 2) the per interface description needs a "depends on config option"
> field; not all options are always there, but depend on a config option
> to be set. It makes a lot of sense to mark these as such so that users
> KNOW they have to deal with the interface not being there occasionally,
> depending on the kernel.

Hm, almost _everything_ is configurable these days, including sysfs.  Do
we really want to keep the config value in sync with the kernel config
system too?  I can add it, but it seems a bit unnecessary.

thanks for the quick feedback.

greg k-h
