Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbSJMVyH>; Sun, 13 Oct 2002 17:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJMVyH>; Sun, 13 Oct 2002 17:54:07 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:45763 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S261679AbSJMVyG>; Sun, 13 Oct 2002 17:54:06 -0400
Date: Sun, 13 Oct 2002 22:54:39 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
Message-ID: <20021013215439.GA3843@arwen.brautaset.org>
References: <Pine.LNX.4.44.0210120758420.4532-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210120758420.4532-100000@dad.molina>
User-Agent: Mutt/1.3.28i
X-Location: London, UK
X-URL: http://brautaset.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 12 2002, Thomas wrote:
[snip]
> --------------------------------------------------------------------------
>    open                   11 Oct 2002 apm hangs instead of suspending
> 
>   41. http://marc.theaimsgroup.com/?l=linux-kernel&m=103432997711883&w=2

Here's some more info related to the above issue.

The below BUG occured on a freshly booted 2.5.42 kernel, when I tried to
enter suspend2ram mode on a Latitude CPx H500GT. Please let me know if
you need any more information.

Oct 13 02:12:23 arwen kernel: xircom_suspend(eth0)
Oct 13 02:12:25 arwen kernel: ------------[ cut here ]------------
Oct 13 02:12:25 arwen kernel: kernel BUG at drivers/base/core.c:251!
Oct 13 02:12:25 arwen kernel: invalid operand: 0000
Oct 13 02:12:25 arwen kernel: binfmt_misc xircom_tulip_cb crc32 ds yenta_socket pcmcia_core psmouse maestro soundcore apm rtc  
Oct 13 02:12:25 arwen kernel: CPU:    0
Oct 13 02:12:25 arwen kernel: EIP:    0060:[put_device+71/112]    Tainted: P  
Oct 13 02:12:25 arwen kernel: EFLAGS: 00010202
Oct 13 02:12:25 arwen kernel: eax: 00000000   ebx: c7528050   ecx: c75280e8   edx: c6cac000
Oct 13 02:12:25 arwen kernel: esi: c7f93050   edi: c7528000   ebp: c7535800   esp: c6caddec
Oct 13 02:12:25 arwen kernel: ds: 0068   es: 0068   ss: 0068
Oct 13 02:12:25 arwen kernel: Process apmd (pid: 359, threadinfo=c6cac000 task=c7641940)
Oct 13 02:12:25 arwen kernel: Stack: c7528000 00000000 c017c9b6 c7528050 c7528000 c883ad17 c7528000 c7535800 
Oct 13 02:12:25 arwen kernel:        c7535800 c6cade78 c022d400 c8837fea c7535800 c7535800 c7535800 c753580c 
Oct 13 02:12:25 arwen kernel:        c7535800 00000080 c6cade78 c022d400 c8838315 c7535800 00000003 c7535800 
Oct 13 02:12:25 arwen kernel: Call Trace: [pci_remove_device+14/56]  [<c883ad17>]  [<c8837fea>]  [<c8838315>]  [<c8838356>]  [<c88381d8>]  [<c883816c>]  [<c88380fc>]  [<
c8838398>]  [<c8838458>]  [<c883e3e8>]  [pci_pm_resume_device+27/32]  [pci_pm_resume_bus+37/92]  [pci_pm_resume+39/64]  [pci_pm_callback+61/72]  [pm_send+69/120]  [pm_se
nd_all+62/136]  [<c8823930>]  [<c8824083>]  [sys_ioctl+637/724]  [sys_sync+29/36]  [syscall_call+7/11] 
Oct 13 02:12:25 arwen kernel: Code: 0f 0b fb 00 92 9a 20 c0 8b 83 d0 00 00 00 85 c0 74 06 53 ff 
Oct 13 02:17:45 arwen kernel: Kernel logging (proc) stopped.

Stig
-- 
brautaset.org
