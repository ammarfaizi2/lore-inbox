Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSKNSWZ>; Thu, 14 Nov 2002 13:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSKNSWZ>; Thu, 14 Nov 2002 13:22:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47014 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261573AbSKNSWX>;
	Thu, 14 Nov 2002 13:22:23 -0500
Date: Thu, 14 Nov 2002 10:23:40 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Thorsten Mika <tmika@t-online.de>, <linux-kernel@vger.kernel.org>
Subject: Re: system lockups and shutdowns fo running processes
In-Reply-To: <Pine.LNX.3.95.1021114132125.13043A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33L2.0211141022050.3457-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Richard B. Johnson wrote:

| On Thu, 14 Nov 2002, Thorsten Mika wrote:
|
| > "Randy.Dunlap" <rddunlap@osdl.org> schrieb:
| >
| > > On Thu, 14 Nov 2002, Thorsten Mika wrote:
| >
| > [output of dmesg]
| >
| > >
| > > Please run that Oops text thru ksymoops so that it makes some sense.
| >
| >
| > here it is:
| > 8139too Fast Ethernet driver 0.9.22
| > CPU:    0
| > EIP:    0010:[<c3130187>]    Not tainted
| > Using defaults from ksymoops -t elf32-i386 -a i386
| > EFLAGS: 00013206
| > eax: 00000008   ebx: 00000001   ecx: c2059920   edx: 00001000
| > esi: c2059920   edi: 0000000a   ebp: 00000005   esp: c116bf30
| > ds: 0018   es: 0018   ss: 0018
| > Process kupdated (pid: 7, stackpage=c116b000)
| > Stack: c2059920 c2059920 c0c8dce0 c012f5b4 c2059920 c116a000 c0211a17
| > c116a24b
| >        0008e000 00000036 c19c0a40 c340b740 c32bd840 c38ee740 c18b0ea0
| > c2ff2500
| >        c3e95d80 c3a25d20 c11cc8c0 c3a35aa0 c1ed4600 c1ed49c0 c3f530c0
| > c27b4600
| > Call Trace: [<c012f5b4>] [<c0131c47>] [<c0131eb5>] [<c010546c>]
| > Code: 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20
| >
|
| Yawn.  It's trying to execute data...
| <TAB><SPC><TAB><SPC><TAB><SPC>..........
| Possible stack overflow.

Yes, I saw the hex 20 07 20 07 20 07 ... and realized that it shouldn't
be executing there.  The question is "how did it get there?".

-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn

