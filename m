Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbTAFMuE>; Mon, 6 Jan 2003 07:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbTAFMuE>; Mon, 6 Jan 2003 07:50:04 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:40654 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S265890AbTAFMuD>; Mon, 6 Jan 2003 07:50:03 -0500
Date: Tue, 07 Jan 2003 01:58:04 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Andrew Morton <akpm@digeo.com>, "Grover, Andrew" <andrew.grover@intel.com>
cc: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Message-ID: <20150000.1041857884@localhost.localdomain>
In-Reply-To: <3E196C17.7D318CAF@digeo.com>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
 <3E196C17.7D318CAF@digeo.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, January 06, 2003 03:44:23 -0800 Andrew Morton <akpm@digeo.com> 
wrote:

> acpi_thermal_run is doing many sinful things.  Blocking memory
> allocations as well as launching kernel threads from within a
> timer handler.
>
> Converting it to use schedule_work() or schedule_delayed_work()
> would fix that up.

So *that* is why ACPI kernels are so slow on my laptop (Dell i8k), and make 
so much heat.  I bet one of those threads ends up busy looping because of 
other brokenness.
