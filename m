Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129160AbRBMSpO>; Tue, 13 Feb 2001 13:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRBMSpE>; Tue, 13 Feb 2001 13:45:04 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:60427 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129032AbRBMSov>; Tue, 13 Feb 2001 13:44:51 -0500
Message-ID: <3A896CB5.82BD1ADC@programmfabrik.de>
Date: Tue, 13 Feb 2001 18:19:49 +0100
From: Martin Rode <Martin.Rode@programmfabrik.de>
Organization: Programmfabrik GmbH
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-9mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: BUG in sched.c, Kernel 2.4.1?
In-Reply-To: <3A8942FA.484BE2FC@programmfabrik.de> <3A8944F1.93C252EB@didntduck.org> <3A895194.89D69AE9@programmfabrik.de> <3A8956E9.402D0136@didntduck.org>
Content-Type: multipart/mixed;
 boundary="------------E2993B8F972F82382F81FCEF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E2993B8F972F82382F81FCEF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Re-ran ksymoops:

; Martin



kernel BUG at sched.c:714!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c0113781>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b ebx 00000000 ecx df4f6000 edx 00000001
esi: 001cffe3 edi db5eede0 ebp dc0e9f40 esp dc0e9ef0
stack: c01f26f3 c01f2856 000002ca db5eed80 dc0e8000 db5eede0 dc0e9f18
dc0e8000 000033ba 00000000 00000000 000000e7 0000001c 0000001c
fffffff3 dc0e8000 00000800 00000000 dc0e8000 dc0e9f68 c0139c44
d488bf80 00000000
call trace: [<c0139c44>] [<c0139d1c>] [<c0130af6>] [<c0108e93>]
code: 0f 0b 8d 65 bc 5b 5e 5f 89 ec 5d c3 8d 76 00 55 89 e5 83 ec

>>EIP; c0113781 <schedule+421/430>   <=====
Trace; c0139c44 <pipe_wait+44/9c>
Trace; c0139d1c <pipe_read+80/238>
Trace; c0130af6 <sys_read+5e/c4>
Trace; c0108e93 <system_call+33/40>
Code;  c0113781 <schedule+421/430>
00000000 <_EIP>:
Code;  c0113781 <schedule+421/430>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0113783 <schedule+423/430>
   2:   8d 65 bc                  lea    0xffffffbc(%ebp),%esp
Code;  c0113786 <schedule+426/430>
   5:   5b                        pop    %ebx
Code;  c0113787 <schedule+427/430>
   6:   5e                        pop    %esi
Code;  c0113788 <schedule+428/430>
   7:   5f                        pop    %edi
Code;  c0113789 <schedule+429/430>
   8:   89 ec                     mov    %ebp,%esp
Code;  c011378b <schedule+42b/430>
   a:   5d                        pop    %ebp
Code;  c011378c <schedule+42c/430>
   b:   c3                        ret
Code;  c011378d <schedule+42d/430>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0113790 <__wake_up+0/9c>
   f:   55                        push   %ebp
Code;  c0113791 <__wake_up+1/9c>
  10:   89 e5                     mov    %esp,%ebp
Code;  c0113793 <__wake_up+3/9c>
  12:   83 ec 00                  sub    $0x0,%esp

Kernel panic: Aiee, killing interrupt handler!

971 warnings and 5 errors issued.  Results may not be reliable.
--------------E2993B8F972F82382F81FCEF
Content-Type: text/x-vcard; charset=iso-8859-1;
 name="Martin.Rode.vcf"
Content-Transfer-Encoding: base64
Content-Description: Card for Martin Rode
Content-Disposition: attachment;
 filename="Martin.Rode.vcf"

YmVnaW46dmNhcmQgCm46Um9kZTtNYXJ0aW4KdGVsO2NlbGw6KzQ5LTE3MS0xMjU5NTI1CnRl
bDtmYXg6KzQ5LTMwLTQyODEtODAwOAp0ZWw7d29yazorNDktMzAtNDI4MS04MDAxCngtbW96
aWxsYS1odG1sOlRSVUUKdXJsOnd3dy5wcm9ncmFtbWZhYnJpay5kZS9+bWFydGluCm9yZzpQ
cm9ncmFtbWZhYnJpayBHbWJIO0VudHdpY2tsdW5nCmFkcjo7O0ZyYW5rZnVydGVyIEFsbGVl
IDczZDsxMDI0NyBCZXJsaW47OztHZXJtYW55CnZlcnNpb246Mi4xCmVtYWlsO2ludGVybmV0
Ok1hcnRpbi5Sb2RlQHByb2dyYW1tZmFicmlrLmRlCnRpdGxlOkRpcGwuLUtmbS4KeC1tb3pp
bGxhLWNwdDo7LTI4OTYwCmZuOk1hcnRpbiBSb2RlCmVuZDp2Y2FyZAo=
--------------E2993B8F972F82382F81FCEF--

