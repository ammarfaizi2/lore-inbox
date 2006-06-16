Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWFQABF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWFQABF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 20:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWFQABF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 20:01:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:31394 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932481AbWFQABE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 20:01:04 -0400
Date: Fri, 16 Jun 2006 16:58:00 -0700
From: Greg KH <greg@kroah.com>
To: Daniele orlandi <daniele@orlandi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Passing references to kobjects between userland and kernel
Message-ID: <20060616235800.GA29573@kroah.com>
References: <200606141626.39273.daniele@orlandi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606141626.39273.daniele@orlandi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 04:26:38PM +0200, Daniele orlandi wrote:
> 
> Hello,
> 
> I'm trying to figure out what is the correct way to pass references to 
> kobjects between userland and kernel space.

Use the kobject_uevent() call from kernelspace to let userspace know
whatever you want it to.  That is what it is there for :)

> 
> I have my big object hierarchy of kobjects representing a TDM interconnect 
> graph with channels, crossconnectors, physical ports and so on.
> The main objects are nodes and archs; archs connect two nodes together.
> 
> The hierarchy is exported to sysfs.
> 
> From userland I want to tell the kernel "Connect node X to node Y".

Then use the names of the kobjects within your subdirectory.  They have
to be unique so you should be safe.

Or use configfs :)

thanks,

greg k-h
