Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVDYQkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVDYQkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVDYQjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:39:13 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:56563 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262701AbVDYQgH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:36:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LB4mAfj1BMmLa41qtrJQwRX8LkvWhlB06a5NzSoe2ov5Ysw7KVCcj51lp4yVPSAihgD2dNDhHp9Bvm+ehIXJ6/tlnraBalKgtoak1i6jlYBwy3BULWUxvYw6sQaBdM6ioPF3d1j0w/fNRx57yWlIiZQqUEHDFs+p8KEnyImqnRE=
Message-ID: <d120d50005042509366e5a0895@mail.gmail.com>
Date: Mon, 25 Apr 2005 11:36:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <1114420290.8527.56.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d5000504210909f0e0713@mail.gmail.com>
	 <1114420290.8527.56.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Thu, 2005-04-21 at 11:09 -0500, Dmitry Torokhov wrote:
> > One more thing...
> >
> > On 4/21/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> > >
> > > > w1-master-drop-attrs.patch
> > > >    Get rid of unneeded master device attributes:
> > > >    - 'pointer' and 'attempts' are meaningless for userspace;
> > > >    - information provided by 'slaves' and 'slave_count' can be gathered
> > > >      from other sysfs bits;
> > > >    - w1_slave_found has to be rearranged now that slave_count field is gone.
> > >
> > > attempts is usefull for broken lines.
> >
> > It simply increments with every search i.e. every 10 secondsby default
> > and does not provide indication of the quality of the wire.
> 
> When slaves can not be found until several attempts, it means line
> is broken, how many time existing slave appeared/dissapeared during
> /sys/bus/w1/devices/w1_master1/attempts says about link quality.

Heh, if you are debugging all you need is "date" command to see how
quickly slave appears. If you want to keep statistics your program
need to listen to hotpug events for master and slaves and count these.
I do not see a reason for a counter that simply increments every 10
seconds.

-- 
Dmitry
