Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTIPRVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTIPRVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:21:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36877 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262005AbTIPRVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:21:05 -0400
Date: Tue, 16 Sep 2003 18:20:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Ethernet cards
Message-ID: <20030916182059.D20141@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <1b7201c37a73$844b7030$2dee4ca5@DIAMONDLX60> <20030914091702.B20889@flint.arm.linux.org.uk> <20030916164941.GI3593@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030916164941.GI3593@kroah.com>; from greg@kroah.com on Tue, Sep 16, 2003 at 09:49:41AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 09:49:41AM -0700, Greg KH wrote:
> On Sun, Sep 14, 2003 at 09:17:02AM +0100, Russell King wrote:
> > On Sun, Sep 14, 2003 at 12:51:29PM +0900, Norman Diamond wrote:
> > > Shutdown messages appear on the text console as follows:
> > > [...]
> > > Shutting down PCMCIA unregister_netdevice: waiting for eth0 to become free.
> > > Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > > [...]
> > > 
> > > The only way to shut down at this point is to turn off the power.
> > 
> > IIRC the problem is your hotplug scripts.  Maybe the hotplug folk can tell
> > you the minimum version for 2.6.
> 
> The last release version is the best for 2.6, but this doesn't look
> like a hotplug script issue at all.

Hmm, ok.  However, in the past when people have upgraded their hotplug
scripts, the problem goes away.

Whatever, it's certainly not a PCMCIA issue either, so I'm at a loss what
to do about these reports.

I can only think that the right answer is to bat them all at the netdev
list, since it is a network device issue.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
