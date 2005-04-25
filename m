Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVDYTf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVDYTf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVDYTf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:35:26 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:39814 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261530AbVDYTcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:32:46 -0400
Date: Mon, 25 Apr 2005 23:32:10 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, sensors@stimpy.netroedge.com,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-ID: <20050425233210.0517300b@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d50005042509366e5a0895@mail.gmail.com>
References: <200504210207.02421.dtor_core@ameritech.net>
	<1114089504.29655.93.camel@uganda>
	<d120d5000504210909f0e0713@mail.gmail.com>
	<1114420290.8527.56.camel@uganda>
	<d120d50005042509366e5a0895@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Mon, 25 Apr 2005 23:32:23 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005 11:36:05 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Thu, 2005-04-21 at 11:09 -0500, Dmitry Torokhov wrote:
> > > One more thing...
> > >
> > > On 4/21/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> > > >
> > > > > w1-master-drop-attrs.patch
> > > > >    Get rid of unneeded master device attributes:
> > > > >    - 'pointer' and 'attempts' are meaningless for userspace;
> > > > >    - information provided by 'slaves' and 'slave_count' can be gathered
> > > > >      from other sysfs bits;
> > > > >    - w1_slave_found has to be rearranged now that slave_count field is gone.
> > > >
> > > > attempts is usefull for broken lines.
> > >
> > > It simply increments with every search i.e. every 10 secondsby default
> > > and does not provide indication of the quality of the wire.
> > 
> > When slaves can not be found until several attempts, it means line
> > is broken, how many time existing slave appeared/dissapeared during
> > /sys/bus/w1/devices/w1_master1/attempts says about link quality.
> 
> Heh, if you are debugging all you need is "date" command to see how
> quickly slave appears. If you want to keep statistics your program
> need to listen to hotpug events for master and slaves and count these.
> I do not see a reason for a counter that simply increments every 10
> seconds.

It is not counter but attempt does matter, one of course can simply
calculate attempt number using timeout value, but that requires 
timeout knowledge, which is not accessible after driver is loaded.

> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
