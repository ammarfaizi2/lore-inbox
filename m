Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRBYNWV>; Sun, 25 Feb 2001 08:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbRBYNWM>; Sun, 25 Feb 2001 08:22:12 -0500
Received: from colorfullife.com ([216.156.138.34]:41998 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129084AbRBYNV4>;
	Sun, 25 Feb 2001 08:21:56 -0500
Message-ID: <3A9906D1.70BDAAD8@colorfullife.com>
Date: Sun, 25 Feb 2001 14:21:21 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: john@grulic.org.ar
CC: linux-kernel@vger.kernel.org
Subject: oops followed by "kernel BUG"s
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When I woke today I found I'd gotten the following oops,
>
> kernel: EIP:    0010:[bdput+5/96]
> Code;  <_EIP>:
> 0:   f0 ff 4b 08 lock decl 0x8(%ebx)
> Call Trace: [clear_inode+194/220] 
>         [dispose_list+59/84]
>
> kernel: eax: 00020000   ebx: 00020000   ecx: ca58a648  edx: c15ddfa4
                                  ^
A single bit error: inode->i_bdev was 00000000, and overnight one bit
changed.

It's a hardware problem - cpu overheating, power spike, overclocked cpu,
bad memory.

--
	Manfred
