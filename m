Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVCQMAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVCQMAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVCQLvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:51:44 -0500
Received: from soundwarez.org ([217.160.171.123]:15302 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S263062AbVCQLH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 06:07:58 -0500
Subject: Re: [PATCH] add TIMEOUT to firmware_class hotplug event
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20050317054602.GA14459@kroah.com>
References: <20050317023431.GA27777@vrfy.org>
	 <20050317054602.GA14459@kroah.com>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 12:07:55 +0100
Message-Id: <1111057675.6675.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 (2.2.0-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 21:46 -0800, Greg KH wrote:
> On Thu, Mar 17, 2005 at 03:34:31AM +0100, Kay Sievers wrote:
> > On Tue, 2005-03-15 at 09:25 +0100, Hannes Reinecke wrote:
> > > The current implementation of the firmware class breaks a fundamental
> > > assumption in udevd: that the physical device can be initialised fully
> > > prior to executing the next event for that device.
> > 
> > Here we add a TIMEOUT value to the hotplug environment of the firmware
> > requesting event. I will adapt udevd not to wait for anything else, if
> > it finds a TIMEOUT key.
> 
> Can't you just trigger off of the FIRMWARE variable instead?

Sure, that will work too. I just thought it would be nice to give
userspace a hint about the event behavior the kernel expects, instead of
adding an exception to the udevd event management?

Thanks,
Kay

