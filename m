Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWETNrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWETNrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 09:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWETNrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 09:47:09 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:52631 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964854AbWETNrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 09:47:08 -0400
Subject: Re: dev_printk output
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Patrick Mansfield <patmans@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060520045544.GD2826@parisc-linux.org>
References: <20060511150015.GJ12272@parisc-linux.org>
	 <20060512170854.GA11215@us.ibm.com>
	 <20060513050059.GR12272@parisc-linux.org>
	 <20060518183652.GM1604@parisc-linux.org>
	 <20060518200957.GA29200@us.ibm.com>
	 <20060519201142.GB2826@parisc-linux.org> <20060519202847.GB8865@kroah.com>
	 <20060520045544.GD2826@parisc-linux.org>
Content-Type: text/plain
Date: Sat, 20 May 2006 08:46:57 -0500
Message-Id: <1148132817.3529.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 22:55 -0600, Matthew Wilcox wrote:
> Then we still get the inconsistency of device names changing as
> drivers
> are loaded.  I think we should declare it a bug for devices to not be
> on a bus.  The only example I have of devices not-on-a-bus are scsi
> targets.  I would propose introducing a new scsi_target bus for them,
> then removing the 'target' from the start of the bus_id.  Adding them
> to
> the scsi bus looks like it'd be a lot of work.

It's not just the target.  All the intermediate devices in transport
classes don't have busses either.   The only reason scsi_device has a
bus is so we can use the driver model to bind the ULDs.

James


