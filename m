Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbUKYDky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbUKYDky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 22:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUKYDky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 22:40:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:10141 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262957AbUKYDkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 22:40:02 -0500
Date: Wed, 24 Nov 2004 19:39:31 -0800
From: Greg KH <greg@kroah.com>
To: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] - Externel SLIT table information thru sysfs
Message-ID: <20041125033931.GA25561@kroah.com>
References: <20041124165724.GA14544@sgi.com> <41A53D93.5070005@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A53D93.5070005@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 06:04:03PM -0800, Randy.Dunlap wrote:
> Jack Steiner wrote:
> >The ACPI SLIT table provides useful information on internode distances.
> >Here is a patch to externalize the SLIT information. 
> >
> >For example:
> >
> >        # cd /sys/devices/system
> >        # find .
> >        ./node
> >        ./node/node5
> >        ./node/node5/distance
> >        ./node/node5/numastat
> >        ./node/node5/meminfo
> >        ./node/node5/cpumap
> >
> >        # cat ./node/node0/distance
> >        10 20 64 42 42 22

Care to turn this into a one value per file implementation instead of
this?  That will make it easier to determine exactly what the data in
each file is, and follow the sysfs rules.

thanks,

greg k-h
