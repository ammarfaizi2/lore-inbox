Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSJQAEZ>; Wed, 16 Oct 2002 20:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbSJQAEZ>; Wed, 16 Oct 2002 20:04:25 -0400
Received: from tufnell.london1.poggs.net ([193.109.194.18]:13526 "EHLO
	tufnell.london1.poggs.net") by vger.kernel.org with ESMTP
	id <S261561AbSJQAEY>; Wed, 16 Oct 2002 20:04:24 -0400
Message-ID: <3DAE0047.3050900@POGGS.CO.UK>
Date: Thu, 17 Oct 2002 01:11:51 +0100
From: Peter Hicks <Peter.Hicks@POGGS.CO.UK>
Organization: Poggs Computer Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-gb, en-us, en-au, en-ie, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 - bug in page_alloc.c?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

I've had my system die with the follwing two messages in 'dmesg'.

Can anybody shed light on what's tipped over? The system wasn't under 
much load at the time.

If you need more info, just shout.  I'm not subscribed to the list, so 
cc'ing would be very much appreciated :)

Best wishes,


Peter.


kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013105d>]
EFLAGS: 00010286
eax: c11ff33c   ebx: c121dd24   ecx: d888e7e4   edx: c152d9c4
esi: 00000000   edi: 00000000   ebp: 0000015b   esp: db271edc
ds: 0018   es: 0018   ss: 0018
Process licq (pid: 2160, stackpage=db271000)
Stack: c021ebfc c100001c d888e7e4 d393285c 001be000 c0129270 d888e740 
00000004
       0015d000 d393285c 001be000 0000015b c01279f7 c121dd24 dbaa04c0 
c0129064
       dbaa04c0 c121dd24 08400000 c1b8a084 08278000 00000000 c012622b 
dbaa04c0
Call Trace:    [<c0129270>] [<c01279f7>] [<c0129064>] [<c012622b>] 
[<c0128f6f>]
  [<c01161b6>] [<c011ab6f>] [<c011ad53>] [<c0109007>]

Code: 0f 0b 5b 00 12 81 1f c0 8b 15 b0 93 26 c0 89 d8 29 d0 c1 f8


 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013105d>]
EFLAGS: 00013286
eax: 00000000   ebx: c121dd24   ecx: d888e7e4   edx: 00000000
esi: 00000000   edi: 00000000   ebp: d2167860   esp: df563ee4
ds: 0018   es: 0018   ss: 0018
Process rpciod (pid: 59, stackpage=df563000)
Stack: 00000000 3dadfd92 00001770 01d9dc37 00000000 00000000 00001770 
01d9dc37
       d2167860 d888e740 d888e8e4 d2167860 e08e0daf dd73c140 d2167860 
e08e62da
       d2167860 d14120f4 d21678b4 d1412208 e08e5caf d2167860 d1412190 
d14120a0
Call Trace:    [<e08e0daf>] [<e08e62da>] [<e08e5caf>] [<e08e9650>] 
[<e08bd0fe>]
  [<e08c062d>] [<c0114c5c>] [<e08c09e7>] [<e08c1271>] [<e08c11c0>] 
[<e08ca4a4>]
  [<e08ca4a4>] [<c010737e>] [<e08ca4ac>] [<e08c11c0>]

Code: 0f 0b 5b 00 12 81 1f c0 8b 15 b0 93 26 c0 89 d8 29 d0 c1 f8


