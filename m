Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWBUVfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWBUVfR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWBUVfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:35:17 -0500
Received: from styx.suse.cz ([82.119.242.94]:28391 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964786AbWBUVfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:35:15 -0500
Date: Tue, 21 Feb 2006 22:35:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
Subject: Re: Suppressing softrepeat
Message-ID: <20060221213525.GA12526@suse.cz>
References: <20060221124308.5efd4889.zaitcev@redhat.com> <d120d5000602211315y60ad2861n4cd64535f9f4850d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000602211315y60ad2861n4cd64535f9f4850d@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 04:15:57PM -0500, Dmitry Torokhov wrote:
 
> I see the problem but I don't think we want another module parameter
> for it. I think if you put the following somewhere into init scripts
> it shoudl work without any additional changes:
> 
>         echo -n "0" > /sys/bus/serio/devices/serioX/softrepeat

This should work, indeed, as an alternative to 'kbdrate -d 750'.

> Of couurse one would jhave to locate proper serioX but that should be easy.
> 
> I also see the following in bugzilla: "... This causs a problem on
> systems that have no real keyboard plugged in, since atkbd probes for
> the keyboard, and won't take control of the port if it doesn't see
> one." Usually it is OK for keyboard to be missing as long as BIOS
> itself does not disable keyboard port - whenever there is new data
> starts coming from the port serio core will try to find proper driver
> for it. I wonder why this is not working on boxes in question.
 
The DRAC3 doesn't respond to ANY commands, thus the atkbd probe fails.

-- 
Vojtech Pavlik
Director SuSE Labs
