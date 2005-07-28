Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVG1JD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVG1JD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVG1JD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:03:26 -0400
Received: from tornado.reub.net ([202.89.145.182]:39083 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261386AbVG1JDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:03:12 -0400
Message-ID: <42E89F4C.5010507@reub.net>
Date: Thu, 28 Jul 2005 21:03:08 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mail/News 1.0+ (Windows/20050727)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
References: <fa.gdh870p.1pmsr31@ifi.uio.no>
In-Reply-To: <fa.gdh870p.1pmsr31@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2005 9:45 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm2/
> 
> 
> - Lots of fixes and updates all over the place.  There are probably over 100
>   patches here which need to go into 2.6.13.
> 
> - A reminder that -mm commit activity may be monitored by subscribing to
>   the mm-commits list.  Do
> 
> 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
> 

Also seeing this during boot-up:

Adding 497972k swap on /dev/sda7.  Priority:1 extents:1 across:497972k
Adding 497972k swap on /dev/sdb7.  Priority:1 extents:1 across:497972k
Unable to handle kernel paging request at virtual address 00316173
  printing eip:
00316173
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file:
Modules linked in: binfmt_misc reiser4 zlib_deflate zlib_inflate dm_mod video 
thermal processor hotkey fan button ac i8xx_tco i2c_i8
01
CPU:    0
EIP:    0060:[<00316173>]    Not tainted VLI
EFLAGS: 00010202   (2.6.13-rc3-mm2)
EIP is at 0x316173
eax: dfc05d24   ebx: dfc05d24   ecx: 00316173   edx: de870000
esi: de870000   edi: dfc05d2c   ebp: df4e5f3c   esp: df4e5f30
ds: 007b   es: 007b   ss: 0068
Process udev (pid: 1141, threadinfo=df4e4000 task=df24ea50)
Stack: c02135a7 dfc6f0e8 c037edf4 df4e5f54 c018b5c3 de5d2bec dfc6f0e8 dfc8b1ec
        00001000 df4e5f74 c018b6fe df989030 080659b0 dfc6f0fc dfc8b1ec 00001000
        c018b6b8 df4e5f94 c0157c8f df4e5fa0 080659b0 00000000 dfc8b1ec fffffff7
Call Trace:
  [<c0103983>] show_stack+0x94/0xca
  [<c0103b37>] show_registers+0x165/0x1f9
  [<c0103d5d>] die+0x108/0x183
  [<c0318c3a>] do_page_fault+0x1ea/0x63d
  [<c0103657>] error_code+0x4f/0x54
  [<c018b5c3>] fill_read_buffer+0x2e/0x74
  [<c018b6fe>] sysfs_read_file+0x46/0x76
  [<c0157c8f>] vfs_read+0x8a/0x146
  [<c0157fd7>] sys_read+0x3d/0x64
  [<c0102ae7>] sysenter_past_esp+0x54/0x75
Code:  Bad EIP value.
  <6>NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver

The machine continues on booting..

reuben

