Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUAMANj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUAMANj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:13:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:65426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263062AbUAMANi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:13:38 -0500
Date: Mon, 12 Jan 2004 16:13:36 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restrict class names to valid file names
Message-Id: <20040112161336.3e147996.shemminger@osdl.org>
In-Reply-To: <20040113000514.GA4848@kroah.com>
References: <20040112151357.5c9702b7.shemminger@osdl.org>
	<20040113000514.GA4848@kroah.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004 16:05:14 -0800
Greg KH <greg@kroah.com> wrote:

> On Mon, Jan 12, 2004 at 03:13:57PM -0800, Stephen Hemminger wrote:
> > It is possible to name network devices with names like "my/bogus" or "." or ".."
> > which leaves /sys/class/net/ a mess.  Since other subsystems could have the same
> > problem, it made sense to me to enforce some restrictions in the class device
> > layer.
> > 
> > A lateer patch fixes the network device registration path because the
> > sysfs registration takes place after the register_netdevice call has taken place.
> 
> Heh, so you will have already "scrubbed" the name before you submit it
> to the driver core?  If so, why add this patch?

Because name won't be scrubbed for the rename case, and other class devices
probably have the same possible problem
