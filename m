Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTH2LQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264525AbTH2LQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:16:48 -0400
Received: from rth.ninka.net ([216.101.162.244]:40636 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264520AbTH2LQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:16:37 -0400
Date: Fri, 29 Aug 2003 04:16:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: arjanv@redhat.com
Cc: dhollis@davehollis.com, linux-kernel@vger.kernel.org
Subject: Re: We have ethtool_ops, any thoughts on miitool_ops?
Message-Id: <20030829041629.69a3be62.davem@redhat.com>
In-Reply-To: <1062147016.4999.0.camel@laptop.fenrus.com>
References: <3F4EB6F4.3010007@davehollis.com>
	<1062147016.4999.0.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003 10:50:17 +0200
Arjan van de Ven <arjanv@redhat.com> wrote:

> On Fri, 2003-08-29 at 04:14, David T Hollis wrote:
> > If a driver is converted to use ethtool_ops, it does not seem to have 
> > the ability to support mii-tool any longer.  RedHat uses mii-tool to 
> > check for link before running dhclient so that you don't have to wait 
> > forever for dhclient to timeout if the connection is down (laptops, 
> > etc). 
> 
> this is legacy; the road to the future for this is ethtool + the link
> status change notification stuff 

Besides, the original claim is false.  You can still support all
the other ioctls however you want, even the MII ones, after
enabling ethtool_ops in a driver.

