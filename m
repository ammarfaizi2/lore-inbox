Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbTHZGEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTHZGEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:04:12 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:39430 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262890AbTHZGEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:04:07 -0400
Date: Tue, 26 Aug 2003 15:03:31 +0900 (JST)
Message-Id: <20030826.150331.102449369.yoshfuji@linux-ipv6.org>
To: sebek64@post.cz
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [OOPS] less /proc/net/igmp
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030825163206.GA1340@penguin.penguin>
References: <20030825163206.GA1340@penguin.penguin>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <20030825163206.GA1340@penguin.penguin> (at Mon, 25 Aug 2003 18:32:06 +0200), Marcel Sebek <sebek64@post.cz> says:

> This Oops appears on 2.5.74+ kernels (including 2.6.0-test4) when
> I'm trying to read /proc/net/igmp with 'less', 'cat' displays
> the file content without oops:
:
> [snip]
>  ...
> bash# mount /proc
> bash# cat /proc/net/igmp
> Idx	Device    : Count Querier	Group    Users Timer	Reporter
> bash# less /proc/net/igmp
> Idx	Device    : Count Querier	Group    Users Timer	Reporter
> bash# ifup -a
> bash# cat /proc/net/igmp
> Idx	Device    : Count Querier	Group    Users Timer	Reporter
> 1	lo        :     0      V2
> 				010000E0     1 0:FFFA22F0		0
> bash# less /proc/net/igmp
> Unable to handle kernel paging request at virtual address 08051be0
>  printing eip:
> 08051be0
> *pde = 0fb66067
> *pfe = 00000000
> Oops: 0004 [#1]
> CPU:    0
> EIP:    0073:[<08051be0>]    Not tainted
> EFLAGS: 00010246
> EIP is at 0x8051be0
> eax: 0805fb68   ebx: 00000001   ecx: 00000000   edx: 00000019
> esi: 08060649   edi: 08057543   ebp: bffffd8c   esp: bfffda50
> ds: 007b   es: 007b   ss: 007b
> Process less (pid 20, threadinfo = cfab6000 task = c13560cd)
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing

I could not reproduce this issue.  anyone?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
