Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbREHL6L>; Tue, 8 May 2001 07:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbREHL6C>; Tue, 8 May 2001 07:58:02 -0400
Received: from pcow025o.blueyonder.co.uk ([195.188.53.125]:32261 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S131949AbREHL5u>;
	Tue, 8 May 2001 07:57:50 -0400
Message-ID: <3AF7C732.C2072776@blueyonder.co.uk>
Date: Tue, 08 May 2001 11:15:14 +0100
From: gabriel finch <gfinch@blueyonder.co.uk>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "linuxkernel@blueyonder.co.uk" <linuxkernel@blueyonder.co.uk>
Subject: 2.4.4 rwsem make error, please somebody take a look !!
Content-Type: multipart/mixed;
 boundary="------------710C94ABA449CB087CE74E8F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------710C94ABA449CB087CE74E8F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

OK, second attempt, I got no replies the first time...



> 
> Hi.
> I patched 2.4.3 to 2.4.4 with the following commands:
> 
> cd /usr/src
> cp -r linux-2.4.3 linux-2.4.4
> ln -s linux-2.4.4 linux
> cd linux
> mv ../patch-2.4.4 .
> patch -p1 < patch-2.4.4
> 
> When I compiled bzImage (using .config from 2.2.3) I got the following
> errors:
> 
> arch/i386/kernel/kernel.o(.text.lock+0x20): undefined reference to
> `rwsem_down_write_failed'
> arch/i386/kernel/kernel.o(.text.lock+0x34): undefined reference to
> `rwsem_wake'
> arch/i386/kernel/kernel.o(.text.lock+0x40): undefined reference to
> `rwsem_down_write_failed'
> arch/i386/kernel/kernel.o(.text.lock+0x54): undefined reference to
> `rwsem_wake'
> arch/i386/kernel/kernel.o(.text.lock+0x60): undefined reference to
> `rwsem_down_write_failed'
> arch/i386/kernel/kernel.o(.text.lock+0x74): undefined reference to
> `rwsem_wake'
> arch/i386/kernel/kernel.o(.text.lock+0x81): undefined reference to
> `rwsem_down_read_failed'
> arch/i386/kernel/kernel.o(.text.lock+0x96): undefined reference to
> `rwsem_wake'
> arch/i386/kernel/kernel.o(.text.lock+0xa3): undefined reference to
> `rwsem_down_read_failed'
> arch/i386/kernel/kernel.o(.text.lock+0xb8): undefined reference to
> `rwsem_wake'
> arch/i386/mm/mm.o(.text.lock+0x3): undefined reference to
> `rwsem_down_read_failed'
> arch/i386/mm/mm.o(.text.lock+0x18): undefined reference to `rwsem_wake'
> arch/i386/mm/mm.o(.text.lock+0x2c): undefined reference to `rwsem_wake'
> arch/i386/mm/mm.o(.text.lock+0x40): undefined reference to `rwsem_wake'
> arch/i386/mm/mm.o(.text.lock+0x54): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0xc): undefined reference to
> `rwsem_down_write_failed'
> kernel/kernel.o(.text.lock+0x20): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0x41): undefined reference to
> `rwsem_down_read_failed'
> kernel/kernel.o(.text.lock+0x56): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0x62): undefined reference to
> `rwsem_down_write_failed'
> kernel/kernel.o(.text.lock+0x76): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0x83): undefined reference to
> `rwsem_down_read_failed'
> kernel/kernel.o(.text.lock+0x98): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0xa5): undefined reference to
> `rwsem_down_read_failed'
> kernel/kernel.o(.text.lock+0xba): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0xc7): undefined reference to
> `rwsem_down_read_failed'
> kernel/kernel.o(.text.lock+0xdc): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0xe8): undefined reference to
> `rwsem_down_write_failed'
> kernel/kernel.o(.text.lock+0xfc): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0x109): undefined reference to
> `rwsem_down_read_failed'
> kernel/kernel.o(.text.lock+0x11e): undefined reference to `rwsem_wake'
> kernel/kernel.o(.text.lock+0x12a): undefined reference to
> `rwsem_down_write_failed'
> kernel/kernel.o(.text.lock+0x13e): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x2): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x16): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x2a): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x36): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x4a): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x56): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x6a): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x8b): undefined reference to
> `rwsem_down_read_failed'
> mm/mm.o(.text.lock+0xa0): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0xac): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0xc0): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0xcd): undefined reference to
> `rwsem_down_read_failed'
> mm/mm.o(.text.lock+0xe2): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x102): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x116): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x122): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x136): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x142): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x156): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x162): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x176): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x182): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x196): undefined reference to `rwsem_wake'
> mm/mm.o(.text.lock+0x1a2): undefined reference to
> `rwsem_down_write_failed'
> mm/mm.o(.text.lock+0x1b6): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x98): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0xac): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x176): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0x18a): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x485): undefined reference to
> `rwsem_down_read_failed'
> fs/fs.o(.text.lock+0x49a): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x4a6): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0x4ba): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x4c6): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0x4da): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x4e6): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0x4fa): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x506): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0x51a): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x526): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0x53a): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x546): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0x55a): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x566): undefined reference to
> `rwsem_down_write_failed'
> fs/fs.o(.text.lock+0x57a): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x587): undefined reference to
> `rwsem_down_read_failed'
> fs/fs.o(.text.lock+0x59c): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x5a9): undefined reference to
> `rwsem_down_read_failed'
> fs/fs.o(.text.lock+0x5be): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x5cb): undefined reference to
> `rwsem_down_read_failed'
> fs/fs.o(.text.lock+0x5e0): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x5ed): undefined reference to
> `rwsem_down_read_failed'
> fs/fs.o(.text.lock+0x602): undefined reference to `rwsem_wake'
> fs/fs.o(.text.lock+0x60f): undefined reference to
> `rwsem_down_read_failed'
> fs/fs.o(.text.lock+0x624): undefined reference to `rwsem_wake'
> ipc/ipc.o(.text.lock+0xfc): undefined reference to
> `rwsem_down_write_failed'
> ipc/ipc.o(.text.lock+0x110): undefined reference to `rwsem_wake'
> ipc/ipc.o(.text.lock+0x130): undefined reference to
> `rwsem_down_write_failed'
> ipc/ipc.o(.text.lock+0x144): undefined reference to `rwsem_wake'
> drivers/char/char.o(.text.lock+0x49): undefined reference to
> `rwsem_down_read_failed'
> drivers/char/char.o(.text.lock+0x5e): undefined reference to
> `rwsem_wake'
> drivers/char/char.o(.text.lock+0x72): undefined reference to
> `rwsem_wake'
> make: *** [vmlinux] Error 1
> 
> Any help would be greatly apprecited.
> 
> Please cc: linuxkernel@blueyonder.co.uk in any reply.
>
--------------710C94ABA449CB087CE74E8F
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3AF3EBF9.104C78F8@blueyonder.co.uk>
Date: Sat, 05 May 2001 13:03:05 +0100
From: gabriel <linuxkernel@blueyonder.co.uk>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "linuxkernel@blueyonder.co.uk" <linuxkernel@blueyonder.co.uk>
Subject: 2.4.4 rwsem make error
Content-Type: multipart/mixed;
 boundary="------------07710CE70B45CA505CF30BBA"

