Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTIHV1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTIHV1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:27:20 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:4482
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263572AbTIHV1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:27:19 -0400
Date: Mon, 8 Sep 2003 17:27:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
In-Reply-To: <20030908155048.GA10879@kroah.com>
Message-ID: <Pine.LNX.4.53.0309081722270.14426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com>
 <20030908155048.GA10879@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Greg KH wrote:

> Ick, no, I do not want to see this function get added, sorry.

Well i was expecting that.

> What happens if someone grabs the struct device reference by opening a
> sysfs file and then you unload the module?  Yeah, not nice.  Please do

Doesn't this all get taken care of by the platform_device_unregister?

> _not_ create "empty" release() functions, unless you _really_ know what
> you are doing (and providing a "default" one like this is just ripe for
> abuse, that warning message in the kernel is there for a reason.)

I know it's begging for abuse, but i don't want to sprinkle empty 
release() functions everywhere, e.g. looking at the floppy driver, i'm 
not quite sure what i'm supposed to do with a release() function there, 
the struct platform_device_struct is statically allocated. Basically i'd 
like a pointer as to what to do with these release() functions..

Thanks,
	Zwane
