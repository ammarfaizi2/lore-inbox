Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUDLWJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbUDLWJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 18:09:18 -0400
Received: from fmr01.intel.com ([192.55.52.18]:54915 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263134AbUDLWJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 18:09:15 -0400
Subject: Re: possible bug in the acpi_bus.h file in kernel 2.4.25
From: Len Brown <len.brown@intel.com>
To: Support <Support@btfh.net>
Cc: linux-kernel@vger.kernel.org, Andrew Grover <andrew.grover@intel.com>,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F7911@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F7911@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1081807733.2251.14.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Apr 2004 18:08:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 04:52, Support wrote:
> in the acpi_bus.h file, there is a reference to  device.h, however no
> such
> file exists in the 2.4.25 source code and causes a compile error when
> including acpi in the compile.
> 
> the line is as follows
> 
> 
> #include <linux/device.h>

works for me.

Is your acpi_bus.h missing the following line immediately
before the include?

#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,4))

-Len