This is a multi-part message in MIME format.
--------------07710CE70B45CA505CF30BBA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi.
I patched 2.4.3 to 2.4.4 with the following commands:

cd /usr/src
cp -r linux-2.2.3 linux-2.2.4
ln -s linux-2.2.4 linux
cd linux
mv patch-2.2.4 .
patch -p1 < patch-2.2.4

When I compiled bzImage (using .config from 2.2.3) I got the following
errors:

arch/i386/kernel/kernel.o(.text.lock+0x20): undefined reference to
`rwsem_down_write_failed'
arch/i386/kernel/kernel.o(.text.lock+0x34): undefined reference to
`rwsem_wake'
arch/i386/kernel/kernel.o(.text.lock+0x40): undefined reference to
`rwsem_down_write_failed'
arch/i386/kernel/kernel.o(.text.lock+0x54): undefined reference to
`rwsem_wake'
arch/i386/kernel/kernel.o(.text.lock+0x60): undefined reference to
`rwsem_down_write_failed'
arch/i386/kernel/kernel.o(.text.lock+0x74): undefined reference to
`rwsem_wake'
arch/i386/kernel/kernel.o(.text.lock+0x81): undefined reference to
`rwsem_down_read_failed'
arch/i386/kernel/kernel.o(.text.lock+0x96): undefined reference to
`rwsem_wake'
arch/i386/kernel/kernel.o(.text.lock+0xa3): undefined reference to
`rwsem_down_read_failed'
arch/i386/kernel/kernel.o(.text.lock+0xb8): undefined reference to
`rwsem_wake'
arch/i386/mm/mm.o(.text.lock+0x3): undefined reference to
`rwsem_down_read_failed'
arch/i386/mm/mm.o(.text.lock+0x18): undefined reference to `rwsem_wake'
arch/i386/mm/mm.o(.text.lock+0x2c): undefined reference to `rwsem_wake'
arch/i386/mm/mm.o(.text.lock+0x40): undefined reference to `rwsem_wake'
arch/i386/mm/mm.o(.text.lock+0x54): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0xc): undefined reference to
`rwsem_down_write_failed'
kernel/kernel.o(.text.lock+0x20): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x41): undefined reference to
`rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0x56): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x62): undefined reference to
`rwsem_down_write_failed'
kernel/kernel.o(.text.lock+0x76): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x83): undefined reference to
`rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0x98): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0xa5): undefined reference to
`rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0xba): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0xc7): undefined reference to
`rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0xdc): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0xe8): undefined reference to
`rwsem_down_write_failed'
kernel/kernel.o(.text.lock+0xfc): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x109): undefined reference to
`rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0x11e): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x12a): undefined reference to
`rwsem_down_write_failed'
kernel/kernel.o(.text.lock+0x13e): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x2): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x16): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x2a): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x36): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x4a): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x56): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x6a): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x8b): undefined reference to
`rwsem_down_read_failed'
mm/mm.o(.text.lock+0xa0): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0xac): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0xc0): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0xcd): undefined reference to
`rwsem_down_read_failed'
mm/mm.o(.text.lock+0xe2): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x102): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x116): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x122): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x136): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x142): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x156): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x162): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x176): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x182): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x196): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x1a2): undefined reference to
`rwsem_down_write_failed'
mm/mm.o(.text.lock+0x1b6): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x98): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0xac): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x176): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0x18a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x485): undefined reference to
`rwsem_down_read_failed'
fs/fs.o(.text.lock+0x49a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x4a6): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0x4ba): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x4c6): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0x4da): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x4e6): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0x4fa): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x506): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0x51a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x526): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0x53a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x546): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0x55a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x566): undefined reference to
`rwsem_down_write_failed'
fs/fs.o(.text.lock+0x57a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x587): undefined reference to
`rwsem_down_read_failed'
fs/fs.o(.text.lock+0x59c): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x5a9): undefined reference to
`rwsem_down_read_failed'
fs/fs.o(.text.lock+0x5be): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x5cb): undefined reference to
`rwsem_down_read_failed'
fs/fs.o(.text.lock+0x5e0): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x5ed): undefined reference to
`rwsem_down_read_failed'
fs/fs.o(.text.lock+0x602): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x60f): undefined reference to
`rwsem_down_read_failed'
fs/fs.o(.text.lock+0x624): undefined reference to `rwsem_wake'
ipc/ipc.o(.text.lock+0xfc): undefined reference to
`rwsem_down_write_failed'
ipc/ipc.o(.text.lock+0x110): undefined reference to `rwsem_wake'
ipc/ipc.o(.text.lock+0x130): undefined reference to
`rwsem_down_write_failed'
ipc/ipc.o(.text.lock+0x144): undefined reference to `rwsem_wake'
drivers/char/char.o(.text.lock+0x49): undefined reference to
`rwsem_down_read_failed'
drivers/char/char.o(.text.lock+0x5e): undefined reference to
`rwsem_wake'
drivers/char/char.o(.text.lock+0x72): undefined reference to
`rwsem_wake'
make: *** [vmlinux] Error 1



Any help would be greatly apprecited.

Please cc: linuxkernel@blueyonder in any reply.
--------------07710CE70B45CA505CF30BBA
Content-Type: text/plain; charset=us-ascii;
 name="output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="output.txt"

arch/i386/kernel/kernel.o(.text.lock+0x20): undefined reference to `rwsem_down_write_failed'
arch/i386/kernel/kernel.o(.text.lock+0x34): undefined reference to `rwsem_wake'
arch/i386/kernel/kernel.o(.text.lock+0x40): undefined reference to `rwsem_down_write_failed'
arch/i386/kernel/kernel.o(.text.lock+0x54): undefined reference to `rwsem_wake'
arch/i386/kernel/kernel.o(.text.lock+0x60): undefined reference to `rwsem_down_write_failed'
arch/i386/kernel/kernel.o(.text.lock+0x74): undefined reference to `rwsem_wake'
arch/i386/kernel/kernel.o(.text.lock+0x81): undefined reference to `rwsem_down_read_failed'
arch/i386/kernel/kernel.o(.text.lock+0x96): undefined reference to `rwsem_wake'
arch/i386/kernel/kernel.o(.text.lock+0xa3): undefined reference to `rwsem_down_read_failed'
arch/i386/kernel/kernel.o(.text.lock+0xb8): undefined reference to `rwsem_wake'
arch/i386/mm/mm.o(.text.lock+0x3): undefined reference to `rwsem_down_read_failed'
arch/i386/mm/mm.o(.text.lock+0x18): undefined reference to `rwsem_wake'
arch/i386/mm/mm.o(.text.lock+0x2c): undefined reference to `rwsem_wake'
arch/i386/mm/mm.o(.text.lock+0x40): undefined reference to `rwsem_wake'
arch/i386/mm/mm.o(.text.lock+0x54): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0xc): undefined reference to `rwsem_down_write_failed'
kernel/kernel.o(.text.lock+0x20): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x41): undefined reference to `rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0x56): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x62): undefined reference to `rwsem_down_write_failed'
kernel/kernel.o(.text.lock+0x76): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x83): undefined reference to `rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0x98): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0xa5): undefined reference to `rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0xba): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0xc7): undefined reference to `rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0xdc): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0xe8): undefined reference to `rwsem_down_write_failed'
kernel/kernel.o(.text.lock+0xfc): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x109): undefined reference to `rwsem_down_read_failed'
kernel/kernel.o(.text.lock+0x11e): undefined reference to `rwsem_wake'
kernel/kernel.o(.text.lock+0x12a): undefined reference to `rwsem_down_write_failed'
kernel/kernel.o(.text.lock+0x13e): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x2): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x16): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x2a): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x36): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x4a): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x56): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x6a): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x8b): undefined reference to `rwsem_down_read_failed'
mm/mm.o(.text.lock+0xa0): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0xac): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0xc0): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0xcd): undefined reference to `rwsem_down_read_failed'
mm/mm.o(.text.lock+0xe2): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x102): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x116): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x122): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x136): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x142): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x156): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x162): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x176): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x182): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x196): undefined reference to `rwsem_wake'
mm/mm.o(.text.lock+0x1a2): undefined reference to `rwsem_down_write_failed'
mm/mm.o(.text.lock+0x1b6): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x98): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0xac): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x176): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0x18a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x485): undefined reference to `rwsem_down_read_failed'
fs/fs.o(.text.lock+0x49a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x4a6): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0x4ba): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x4c6): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0x4da): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x4e6): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0x4fa): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x506): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0x51a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x526): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0x53a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x546): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0x55a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x566): undefined reference to `rwsem_down_write_failed'
fs/fs.o(.text.lock+0x57a): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x587): undefined reference to `rwsem_down_read_failed'
fs/fs.o(.text.lock+0x59c): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x5a9): undefined reference to `rwsem_down_read_failed'
fs/fs.o(.text.lock+0x5be): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x5cb): undefined reference to `rwsem_down_read_failed'
fs/fs.o(.text.lock+0x5e0): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x5ed): undefined reference to `rwsem_down_read_failed'
fs/fs.o(.text.lock+0x602): undefined reference to `rwsem_wake'
fs/fs.o(.text.lock+0x60f): undefined reference to `rwsem_down_read_failed'
fs/fs.o(.text.lock+0x624): undefined reference to `rwsem_wake'
ipc/ipc.o(.text.lock+0xfc): undefined reference to `rwsem_down_write_failed'
ipc/ipc.o(.text.lock+0x110): undefined reference to `rwsem_wake'
ipc/ipc.o(.text.lock+0x130): undefined reference to `rwsem_down_write_failed'
ipc/ipc.o(.text.lock+0x144): undefined reference to `rwsem_wake'
drivers/char/char.o(.text.lock+0x49): undefined reference to `rwsem_down_read_failed'
drivers/char/char.o(.text.lock+0x5e): undefined reference to `rwsem_wake'
drivers/char/char.o(.text.lock+0x72): undefined reference to `rwsem_wake'
make: *** [vmlinux] Error 1

--------------07710CE70B45CA505CF30BBA--



--------------710C94ABA449CB087CE74E8F--

