Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbUKEQqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUKEQqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbUKEQqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:46:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34060 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262721AbUKEQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:45:57 -0500
Date: Fri, 5 Nov 2004 17:45:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>,
       rml@novell.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net
Subject: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Message-ID: <20041105164523.GC1295@stusta.de>
References: <20041105001328.3ba97e08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following error (compin from Linus' tree) is caused by the fact that 
hotplug_path is no longer EXPORT_SYMBOL'ed:


<--  snip  -->

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-rc1-mm3; fi
WARNING: /lib/modules/2.6.10-rc1-mm3/kernel/drivers/acpi/container.ko needs unknown symbol hotplug_path

<--  snip  -->





