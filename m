Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWJWSdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWJWSdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWJWSdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:33:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:13767 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965006AbWJWSdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:33:45 -0400
Date: Mon, 23 Oct 2006 11:32:51 -0700
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, olpc-dev@laptop.org, davidz@redhat.com,
       mjg59@srcf.ucam.org, len.brown@intel.com, sfr@canb.auug.org.au,
       benh@kernel.crashing.org
Subject: Re: Battery class driver.
Message-ID: <20061023183251.GB13804@kroah.com>
References: <1161627633.19446.387.camel@pmac.infradead.org> <20061023183048.GA13804@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023183048.GA13804@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 11:30:48AM -0700, Greg KH wrote:
> On Mon, Oct 23, 2006 at 07:20:33PM +0100, David Woodhouse wrote:
> > I'm half tempted to ditch the sysfs attributes and just use a single
> > seq_file, in fact.
> 
> Ick, no.  You should use the hwmon interface, and standardize on a
> proper battery api just like those developers have standardized on other
> sensor apis that are exported to userspace.  Take a look at
> Documentation/hwmon/sysfs-interface for an example of what it should
> look like.

Ok, nevermind, it looks like your code does do something much like this,
which is great.  Just make sure your units are the same as the other
hwmon drivers and everything should be fine.

thanks,

greg k-h
