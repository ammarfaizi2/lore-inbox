Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVCDUpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVCDUpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVCDUmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:42:33 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:422 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S263000AbVCDUhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:37:37 -0500
Date: Fri, 4 Mar 2005 21:38:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hans-Christian Egtvedt <hc@mivu.no>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Message-ID: <20050304203823.GB2550@ucw.cz>
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no> <200503041403.37137.adobriyan@mail.ru> <d120d50005030406525896b6cb@mail.gmail.com> <1109953224.3069.39.camel@charlie.itk.ntnu.no> <d120d50005030408544462c9ea@mail.gmail.com> <20050304185147.GB9407@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304185147.GB9407@samfundet.no>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 07:51:47PM +0100, Hans-Christian Egtvedt wrote:

> OK, I'll try to find some better documentation about input devices, any
> tips/pointers would be nice. I'm completly new to kernel drivers, I'm used to
> writing drivers in embedded systems.
> 
> The driver is made in the way it is today because there is also a driver for
> X which read raw events from /dev/input/eventX. It's called lictouch, I have
> the source for it too, but I'm not (yet) part of any developing there.

Please take a look at 'evtouch' by Kenan Esau, which may fit your bill
as an X driver, too. [http://www.conan.de/lifebook]

> It would be a really nice feature if one could use the touchscreen as a
> legacy interface, but then I would need to be able to calibrate the screen in
> the driver and not frontend. At least preferable.

It's possible to do that to a certain degree using the EVIOCSABS
ioctl(). Only trivial linear calibration is supported, though.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
