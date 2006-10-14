Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWJNJdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWJNJdA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 05:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWJNJdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 05:33:00 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:44892 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1161086AbWJNJc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 05:32:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CACNMMEU
X-IronPort-AV: i="4.09,310,1157320800"; 
   d="scan'208"; a="4293934:sNHT35416460"
Date: Sat, 14 Oct 2006 11:32:55 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Jan Dittmer <jdi@l4x.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
Message-ID: <20061014093255.GA4646@zlug.org>
References: <20061010153745.GA27455@zlug.org> <452FD6F6.3090907@l4x.org> <20061013191744.GA30089@zlug.org> <20061013.150608.63128976.davem@davemloft.net> <45301CB3.4060803@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45301CB3.4060803@l4x.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 01:09:39AM +0200, Jan Dittmer wrote:
> David Miller wrote:
> > From: Joerg Roedel <joro-lkml@zlug.org>
> > Date: Fri, 13 Oct 2006 21:17:45 +0200
> > 
> >> On Fri, Oct 13, 2006 at 08:12:06PM +0200, Jan Dittmer wrote:
> >>> This is missing the MODULE_LICENSE statements and taints the kernel upon
> >>> loading. License is obvious from the beginning of the file.
> >  ...
> >>> Signed-off-by: Jan Dittmer <jdi@l4x.org>
> >> Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>
> > 
> > Applied, thanks for catching this Jan.
> > 
> 
> Btw. is there any way to autoload the sit module or is this the
> task of the distribution tools? Debian etch at least does not
> automatically probe the module when trying to bring up a 6to4 tunnel.

AFAIK there is no way to automatically load the driver from the kernel
space. The configuration of the tunnel devices requires the sit0 device.
But this device is installed by the sit driver. I mailed a bug report to
the Debian people and informed them about the change.

Joerg
