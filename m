Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVCYKOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVCYKOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 05:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCYKO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 05:14:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53144 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261569AbVCYKOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 05:14:12 -0500
Date: Fri, 25 Mar 2005 11:13:44 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: Andy Isaacson <adi@hexapodia.org>, dtor_core@ameritech.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050325101344.GA1297@elf.ucw.cz>
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4243D854.2010506@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > OK, anything else I should try?
> 
> not really, i just wait for Vojtech and Pavel :-)

Try commenting out "call_usermodehelper". If that helps, Stefan's
theory is confirmed, and this waits for Vojtech to fix it.


> > In the SysRq-T trace I see one interesting process: most things are
> > in D state in refrigerator(), but sh shows the following traceback:
> > 
> > wait_for_completion
> > call_usermodehelper
> > kobject_hotplug
> > kobject_del
> > class_device_del
> > class_device_unregister
> > mousedev_disconnect
> > input_unregister_device
> > alps_disconnect
> > psmouse_disconnect
> > serio_driver_remove
> > device_release_driver
> > serio_release_driver

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
