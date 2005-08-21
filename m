Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVHUF0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVHUF0V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 01:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVHUF0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 01:26:21 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:28298 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750806AbVHUF0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 01:26:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=mV2RaDzTzaOr6dn9V6Lq8TEzaVqBwL9VhQPlUBFykSKvcrZSynHhWIN6wQLMdtnOH8/bl/C/Lzq23lCl/FbBoBbmEPtnVQRJwfAEPionsK8kWDg2W4m5D8l6x11Sej6Ncj6qp/5NKvLDBGEnmtoNs7n6OttsFNdOLLv0E5ZCvNQ=
Date: Sun, 21 Aug 2005 01:26:10 -0400
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.5: psmouse mouse detection doesn't work
Message-ID: <20050821052610.GD13127@nineveh.rivenstone.net>
Mail-Followup-To: Harald Dunkel <harald.dunkel@t-online.de>,
	linux-kernel@vger.kernel.org
References: <4308062F.7080208@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4308062F.7080208@t-online.de>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 06:42:23AM +0200, Harald Dunkel wrote:
> Hi folks,
>
> At boot time my Logitech mouse is detected as
>
> I: Bus=0011 Vendor=0002 Product=0001 Version=0000
> N: Name="PS/2 Generic Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=event1 ts0 mouse0
> B: EV=7
> B: KEY=70000 0 0 0 0
> B: REL=3
>
> After manually reloading psmouse I get the expected
>
> I: Bus=0011 Vendor=0002 Product=0002 Version=0049
> N: Name="PS2++ Logitech Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=event1 ts0 mouse0
> B: EV=7
> B: KEY=f0000 0 0 0 0
> B: REL=3
>
> Using psmouse_noext=1 at boot time does not help.
>
> How comes that this doesn't work on the first run?
>
> I asked this more than a year ago, and somebody posted
> a fix, but obviously it wasn't accepted.
>
> What needs to be done to fix this?

    If psmouse is a module, you'd need to pass proto=bare as a module
parameter rather than on the kernel command line.  Check `modinfo
psmouse`.

    Are you sure proto=imps hasn't found its way into
/etc/modprobe.conf or so?  I could imagine a distribution shipping
this way.

--
Joseph Fannin
jfannin@gmail.com

 /* So there I am, in the middle of my `netfilter-is-wonderful'
talk in Sydney, and someone asks `What happens if you try
to enlarge a 64k packet here?'. I think I said something
eloquent like `fuck'. - RR */
