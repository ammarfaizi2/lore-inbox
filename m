Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVJ3SHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVJ3SHP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVJ3SHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:07:15 -0500
Received: from relay2.uli.it ([62.212.1.5]:55011 "EHLO relay2.uli.it")
	by vger.kernel.org with ESMTP id S932149AbVJ3SHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:07:13 -0500
From: Daniele Orlandi <daniele@orlandi.com>
To: linux-kernel@vger.kernel.org
Subject: An idea on devfs vs. udev
Date: Sun, 30 Oct 2005 20:07:11 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301907.11860.daniele@orlandi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Disclaimer: My knowledge about devfs/udev/sysfs is superficial, all the 
following text maybe nonsense. In case, please ignore it, complain, insult 
me, whatever you prefer, I'm not going to be offended :)


I see /dev as an abstraction layer above /sys, where udev implements the 
abstraction. udev takes information from /sys and "translates" it to device 
files organized in a nice way, following several policies configured on the 
system.

Embedded people say "We don't need that kind of abstraction, we are ok with 
working at the lower level".

So, why cannot we substitute the "dev" file within /sys with the actual device 
file?

udev could continue to work in the same fashion, just stat(2)ing the file, 
instead of parsing its contents.

embedded software could directly access the device file in /sys following a 
path that is often meaningful and persistant between reboots.

This is *not* meant to be alternative to udev, just a possibility for people 
who cannot run hotplug/udev and still want to access dynamic devices and are 
prepared to adapt their software and libraries to another scheme.

Bye,

-- 
  Daniele Orlandi
