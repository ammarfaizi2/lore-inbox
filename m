Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbULVIJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbULVIJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbULVIJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:09:55 -0500
Received: from dsl093-216-237.aus1.dsl.speakeasy.net ([66.93.216.237]:12763
	"EHLO defaultvalue.org") by vger.kernel.org with ESMTP
	id S261230AbULVIJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:09:53 -0500
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on
 EMBEDDED
References: <20041220001644.GI21288@stusta.de>
	<20041220003146.GB11358@kroah.com> <20041220013542.GK21288@stusta.de>
	<20041219205104.5054a156@lembas.zaitcev.lan>
	<41C65EA0.7020805@osdl.org>
	<20041220062055.GA22120@one-eyed-alien.net>
	<20041219223723.3e861fc5@lembas.zaitcev.lan>
From: Rob Browning <rlb@defaultvalue.org>
Date: Wed, 22 Dec 2004 02:10:00 -0600
In-Reply-To: <20041219223723.3e861fc5@lembas.zaitcev.lan> (Pete Zaitcev's
 message of "Sun, 19 Dec 2004 22:37:23 -0800")
Message-ID: <87u0qepxd3.fsf@trouble.defaultvalue.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> Is it that bad, really? Honestly, I could not imagine users can be
> so dumb.  The option defaults to off. There is a warning in the
> Kconfig. And yet they first enable it and then complain about it. I
> don't know what to do about it, either.

Well, I presume you know this, but at least in 2.6.9, there's no
warning.  When I read it, it said:

   CONFIG_BLK_DEV_UB:

   This driver supports certain USB attached storage devices
   such as flash keys.

   If unsure, say N.

which sounded potentially useful, and certainly didn't give the
impression that the driver was likely to perform terribly in common
cases (i.e. when using an external drive).

The sample Kconfig warnings I saw posted later in this thread would
certainly have given enough information to know to avoid the driver,
though if true, this might be even clearer:

  Note: this driver does not coexist well with usb-storage, and
  usb-storage is is often the best driver for common devices like
  external drive enclosures.  At the moment, usb-storage may peform
  dramatically better for those devices.

  If you're not certain you need this driver, you should probably
  say 'N' here, and choose usb-storage instead.

-- 
Rob Browning
rlb @defaultvalue.org and @debian.org; previously @cs.utexas.edu
GPG starting 2002-11-03 = 14DD 432F AE39 534D B592  F9A0 25C8 D377 8C7E 73A4
