Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbUDWWff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUDWWff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUDWWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:35:34 -0400
Received: from ra.sai.msu.su ([158.250.29.2]:33674 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S261635AbUDWWfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:35:24 -0400
Date: Sat, 24 Apr 2004 02:35:07 +0400 (MSD)
From: "E.Rodichev" <er@sai.msu.su>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct /dev/psaux driver and relevant Kconfig changes
In-Reply-To: <200404211727.05491.dtor_core@ameritech.net>
Message-ID: <Pine.GSO.4.58.0404240214510.20351@ra.sai.msu.su>
References: <Pine.GSO.4.58.0404212031450.2778@ra.sai.msu.su>
 <200404211727.05491.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Dmitry Torokhov wrote:

> The driver is not ready for kernel proper - it will not work for machines
> with active multiplexing controllers (4 AUX + KBD port) and these are quite
> common.

Dmitry,

I'd like to add some arguments for includind a compatibility /dev/psaux
driver into production 2.6.x series.

- you argue that the driver is not ready for kernel because it doesn't
support all hardware. But it is typical - every driver may work only for
some defined subset of hardware availiable. There are many drivers in
linux kernel now, which are specific for some notebooks and/or controllers.
IBM ThinkPad is rather wide-spead notebooks, and IMHO only this reason is
sufficient argument not to reject suggested compatibility driver.

- it will be very inconvenient for _many_ users to modify this patch for
every new release of 2.6.x kernels. I'm not going into several discussions
concerning new input level approach. It is a good thing, and the development
of new approach will be continued, but why we have to reject optional
compatibility solution?

- if this driver will be included in mainstream, it will be additional
challenge for many people to extend its hardware compatibility.

Best wishes,
E.R.
_________________________________________________________________________
Evgeny Rodichev                          Sternberg Astronomical Institute
email: er@sai.msu.su                              Moscow State University
Phone: 007 (095) 939 2383
Fax:   007 (095) 932 8841                       http://www.sai.msu.su/~er
