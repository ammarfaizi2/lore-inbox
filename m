Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTJNOc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTJNOc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:32:56 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:24587 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S262301AbTJNOcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:32:55 -0400
Date: Tue, 14 Oct 2003 16:32:51 +0200
From: David Jez <dave.jez@seznam.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: hotplug and /etc/init.d/hotplug
Message-ID: <20031014143250.GC82125@stud.fit.vutbr.cz>
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
  Hi,

> I am running RedHat 9 with 2.4.20-8  kernel ;
> Now , I have a questo about hotplug:
> I have hotplug-2002_04_01-17 installed (rpm);
> 
> Now , I read the readme of this rpm ;
> in their "installing"  section , clause 5 , it says:
> # cp etc/rc.d/init.d/hotplug /etc/rc.d/init.d/hotplug
> # cd /etc/rc.d/init.d
> # chkconfig --add hotplug
> 
> I checked on my machine and there is no "hotplug" file in that folder.
> Nevertheless, hotplugin works (because when I plug a USB camera
> I can see in the kernel log (/var/log/messages)  messages which start with
> /etc/hotplug/usb.agent
> 
> I also looked at the kernel code (method "call_polcy" in usb.c )
> and it doesn't seems to me that the hotplug in /etc/init.d is needed .
> 
> can anybody make some clarifications ?
  Don't worry about it :-)
  /etc/init.d/... file is script for bring up hotplug subsytem... for
usb it means: modprobe module for usb host controller adapter and mount
/proc/bus/usb ...
  Hotplugin works because usb subsystem execute /sbin/hotplug binary...

  Is that enought?
> sting
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
