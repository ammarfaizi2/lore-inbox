Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUCLRXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUCLRXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:23:31 -0500
Received: from mill.mtholyoke.edu ([138.110.30.76]:26500 "EHLO
	mill.mtholyoke.edu") by vger.kernel.org with ESMTP id S262339AbUCLRX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:23:27 -0500
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Fri, 12 Mar 2004 12:23:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: network/performance problem
Message-ID: <20040312172301.GA18159@mtholyoke.edu>
References: <20040311152728.GA11472@mtholyoke.edu> <20040311151559.72706624.akpm@osdl.org> <20040311233525.GA14065@mtholyoke.edu> <20040312164704.GA17969@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312164704.GA17969@mtholyoke.edu>
User-Agent: Mutt/1.3.28i
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 12, 2004 at 11:47:04AM -0500, rpeterso wrote:

> On sam, I just did:
> 
> 1002# cat /proc/net/ip_conntrack > ip_conntrack
> 
> ..and it wiped the machine out.  I can't ping it, ssh to it, nothing.  I
> need to go walk over to the machine room...  :(

I rebooted, and did the exact same thing as above.  Here's what the
console says:

Unable to handle kernel NULL pointer dereference at virtual address 00000018
 printint eip:
c024aae5
*pde = 00000000
Ooops: 0000
CPU:     0
EIP:     0010:[<c024aaae5>]    Not tainted
EFLAGS: 00010286
eax: 00000000  ebx: deb00440  ecx: ddad71d1  edx: e089b000
esi: deb00440  edi: ddad71d2  ebp: 0000002d  esp: ddb4df3c
dsd: 0018  es: 0018  ss: 0018
Process cat (pid: 365, stackpage=ddb4d000)
Stack: deb00440 000001d2 000001d2 c024ad1a ddad71d2 deb00440 00000000 00000c00
       ddad7000 00001000 00000ff6 c014af9f ddad7000 ddb4df98 00000029 00000c00
       00000000 ddafe3c0 ffffffea 00001000 c196dce0 00000000 00000000 00000000
Call Trace:  [<c024ad1a>] [<c014af9f>] [<c012f936>] [c0106c03>]

Code: 83 78 18 00 74 3a 83 7e 2c 00 74 1f a1 44 3c 32 c0 8b 56 34
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


...whew.  Hopefully not too many typos.. ;) After I reboot again, I'll
probably find this all got syslogged..


-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
