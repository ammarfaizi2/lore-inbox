Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTKHNDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 08:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTKHNDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 08:03:30 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:1285 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261757AbTKHND2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 08:03:28 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Accessing device information in REMOVE agent
Date: Sat, 8 Nov 2003 16:02:25 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311081602.25978.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to be notified when block device goes away (e.g. USB stick unplugged) 
basically to look if device is in use and possibly initiate clean up. Block 
hotplug currently is passing only DEVPATH; but it alone is not reliable way 
to identify it; device may be used under alias names via symbolic links.

Is it safe to access /sys/$DEVPATH in REMOVE agent? Apparently hotplug is 
called asynchronously i.e. it is possible that /sys entry is already removed?

Would it make sense to add device number? It seems to be natural native "block 
device ID" :)

TIA

-andrey

