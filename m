Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUCLPzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUCLPzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:55:25 -0500
Received: from fmr06.intel.com ([134.134.136.7]:16804 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262215AbUCLPzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:55:12 -0500
Subject: Re: Can't access ACPI memory through /dev/mem
From: Len Brown <len.brown@intel.com>
To: "Ph. Marek" <philipp.marek@bmlv.gv.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F4E11@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4E11@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079106900.2173.21.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Mar 2004 10:55:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does dmidecode find what you're looking for?

http://www.nongnu.org/dmidecode/

-Len

On Fri, 2004-03-12 at 04:18, Ph. Marek wrote:
> Hello everybody!
> 
> My machine gives me for
>         $ cat /proc/iomem
>         00000000-0009fbff : System RAM
>         0009fc00-0009ffff : reserved
>         000a0000-000bffff : Video RAM area
>         000c0000-000c7fff : Video ROM
>         000d0000-000d9fff : Extension ROM
>         000f0000-000fffff : System ROM
>         00100000-0f7dffff : System RAM
>           00100000-0022ca51 : Kernel code
>           0022ca52-0029d8e3 : Kernel data
>         0f7e0000-0f7e7fff : ACPI Tables
>         0f7e8000-0f7fffff : ACPI Non-volatile Storage
>         80100000-801fffff : PCI Bus #01
>           80100000-8011ffff : Silicon Integrated Systems [SiS] SiS630
> GUI
> and so on.
> 
> Now I can access the whole area below the ACPI tables (I tried RAM,
> video and 
> system ROM, and kernel code/data).
> But on reaching the ACPI tables and above (PCI space and so on) I get
> no data 
> (that is, vche blanks the screen).
> 
> I'd expect that for the PCI space - as this is really IO-memory and
> shouldn't 
> be messed with.
> 
> But I'd like to access the ACPI tables; especially the NVRAM, as some
> machines 
> store DMI data there.
> 
> This is on 
>         Linux version 2.4.24-1-686 (herbert@gondolin) (gcc version
> 3.3.2 (Debian))
> and an old 2.4.19 kernel.
> 
> 
> Any tips? Help for accessing this memory space?
> 
> 
> Regards,
> 
> Phil
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

