Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318093AbSHLOuT>; Mon, 12 Aug 2002 10:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSHLOuT>; Mon, 12 Aug 2002 10:50:19 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:35515 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S318093AbSHLOuS>; Mon, 12 Aug 2002 10:50:18 -0400
Date: Mon, 12 Aug 2002 16:53:16 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: VMA Merging
Message-Id: <20020812165316.2701fc00.us15@os.inf.tu-dresden.de>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a program which mmap's 320 MB from a file into memory in 4 KB chunks,
like this....

00002000-00003000 rw-s 00002000 03:46 688        /tmp/physmem (deleted)
00003000-00004000 rw-s 00003000 03:46 688        /tmp/physmem (deleted)
00004000-00005000 rw-s 00004000 03:46 688        /tmp/physmem (deleted)
00005000-00006000 rw-s 00005000 03:46 688        /tmp/physmem (deleted)
00006000-00007000 rw-s 00006000 03:46 688        /tmp/physmem (deleted)
00007000-00008000 rw-s 00007000 03:46 688        /tmp/physmem (deleted)
00008000-00009000 rw-s 00008000 03:46 688        /tmp/physmem (deleted)
00009000-0000a000 rw-s 00009000 03:46 688        /tmp/physmem (deleted)
0000a000-0000b000 rw-s 0000a000 03:46 688        /tmp/physmem (deleted)
0000b000-0000c000 rw-s 0000b000 03:46 688        /tmp/physmem (deleted)
0000c000-0000d000 rw-s 0000c000 03:46 688        /tmp/physmem (deleted)
0000d000-0000e000 rw-s 0000d000 03:46 688        /tmp/physmem (deleted)
0000e000-0000f000 rw-s 0000e000 03:46 688        /tmp/physmem (deleted)
0000f000-00010000 rw-s 0000f000 03:46 688        /tmp/physmem (deleted)
00010000-00011000 rw-s 00010000 03:46 688        /tmp/physmem (deleted)
00011000-00012000 rw-s 00011000 03:46 688        /tmp/physmem (deleted)
00012000-00013000 rw-s 00012000 03:46 688        /tmp/physmem (deleted)

The problem is that after 320 MB the program exceeds the maximum number
of 65536 VMA mappings. Why doesn't the kernel merge adjacent VMA's?

Regards,
-Udo.
