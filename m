Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUIKSWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUIKSWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUIKSWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:22:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:12561 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268263AbUIKSWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:22:42 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Subject: Re: [PATCH] udev: udevd shall inform us abot trouble
Date: Sat, 11 Sep 2004 21:22:36 +0300
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200409081018.43626.vda@port.imtp.ilyichevsk.odessa.ua> <200409111943.21225.vda@port.imtp.ilyichevsk.odessa.ua> <41433A68.7090403@backtobasicsmgmt.com>
In-Reply-To: <41433A68.7090403@backtobasicsmgmt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409112122.36068.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 September 2004 20:48, Kevin P. Fleming wrote:
> Denis Vlasenko wrote:
> > Well, I lied a bit. These lines are from my home box, which is not
> > udev'ified yet. At the job, I sit on i815 box, and there amixer
> > fails to set volume. It happens 100% of the time. Adding "sleep 1"
> > after modprobing helps. With devfs it worked without sleep.
>
> This is correct; with devfs, creation of device nodes during module
> loading was synchronous, so it was always (or nearly always) complete
> before modprobe returned. With udev, creation of device nodes is
> completely asynchronous, and may happen at _any_ time after the module
> has been loaded.

Yes. I know why it works differently.

> The real solution here is for people to re-think their system startup
> processes; if you need mixer settings applied at startup, then build a
> small script somewhere in /etc/hotplug.d or /etc/dev.d that applies them
> to the mixer _when it appears_.

As a user, I prefer to be able to use device right away after
modprobe. Imagine ethN appearing "sometime after" modprobe.
Would you like such behavior?
--
vda

