Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTKTCy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTKTCyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:54:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264269AbTKTCyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:54:24 -0500
Date: Thu, 20 Nov 2003 02:54:23 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] 2.6.x experimental net driver updates
Message-ID: <20031120025423.GB24159@parcelfarce.linux.theplanet.co.uk>
References: <3FBBA954.6000601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBBA954.6000601@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 12:33:08PM -0500, Jeff Garzik wrote:
> Ok, Al Viro's net driver refcounting work is pretty much complete, and 

The hell it is.  We are through with legacy probes, we are through with
init_etherdev(), we are practically through with static struct net_device.

However, we still have weird allocators (I've got almost all of them
done by now, will submit in the next batch) and we still have struct
net_device embedded as a field of other structures in several drivers.

It's nowhere near as massive as legacy probes series, but it's going to
be 10--20 patches.  At least.
