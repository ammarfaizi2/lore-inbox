Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263057AbREaKBk>; Thu, 31 May 2001 06:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbREaKBa>; Thu, 31 May 2001 06:01:30 -0400
Received: from cnxt19932052.conexant.com ([199.191.32.52]:7183 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263057AbREaKBR>; Thu, 31 May 2001 06:01:17 -0400
Date: Thu, 31 May 2001 12:01:05 +0200 (CEST)
From: <rui.sousa@mindspeed.com>
X-X-Sender: <rsousa@localhost.localdomain>
To: David Raufeisen <david@fortyoz.org>
cc: <linux-kernel@vger.kernel.org>, <bpringle@sympatico.ca>,
        <emu10k1-devel@opensource.creative.com>
Subject: Re: how to crash 2.4.4 w/SBLive
In-Reply-To: <20010524114219.B21442@fortyoz.org>
Message-ID: <Pine.LNX.4.33.0105311157430.17958-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1610194253-991303265=:17958"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1610194253-991303265=:17958
Content-Type: TEXT/PLAIN; charset=US-ASCII


Thank you for the trace. Patch attached, please test it out.

Rui Sousa

P.S: in the future always CC emu10k1-devel, or instead of a 7 day delay in
getting something fixed the message might just get lost.

On Thu, 24 May 2001, David Raufeisen wrote:

> May 24 10:58:05 prototype kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> May 24 10:58:05 prototype kernel:  printing eip:
> May 24 10:58:05 prototype kernel: c01bcb40
> May 24 10:58:05 prototype kernel: *pde = 00000000
> May 24 10:58:05 prototype kernel: Oops: 0002
> May 24 10:58:05 prototype kernel: CPU:    0
> May 24 10:58:05 prototype kernel: EIP:    0010:[emu10k1_timer_uninstall+48/240]
> May 24 10:58:05 prototype kernel: EFLAGS: 00210097
> May 24 10:58:05 prototype kernel: eax: 00000000   ebx: ffffffff   ecx: c1c68a78   edx: 00000000
> May 24 10:58:05 prototype kernel: esi: c1254070   edi: c1250000   ebp: 00200097   esp: c1c4bf34
> May 24 10:58:05 prototype kernel: ds: 0018   es: 0018   ss: 0018
> May 24 10:58:05 prototype kernel: Process cat (pid: 378, stackpage=c1c4b000)
> May 24 10:58:05 prototype kernel: Stack: c1c68a00 c1250000 c1cb1300 c1c4a000 c1250000 c01b8b8b c1250000 c1c68a78
> May 24 10:58:05 prototype kernel:        c1cb1300 c1c68a00 c1250000 c01b8b36 c1cb1300 00200246 c1c68a00 00001000
> May 24 10:58:05 prototype kernel:        c01b541f c1cb1300 c1ca58c0 ffffffea 00000000 00001000 00001000 00000000
> May 24 10:58:05 prototype kernel: Call Trace: [emu10k1_waveout_close+27/64] [emu10k1_waveout_open+102/160] [emu10k1_audio_write+207/464] [sys_write+150/208] [system
> _call+51/56]
>
>

--8323328-1610194253-991303265=:17958
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0105311201050.17958@localhost.localdomain>
Content-Description: emu10k1 patch
Content-Disposition: attachment; filename=patch

SW5kZXg6IGF1ZGlvLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBm
aWxlOiAvdXNyL2xvY2FsL2N2c3Jvb3QvZW11MTBrMS9hdWRpby5jLHYNCnJl
dHJpZXZpbmcgcmV2aXNpb24gMS4xNjYNCmRpZmYgLXUgLXIxLjE2NiBhdWRp
by5jDQotLS0gYXVkaW8uYwkyMDAxLzA0LzIyIDE1OjQ0OjI1CTEuMTY2DQor
KysgYXVkaW8uYwkyMDAxLzA1LzMxIDA4OjQ3OjI1DQpAQCAtMTIzMSw2ICsx
MjMxLDcgQEANCiAJCXdvaW5zdC0+YnVmZmVyLm9zc2ZyYWdzaGlmdCA9IDA7
DQogCQl3b2luc3QtPmJ1ZmZlci5udW1mcmFncyA9IDA7DQogCQl3b2luc3Qt
PmRldmljZSA9IChjYXJkLT5hdWRpb19kZXYxID09IG1pbm9yKTsNCisJCXdv
aW5zdC0+dGltZXIuc3RhdGUgPSBUSU1FUl9TVEFURV9VTklOU1RBTExFRDsN
CiANCiAJCWluaXRfd2FpdHF1ZXVlX2hlYWQoJndvaW5zdC0+d2FpdF9xdWV1
ZSk7DQogDQo=
--8323328-1610194253-991303265=:17958--
