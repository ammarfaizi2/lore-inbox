Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153888AbQBEBeC>; Fri, 4 Feb 2000 20:34:02 -0500
Received: by vger.rutgers.edu id <S153890AbQBEBdj>; Fri, 4 Feb 2000 20:33:39 -0500
Received: from front5m.grolier.fr ([195.36.216.55]:46677 "EHLO front5m.grolier.fr") by vger.rutgers.edu with ESMTP id <S153885AbQBEBdO>; Fri, 4 Feb 2000 20:33:14 -0500
Message-ID: <389BB4FE.26ED416F@mime.univ-paris8.fr>
Date: Sat, 05 Feb 2000 06:28:30 +0100
From: Whygee <whygee@mime.univ-paris8.fr>
Reply-To: whygee@mime.univ-paris8.fr
Organization: The Whygee Corporation  <http://www.mime.univ-paris8.fr/~whygee/sharcpage.html>
X-Mailer: Mozilla 4.51 [en] (Win95; I)
X-Accept-Language: en,fr
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: the F-CPU project
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hello,

someone told me that there are competent people here.
if that's true, that's cool.

The F-CPU project (where F stands for your freedom)
is an "Open IP" (IP=Intellectual Property, not Internet Protocol)
project for the development of a CPU distributed with the GPL.
The distribution scheme can be almost the same a GNU/LINUX.

some details !
- 64 registers
- SIMD-oriented
- pure RISC (and even more than MIPS)
- support of floating point, fractional and logarithmic data formats
    in the instruction set
- aimed at performance and scalability (in data width, superscalarism etc)
- onchip support for virtual memory
- smart hinting capabilities, smart memory prefetching,
  "smooth register backup" (SRB) mechanism etc...

it's NOT a toy computer. it is NOT a DLX or MMIX rip-off. it is NOT even a joke.

i'm now working on the prototype chip, it will be an ASIC made with ChipExpress
technology (http://www.chipx.com) in .35u.
- 128 bit wide direct SDRAM bus
- 64-bit implementation (32-bit min, no upper limit)
- very short stages pipeline (or "superpipeline" if you don't get it)
- one instruction issued per cycle (to begin slowly but simple)
- Register set is 3 read / 2 write ports
- no exception in the execution pipeline : traps are "clean" (unlike PPC)
   and there's no restart penalty
- separate (tiny) data and instruction caches with 256-bit wide lines
- 32 page table entries (4 sizes * 8 entries)
- 8 memory buffers that cache the cache memory itself to speedup
    all the memory related operations and benefit from the SDRAM architecture
- "out of order completion" pipeline where the instructions can take a
    variable number of cycles to complete/write back the result to the
    register set (scoreboard/scheduler technique is used)

Now if there's something you don't like, or if you have fallen in love, or
simply want to say hi, drop a mail at http://www.egroups.com/list/f-cpu/
but read the manual before !!! http://www.mime.univ-paris8.fr/~whygee/fcpu_manual.zip
http://www.mime.univ-paris8.fr/~whygee/f-cpu.html is the personal page
and http://www.f-cpu.de is the official site (but always lagging...)

Now the current problem is to get funded : an ASIC is rather expensive,
like more than $100K. no kidding. So if you know companies that can make
some rebates on HW and help us develop the prototype/proof of concept chip,
don't hesitate to get in touch with me : i'm fed up making the efforts alone
in France. the more i do and the less the others move. please give us some fresh
and optimistic blood or i'll core dump...

later,
WHYGEE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SHARCPAGE: http://www.mime.univ-paris8.fr/~whygee/sharcpage.html

PS: i'm not subsribed here, so if you want to contact me don't post to the list...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
