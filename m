Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTJJU1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTJJU1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:27:43 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:5760 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S262824AbTJJU1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:27:41 -0400
Date: Fri, 10 Oct 2003 22:27:39 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Wireless Network Maintainer?
Message-ID: <20031010202739.GB1761@hout.vanvergehaald.nl>
References: <20031010005548.GA3573@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010005548.GA3573@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 05:55:48PM -0700, Jean Tourrilhes wrote:
> Nico Schottelius wrote :
> > 
> >   - device naming scheme should be wlanX -> easier to see what it is
> 
> There are pros and cons to that. Personally I prefer the approach
> taken by the aironet driver (ethX + wifiX). The interface the
> driver present to the kernel is *really* an Ethernet interface.
> If you really want easy identification, we could take the *BSD
> approach where every driver use it's own unique device name.

Please don't do that. Leave it as it is.
If somebody is not happy with the ethX names, use the nameif utility
to change them into more descriptive names. I've successfully done that
on my firewall machine. It looks like this:

# ifconfig -a|grep "Link encap"|awk '{print $1}'
dmz
lo
loc
net

The nameif utility also is the right tool to link a device name
to an ethernet hardware (MAC) address, so you'll never run into
surprises again. Check out my cute little table:

# cat /etc/mactab
loc 00:40:F4:47:EA:65
dmz 00:40:F4:47:EA:64
net 00:40:F4:47:EA:63

And hey, it's all done in userspace, the holy grail!  :-)

Regards,
Toon.
