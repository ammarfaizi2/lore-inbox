Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131171AbRCGUHd>; Wed, 7 Mar 2001 15:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131174AbRCGUHY>; Wed, 7 Mar 2001 15:07:24 -0500
Received: from petem.xs4all.nl ([194.109.247.92]:49419 "EHLO q.petem.xs4all.nl")
	by vger.kernel.org with ESMTP id <S130253AbRCGUHL>;
	Wed, 7 Mar 2001 15:07:11 -0500
Date: Wed, 7 Mar 2001 21:06:41 +0100 (CET)
From: Peter Mottram <petem@xs4all.nl>
X-X-Sender: <apm@r6.petem.xs4all.nl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: OOPS: kernel BUG at slabc:1095! [was: 2.4.x total system crash -
 nooops (SCSI problems?)]
In-Reply-To: <3AA3F938.474E2207@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0103072048020.841-100000@r6.petem.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Jeff Garzik wrote:

> Is it possible to get addition information, using the vmdump patch?
> http://oss.sgi.com/projects/lkcd/
>

vmdump patch added but system locked up before managing to crash dump. I
have managed to get an OOPS though.....   :-)

trying a simple:

# scanimage

i get.........

(SCSI0:6:0) cannot abort running or disconnected command
Unable to handle kernel null pointer dereference at virtual address
00000008
 printing eip:
c01c87de
*pde = 00000000
Oops : 0000
CPU : 1
EIP : 0010:[<c01c87de>]
EFLAGS: 00010282
eax: 00000000 ebx: dfe5bdcc ecx: dc19be20 edx: 0000005d
esi: c18aa000 edi: 00000282 epb: 00000002 esp: dffedeb4
ds: 0018 es: 0018 ss: 0018
Process swapper (pid:0, stackpage=dffed000)
Stack= c01c93a0 dfe5bdcc c18aa000 00000000 c02cce78 c18aa118 c01cb156 c18aa000
       00000002 c0326d50 00000000 c030ec60 c18aa0a8 000036da c01c8f70 c18aa000
       dffedf0c dffedf0c c011b66c 00000000 00000009 00000020 c0326d60 c0326d60
Call Trace: [<c01c93a0>] [<c01cb156>] [<c01c8f70>] [<c011b66c>]
[<c011e3da>] [<c011b561>] [<c011b447>] [<c011b2ec>] [<c010a905>]
[<c0107170>] [<c0107170>] [<c010901c>] [<c0107170>] [<c0107170>]
[<c0100018>] [<c010719c>] [<c0107202>] [<c0202e07>] [<c0195ace>]
Code: 8b 48 08 85 c9 74 09 f0 ff 01 0f 8e f9 ee 07 00 c3 90 83 ec
Dumping to device 0x802 [sd(8,2)]....kernel BUG at slab.c:1095!


And that's all folks (I think I typed that all in correctly).

Anyone want any more info?

Regards
PeteM

