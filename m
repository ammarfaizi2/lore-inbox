Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270280AbRIAKw5>; Sat, 1 Sep 2001 06:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270309AbRIAKwr>; Sat, 1 Sep 2001 06:52:47 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:18948 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270280AbRIAKw3>; Sat, 1 Sep 2001 06:52:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Carlos E Gorges <carlos@techlinux.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Hardware detection tool 0.2
Date: Sat, 1 Sep 2001 12:54:55 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <01083019402502.01265@skydive.techlinux>
In-Reply-To: <01083019402502.01265@skydive.techlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15d8Nv-21lwumC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 August 2001 00:40, Carlos E Gorges wrote:
> Hardware detection tool 0.2
> The main idea is keep a unified database of modules and
> create a good tool for hardware configurators.

The next version of the device registry patch (http://www.tjansen.de/devreg) 
will contain a similar feature. 
In the current release bus drivers (like PCI, USB..) register their devices 
in the registry and the devices are then displayed in a generic, 
bus-independent form in the /proc/devreg directory.
In the upcoming version those drivers with devreg support register themselves 
on initialization and also register each driver instance (an instance handles 
a single physical device) that they create. The instance will then be 
connected to the device, devfs nodes will be connected to the driver instance 
and you can get a pretty good graph of the relations between drivers, driver 
instances, devfs nodes/minor numbers and the physical devices.

bye...
