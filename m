Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268938AbTBWT1m>; Sun, 23 Feb 2003 14:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268920AbTBWT1m>; Sun, 23 Feb 2003 14:27:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S269160AbTBWT0j>;
	Sun, 23 Feb 2003 14:26:39 -0500
Date: Sun, 23 Feb 2003 13:14:14 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug with (maybe not *in*) sysfs
In-Reply-To: <5480000.1046028715@[10.10.2.4]>
Message-ID: <Pine.LNX.4.33.0302231310500.923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the debug output and backtrace - that's really helpful. :)

> bus pci: add driver ips
> 
> kobject ips: registering. parent: <NULL>, set: drivers
> 
> bus pci: add driver ips
> 
> kobject ips: registering. parent: <NULL>, set: drivers
> 
> Badness in kobject_register at lib/kobject.c:152
> 
> Call Trace:

[...]

This is typically caused by the same object being added twice at the same 
level in the hierarchy, which appears to be happening. Is the ips driver 
calling pci_register_driver() twice? 

	-pat

