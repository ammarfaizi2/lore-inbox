Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVF2Xau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVF2Xau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVF2Xam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:30:42 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:37000 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262731AbVF2Xa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:30:29 -0400
Subject: Re: struct class question
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <42C328D5.7050602@adaptec.com>
References: <42C31268.8010606@adaptec.com>
	 <1120082466.5866.13.camel@mulgrave>  <42C328D5.7050602@adaptec.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 19:30:27 -0400
Message-Id: <1120087827.5866.20.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 19:03 -0400, Luben Tuikov wrote:
> > exist at all if we can't do anything with it, I suppose that depends on
> > whether it's necessary to the tree representation or not (a bit like
> > channels in SCSI.  They have meaning, but no sysfs representation on
> > their own).
> 
> Very good analogy.  In this respect I think we should represent
> phys, ports, and expanders just as the discover process sees them,
> in the same way, as you pointed out, channels are represented
> even though the do not quite exist (but are an abstraction).

Right, the question really is can we do anything with it, so targets
have properties (as do devices) but currently we have no channel
properties.

All SCSI devices have "ports" as defined by SAM; however, we don't show
them (well, except FC rports) because we don't use them for anything.

As far at least as SAS expanders go, I believe they do have properties
(the routing table etc.) which the driver can query, so they might be
worth adding a device for.

> Is this
> 
> /sys/class/scsi_host/host1
> 
> Or is it (e.g.),
> 
> /sys/devices/pci0000:00/0000:00:1f.2/host1

The latter (that's the devices tree under /sys/devices).

James


