Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281682AbRKZNxx>; Mon, 26 Nov 2001 08:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281690AbRKZNxn>; Mon, 26 Nov 2001 08:53:43 -0500
Received: from mail.2d3d.co.za ([196.14.185.200]:63391 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S281682AbRKZNxb>;
	Mon, 26 Nov 2001 08:53:31 -0500
Date: Mon, 26 Nov 2001 15:56:33 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.4.16-pre1 file system bug
Message-ID: <20011126155633.A370@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.16-pre1 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 3:54pm  up 1 min,  2 users,  load average: 0.84, 0.31, 0.11
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I mounted 2 vxfs (Veritas / SCO UnixWare) partitions and typed ls in the
mounted directories. This is the result:

------------< snip <------< snip <------< snip <------------
root@crystal:/SCO# ls 0
kernel BUG at buffer.c:2397!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0130c61>]    Not tainted
EFLAGS: 00010282
eax: 0000001d   ebx: 00000003   ecx: c0272080   edx: 00001ebc
esi: 00000001   edi: 00000349   ebp: 000147cc   esp: d2625d58
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 293, stackpage=d2625000)
Stack: c022d94c 0000095d 00000349 00000001 000147cc 00000400 0000331a c012f2bb
       00000349 000147cc 00000001 000017a4 00000008 00000000 c012f484 00000349
       000147cc 00000001 c153ac00 c0158b43 00000349 000147cc 00000001 d26561fc
Call Trace: [<c012f2bb>] [<c012f484>] [<c0158b43>] [<c0158f0a>] [<c0159bf1>]
   [<c012fdd8>] [<c01291bf>] [<c0121e68>] [<c0159c27>] [<c0159bdc>] [<c0124058>]
   [<c0159b6f>] [<c0159c18>] [<c015928b>] [<c0159474>] [<c013ed8b>] [<c013ef96>]
   [<c0159737>] [<c01359bb>] [<c013603e>] [<c013573d>] [<c013629a>] [<c0136651>]
   [<c013392d>] [<c0106b2b>]

Code: 0f 0b 83 c4 08 8b 44 24 20 05 00 fe ff ff 3d 00 0e 00 00 76
 Segmentation fault
root@crystal:/SCO#
root@crystal:~/BUG# grep c012f /proc/ksyms
c012f374 mark_buffer_dirty
c012f348 __mark_buffer_dirty
c012f294 getblk
c012f46c bread
c012f424 __brelse
c012f444 __bforget
c012fd00 block_read_full_page
c012fec4 cont_prepare_write
c012f414 refile_buffer
c012f04c fsync_inode_data_buffers
c012f3a4 set_buffer_flushtime
c012f54c put_unused_buffer_head
c012f55c get_unused_buffer_head
c012f5d4 set_bh_page
c012f82c create_empty_buffers
------------< snip <------< snip <------< snip <------------

-- 

Regards
 Abraham

interlard - vt., to intersperse; diversify
-- Webster's New World Dictionary Of The American Language

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa

