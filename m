Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274018AbRIXQp0>; Mon, 24 Sep 2001 12:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274016AbRIXQpU>; Mon, 24 Sep 2001 12:45:20 -0400
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:39409 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S274017AbRIXQpJ>; Mon, 24 Sep 2001 12:45:09 -0400
Message-ID: <8FB7D6BCE8A2D511B88C00508B68C2081971AF@orsmsx102.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Giacomo A. Catenazzi'" <cate@dplanet.ch>, linux-kernel@vger.kernel.org
Subject: RE: Oops at boot: 2.4.10-pre15, acpi
Date: Mon, 24 Sep 2001 09:45:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.10 should fix this. ACPI won't load (it appears it's not an ACPI
machine) but it won't oops, either.

Let me know asap if the problem is still there.

Thanks -- Regards -- Andy

> From: Giacomo A. Catenazzi [mailto:cate@dplanet.ch]
> Note: Oops copied by hand from console.
> 
> The oops happens just after:
> "APCI: System description table not found"
> 
> Unable to handle kernel NULL pointer dereferences at virtual address
> 000000d4
> c015d7e2
> *pde = 00000000
> Oops: 0000
> CPU: 0
> EIP: 0010:[<c015d7e2>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000000   ebx: c0133fd0   ecx: 00000000   edx: 000010ca
> esi: c021dfd4   edi: c025a4f4   ebp: 0008e000   esp: c1133fb8
> ds: 0018   es: 0018   ss: 0018
> Stack: c024aa4c c016b904 c1133fb0 00000000 00000000 00000000 00000000
> Call Trace: [<c016b904>] [<c016bcba>] [<c010503b>] [<c010547c>]
> Code: 8b 80 d4 00 00 00 00 e8 46
> 
> >>EIP; c015d7e2 <acpi_get_timer+22/40>   <=====
> Trace; c016b904 <bm_initialize+28/a0>
> Trace; c016bcba <bm_osl_init+46/54>
> Trace; c010503b <init+7/10c>
> Trace; c010547c <kernel_thread+28/38>
> Code;  c015d7e2 <acpi_get_timer+22/40>
> 00000000 <_EIP>:
> Code;  c015d7e2 <acpi_get_timer+22/40>   <=====
>    0:   8b 80 d4 00 00 00         mov    0xd4(%eax),%eax   <=====
> Code;  c015d7e8 <acpi_get_timer+28/40>
>    6:   00 e8                     add    %ch,%al
> Code;  c015d7ea <acpi_get_timer+2a/40>
>    8:   46                        inc    %esi
> 
> 
> 	giacomo
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
