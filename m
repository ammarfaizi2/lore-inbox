Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbTJNVZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTJNVZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:25:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:19932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262929AbTJNVZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:25:33 -0400
Date: Tue, 14 Oct 2003 14:22:15 -0700
From: Greg KH <greg@kroah.com>
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug and /etc/init.d/hotplug
Message-ID: <20031014212215.GB17310@kroah.com>
References: <Sea2-F47xegIqunLOyD000050c7@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Sea2-F47xegIqunLOyD000050c7@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 01:53:46PM +0200, sting sting wrote:
> Hello,
> I am running RedHat 9 with 2.4.20-8  kernel ;
> Now , I have a questo about hotplug:
> I have hotplug-2002_04_01-17 installed (rpm);
> 
> Now , I read the readme of this rpm ;
> in their "installing"  section , clause 5 , it says:
> # cp etc/rc.d/init.d/hotplug /etc/rc.d/init.d/hotplug
> # cd /etc/rc.d/init.d
> # chkconfig --add hotplug

That is because Red Hat does not ship the /etc/init.d/hotplug script.
Take it up with them if you want them to change this.

> I checked on my machine and there is no "hotplug" file in that folder.
> Nevertheless, hotplugin works (because when I plug a USB camera
> I can see in the kernel log (/var/log/messages)  messages which start with
> /etc/hotplug/usb.agent
> 
> I also looked at the kernel code (method "call_polcy" in usb.c )
> and it doesn't seems to me that the hotplug in /etc/init.d is needed .

needed for what?  For devices being plugged in and removed, no.  But to
start up the usb subsystems, or shut them down, yes.  Or you can do it
in the rc.sysinit script, which is what Red Hat does.

Hope this helps,

greg k-h
