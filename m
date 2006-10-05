Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWJEP75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWJEP75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWJEP75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:59:57 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:23194 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751651AbWJEP7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:59:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAKLIJEWMDg0
X-IronPort-AV: i="4.09,266,1157320800"; 
   d="scan'208"; a="3886993:sNHT30734488"
Date: Thu, 5 Oct 2006 17:59:53 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] net/ipv6: seperate sit driver to extra module
Message-ID: <20061005155953.GB2102@zlug.org>
References: <20061005154152.GA2102@zlug.org> <Pine.LNX.4.64.0610051148230.23631@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610051148230.23631@d.namei>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 11:49:38AM -0400, James Morris wrote:
> On Thu, 5 Oct 2006, Joerg Roedel wrote:
> 
> > Is there a reason why the tunnel driver for IPv6-in-IPv4 is currently
> > compiled into the ipv6 module? This driver is only needed in gateways
> > between different IPv6 networks. On all other hosts with ipv6 enabled it
> > is not required. To have this driver in a seperate module will save
> > memory on those machines.
> > I appended a small and trival patch to 2.6.18 which does exactly this.
> 
> Looks ok to me, although given that users used to get this by default when 
> selecting IPv6, perhaps the default in Kconfig should be y.

Ok, a good point to write y there. I change this. I wrote n there
because of the "If unsure, say N" sentence in the description.

Joerg
