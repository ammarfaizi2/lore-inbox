Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUBVJvK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 04:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUBVJvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 04:51:10 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:35344 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261211AbUBVJvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 04:51:08 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Sun, 22 Feb 2004 12:33:18 +0300
To: linux-hotplug-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: USB class hotplug confusion
Message-ID: <20040222093318.GA4873@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since some time running -mm produces

cat: /sys//class/usb/lp0/bNumConfigurations: No such file or directory
/etc/hotplug/usb.agent: line 144: [: too many arguments

there is no wonder as

{pts/2}% l /sys/class/usb/lp0
dev  device@  driver@

apparently in addition to "normal" USB events we get extra class
events; I must admit I do not understand what "class" is for and why
usblp is using it but e.g. joystick (that I have as well) does not.

Is there simple way to simply ignore those events in usb.agent? Or
better yet - is it possible to specify different agents for "device" and
"class" events? As kernel provides both they are presumed to be
different and require different actions?

-andrey
