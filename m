Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbUKFFui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbUKFFui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 00:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUKFFui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 00:50:38 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:14222 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261308AbUKFFue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 00:50:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Date: Sat, 6 Nov 2004 00:50:32 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       tokunaga.keiich@jp.fujitsu.com, motoyuki@soft.fujitsu.com,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       rml@novell.com, len.brown@intel.com, acpi-devel@lists.sourceforge.net
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105204209.GA1204@kroah.com> <20041105211848.A21098@unix-os.sc.intel.com>
In-Reply-To: <20041105211848.A21098@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411060050.32816.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 November 2004 12:18 am, Keshavamurthy Anil S wrote:
> Also, since you have brought this, I have one another question to you.
> Now in the new kernel, I see whenever anybody calls sysdev_register(kobj),
> an "ADD" notification is sent. why is this? I would like to call
> kobject_hotplug(kobj, ADD) later.
> 

Hi Anil,

Please take a look at drivers/base/firmware_class.c to see how one can
suppress initial hotplug notification and call hotplug when object is
finally ready. Hopefully you can use similar solution.

-- 
Dmitry
