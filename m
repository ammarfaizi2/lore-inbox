Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274305AbRJTUZT>; Sat, 20 Oct 2001 16:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274362AbRJTUZJ>; Sat, 20 Oct 2001 16:25:09 -0400
Received: from radium.jvb.tudelft.nl ([130.161.76.91]:37894 "HELO
	radium.jvb.tudelft.nl") by vger.kernel.org with SMTP
	id <S274305AbRJTUZF>; Sat, 20 Oct 2001 16:25:05 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.12
Date: Sat, 20 Oct 2001 22:26:31 +0200
Message-ID: <003f01c159a5$810cf330$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today I found this oops in my logs. The oops originated from a smbd
process (Samba 2.0.9 stable). Earlier kernels (except for pre-kernels)
never gave me problems. 2.4.10 was the previous used kernel on the
system and did not give any oops for about the 2 weeks it ran on this
system. The system did not crash after this oops. Can someone make more
out of than I can, or point me to a possible bug(fix) that is related?

Oct 20 16:47:00 lion kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000008
Oct 20 16:47:00 lion kernel:  printing eip:
Oct 20 16:47:00 lion kernel: c0132a83
Oct 20 16:47:00 lion kernel: *pde = 00000000
Oct 20 16:47:00 lion kernel: Oops: 0000
Oct 20 16:47:00 lion kernel: CPU:    0
Oct 20 16:47:00 lion kernel: EIP:    0010:[sys_newstat+35/112]    Not
tainted
Oct 20 16:47:00 lion kernel: EFLAGS: 00010246
Oct 20 16:47:00 lion kernel: eax: 00000000   ebx: 00000000   ecx:
df981c60   edx: 00000000
Oct 20 16:47:00 lion kernel: esi: d9583fa4   edi: 08111c60   ebp:
bfffe1fc   esp: d9583f9c
Oct 20 16:47:00 lion kernel: ds: 0018   es: 0018   ss: 0018
Oct 20 16:47:00 lion kernel: Process smbd (pid: 17565,
stackpage=d9583000)
Oct 20 16:47:00 lion kernel: Stack: d9582000 bffff2c4 00000000 c180e420
08174f38 c012cca7 d1d78a60 00000009 
Oct 20 16:47:00 lion kernel:        00000001 c0106b63 08111c60 bfffe1bc
bfffeb30 bffff2c4 08111c60 bfffe1fc 
Oct 20 16:47:00 lion kernel:        0000006a c010002b 0000002b 0000006a
4010418d 00000023 00000202 bfffe1a0 
Oct 20 16:47:00 lion kernel: Call Trace: [sys_close+67/84]
[system_call+51/64] 
Oct 20 16:47:00 lion kernel: 
Oct 20 16:47:00 lion kernel: Code: 8b 42 08 8b 80 90 00 00 00 85 c0 74
11 8b 40 34 85 c0 74 0a 


Regards,
- Robbert Kouprie, Linux Systems Admin, The Netherlands

