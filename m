Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVAHJej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVAHJej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVAHJeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:34:17 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:38953 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261956AbVAHGIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 01:08:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RZ1/8G8/mpdSU4t/ccqHuFIriDJNKd6ZFSw6w4DQ5nq7QMxV6TxPbuDctmWc6nud5Dw447DTyJkrL8+d7G1oeP4AGchnfjF6249w4i64BMtl26iDyduYvjKh4H5fnKzh0jNSxgmskqJ0EJqrVdzaNeYKNAtp47A3YZ41ASHPMnk=
Message-ID: <9e473391050107220875baa32b@mail.gmail.com>
Date: Sat, 8 Jan 2005 01:08:52 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Export symbol from I2C eeprom driver
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050108055315.GC8571@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105010721347fbeb907@mail.gmail.com>
	 <20050108055315.GC8571@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005 21:53:16 -0800, Greg KH <greg@kroah.com> wrote:
> On Sat, Jan 08, 2005 at 12:34:44AM -0500, Jon Smirl wrote:
> > Trivial patch to export a symbol from the eeprom driver. Currently
> > there are no exported symbols. The symbol lets the radeon DRM driver
> > link to it and modprobe will then force it to load along with the
> > radeon driver.
> 
> Why do you need this symbol?  Or are you just saying that you need the
> eeprom driver loaded for some reason?
> 
> I say this as this variable is probably going to go away in the very
> near future, as it isn't really needed at all.

I just need a symbol to force eeprom to load, it can be any symbol.  I
need something for the radeon driver to link to so that modprobe will
know to force eeprom to load when radeon is loaded. radeon is getting
hotplug code that needs the eeprom module loaded.

-- 
Jon Smirl
jonsmirl@gmail.com
