Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUIDV6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUIDV6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUIDV6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:58:23 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:56226 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261724AbUIDV6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:58:20 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: multi-domain PCI and sysfs
Date: Sat, 4 Sep 2004 14:57:46 -0700
User-Agent: KMail/1.7
Cc: lkml <linux-kernel@vger.kernel.org>
References: <9e4733910409041300139dabe0@mail.gmail.com>
In-Reply-To: <9e4733910409041300139dabe0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041457.46578.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 4, 2004 1:00 pm, Jon Smirl wrote:
> How do multiple PCI domains appear in sysfs? I don't own a machine
> with these so I can't just look.
>
> Do they appear like:
> /sys/devices/pci0000:00
> /sys/devices/pci0001:00
> /sys/devices/pci0002:00

Yep, on all the machines I've used.

sn2 (ia64):
[root@flatearth ~]# ls -l /sys/devices
total 0
drwxr-xr-x  5 root root 0 Sep  5 08:07 pci0000:01
drwxr-xr-x  3 root root 0 Sep  5 08:07 pci0000:02
drwxr-xr-x  2 root root 0 Sep  5 08:07 platform
drwxr-xr-x  5 root root 0 Sep  5 08:07 system
[root@flatearth ~]# ls -l /sys/devices/pci0000\:02
total 0
drwxr-xr-x  2 root root     0 Sep  5 08:07 0000:02:01.0
-rw-r--r--  1 root root 16384 Sep  5 08:07 detach_state

ppc32:
jbarnes@mill:~$ ls -l /sys/devices
total 0
drwxr-xr-x   5 root root 0 Sep  4 13:37 pci0000:00/
drwxr-xr-x  13 root root 0 Sep  4 13:37 pci0001:01/
drwxr-xr-x   7 root root 0 Sep  4 13:37 pci0002:06/
drwxr-xr-x   3 root root 0 Sep  4 13:37 platform/
drwxr-xr-x   4 root root 0 Sep  4 13:37 system/
drwxr-xr-x   5 root root 0 Sep  4 13:37 uni-n-i2c/
jbarnes@mill:~$ ls -l /sys/devices/pci0001\:01/
total 0
drwxr-xr-x  3 root root    0 Sep  4 13:37 0001:01:0b.0/
drwxr-xr-x  3 root root    0 Sep  4 13:37 0001:01:12.0/
drwxr-xr-x  3 root root    0 Sep  4 13:37 0001:01:13.0/
drwxr-xr-x  4 root root    0 Sep  4 13:37 0001:01:17.0/
drwxr-xr-x  3 root root    0 Sep  4 13:37 0001:01:18.0/
drwxr-xr-x  3 root root    0 Sep  4 13:37 0001:01:19.0/
drwxr-xr-x  4 root root    0 Sep  4 13:37 0001:01:1a.0/
drwxr-xr-x  4 root root    0 Sep  4 13:37 0001:01:1b.0/
drwxr-xr-x  4 root root    0 Sep  4 13:37 0001:01:1b.1/
drwxr-xr-x  3 root root    0 Sep  4 13:37 0001:01:1b.2/
-rw-r--r--  1 root root 4096 Sep  4 13:37 detach_state
drwxr-xr-x  2 root root    0 Sep  4 13:37 power/

Jesse
