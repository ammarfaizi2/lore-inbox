Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVC2VZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVC2VZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVC2VZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:25:12 -0500
Received: from digitalimplant.org ([64.62.235.95]:25031 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261252AbVC2VXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:23:47 -0500
Date: Tue, 29 Mar 2005 13:23:35 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: dtor_core@ameritech.net, Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at
 fault?
In-Reply-To: <20050329205225.GF8125@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0503291321490.29474-100000@monsoon.he.net>
References: <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org>
 <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org>
 <4243D854.2010506@suse.de> <d120d50005032908183b2f622e@mail.gmail.com>
 <20050329181831.GB8125@elf.ucw.cz> <d120d50005032911114fd2ea32@mail.gmail.com>
 <20050329192339.GE8125@elf.ucw.cz> <d120d50005032912051fee6e91@mail.gmail.com>
 <20050329205225.GF8125@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Mar 2005, Pavel Machek wrote:

> I don't really want us to try execve during resume... Could we simply
> artifically fail that execve with something if (in_suspend()) return
> -EINVAL; [except that in_suspend() just is not there, but there were
> some proposals to add it].
>
> Or just avoid calling hotplug at all in resume case? And then do
> coldplug-like scan when userspace is ready...

I thought that cold-plugging only worked for devices, not all objects.

Can we just queue up hotplug events? That way we wouldn't lose any across
the transition, and could be used to send resume events to userspace for
various devices that need help..


	Pat

