Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264175AbUEHVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUEHVgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUEHVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 17:36:37 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:6038 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S264175AbUEHVgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 17:36:31 -0400
Message-ID: <409D52D3.5080500@superonline.com>
Date: Sun, 09 May 2004 00:36:19 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: len.brown@intel.com
Subject: Re: OOPS :  2.4.27-pre2 + latest ACPI
References: <409D50AE.2020908@superonline.com>
In-Reply-To: <409D50AE.2020908@superonline.com>
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O.Sezer wrote:
[...]
>>>EIP; c01a575a <acpi_ns_map_handle_to_node+19/29>   <=====
> 
> 
>>>ebx; 5a5a5a5a Before first symbol
>>>edi; ddc69e9c <_end+1d919018/206911dc>
>>>ebp; ddc69e90 <_end+1d91900c/206911dc>
>>>esp; ddc69e8c <_end+1d919008/206911dc>
> 
> 
> Trace; c0196144 <acpi_remove_notify_handler+87/18e>
> Trace; e0ae293a <[button]acpi_button_remove+78/d4>
> Trace; e0ae245d <[button]acpi_button_notify+0/94>
> Trace; e0ae2c9f <[button].text.end+1e4/2e5>
> Trace; e0ae2abc <[button].text.end+1/2e5>
> Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
> Trace; c01b5a3f <acpi_bus_unattach+94/11f>
> Trace; c01b59ab <acpi_bus_unattach+0/11f>
> Trace; c01b5339 <acpi_bus_walk+a3/cf>
> Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
> Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
> Trace; c01b5cca <acpi_bus_unregister_driver+4c/d1>
> Trace; c01b59ab <acpi_bus_unattach+0/11f>
> Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
> Trace; e0ae2a84 <[button]acpi_button_exit+49/80>
> Trace; e0ae3340 <[button]acpi_button_driver+0/d3>
> Trace; e0ae2cc3 <[button].text.end+208/2e5>
> Trace; e0ae2abc <[button].text.end+1/2e5>
> Trace; c012051a <free_module+ba/d0>
> Trace; c011f889 <sys_delete_module+a9/1e0>
> Trace; c0108ea7 <system_call+33/38>
> 
> Code;  c01a575a <acpi_ns_map_handle_to_node+19/29>
> 00000000 <_EIP>:
> Code;  c01a575a <acpi_ns_map_handle_to_node+19/29>   <=====
>    0:   80 3b 0f                  cmpb   $0xf,(%ebx)   <=====
> Code;  c01a575d <acpi_ns_map_handle_to_node+1c/29>
>    3:   0f 44 c3                  cmove  %ebx,%eax
> Code;  c01a5760 <acpi_ns_map_handle_to_node+1f/29>
>    6:   5b                        pop    %ebx
> Code;  c01a5761 <acpi_ns_map_handle_to_node+20/29>
>    7:   5d                        pop    %ebp
> Code;  c01a5762 <acpi_ns_map_handle_to_node+21/29>
>    8:   c3                        ret    
> Code;  c01a5763 <acpi_ns_map_handle_to_node+22/29>
>    9:   a1 94 c0 32 c0            mov    0xc032c094,%eax
> Code;  c01a5768 <acpi_ns_map_handle_to_node+27/29>
>    e:   eb f6                     jmp    6 <_EIP+0x6>
> Code;  c01a576a <acpi_ns_convert_entry_to_handle+0/8>
>   10:   55                        push   %ebp
> Code;  c01a576b <acpi_ns_convert_entry_to_handle+1/8>
>   11:   89 e5                     mov    %esp,%ebp
> Code;  c01a576d <acpi_ns_convert_entry_to_handle+3/8>
>   13:   8b 00                     mov    (%eax),%eax
> 
> 
> 3 warnings and 3 errors issued.  Results may not be reliable.

Sorry for giving missing info:
Oops occurs upon attemping to shutdown the machine during
which time unloading the button module, I guess.

If you require more info or want me to try anything/any code,
simply ask.

Best regards;
Özkan Sezer

