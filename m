Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSHNXMw>; Wed, 14 Aug 2002 19:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSHNXMw>; Wed, 14 Aug 2002 19:12:52 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:9737 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S315928AbSHNXMq>; Wed, 14 Aug 2002 19:12:46 -0400
Date: Thu, 15 Aug 2002 09:57:16 +1200 (NZST)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: Linu Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fd0 problem on 2.5.31
Message-ID: <Pine.LNX.4.21.0208150937520.1730-102000@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811838-981727398-1029362236=:1871"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811838-981727398-1029362236=:1871
Content-Type: TEXT/PLAIN; charset=US-ASCII

I attempted to mount a msdos floppy (yes, I HAVE read the kt) and found this.
I did a little investigating of this (turned on -d on a ksymoops) and found
out the code ends up in a .text section!  Is this normal?

Anyway, I'm including a normal oops report, ksyms on that,  a extended ksyms
report, and lets see if anyone knows where to go from there.

Please excuse bzip2 and length.

If neither of the attachments get to the list, then I'll have to read the 
FAQ again, to see what I missed 8-( - I'm NOT flipping putting it inline 
unless I HAVE to!

<rant>
*sigh* - I don't BELIEVE I have to crawl back to 2.4-land just to send this 
through my LoseModem. Mind you, I ought to be grateful I have 56k at all.
</rant>

I'll report fb corruption in another email.
===== oops =====
VFS: Disk change detected on device fd(2,0)
generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)
Unable to handle kernel NULL pointer dereference at virtual address 00000098
 printing eip:
c01e677f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01e677f>]    Not tainted
EFLAGS: 00010086
eax: 00000000   ebx: 00000000   ecx: c1281c6c   edx: 00000098
esi: c1281c6c   edi: c103b190   ebp: c112f244   esp: c1281c28
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 1538, threadinfo=c1280000 task=c0f47580)
Stack: c1281c6c c103b190 c112f244 c01e778c c1281c4c c01ef34d 00000000 00000000 
       c1281c6c 00000001 00000000 c1281c54 c1281c54 c103b190 00000200 00000000 
       c0111661 00000000 00000000 c112f244 00000000 00000000 00000001 00000000 
Call Trace: [<c01e778c>] [<c01ef34d>] [<c0111661>] [<c013aa63>] [<c01ef280>] 
   [<c01ef3ad>] [<c013af54>] [<c01ef115>] [<c013b214>] [<c0140200>] [<c013b501>] 
   [<c013a116>] [<c0106e3f>] [<c011f94a>] [<c2b4d3a0>] [<c2b4cf6e>] [<c2b4d3a0>] 
   [<c2b4cef0>] [<c013a401>] [<c2b4d3a0>] [<c014a235>] [<c014a51b>] [<c014a34c>] 
   [<c014a87c>] [<c0106e3f>] 

Code: 8b 8b 98 00 00 00 39 d1 74 18 8b 42 04 89 41 04 89 08 89 93 
 
floppy driver state
-------------------
now=316773 last interrupt=790 diff=315983 last called handler=c01eaee0
timeout_message=lock fdc
last output bytes:
 8 80 783
 8 80 783
 8 80 783
 8 80 787
 8 80 787
 8 80 787
 8 80 787
 e 80 788
13 80 788
 0 90 788
1a 90 788
 0 90 788
12 90 788
 0 90 788
14 90 788
18 80 788
 8 80 790
 8 80 790
 8 80 790
 8 80 790
last result at 790
last redo_fd_request at 791

status=80
fdc_busy=1
cont=00000000
CURRENT=00000000
command_status=-1

floppy0: floppy timeout called
no cont in shutdown!
floppy0: timeout handler died: floppy shutdown


-- 
 /|   _,.:*^*:.,   |\           Cheers from the Viking family, 
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!



---1463811838-981727398-1029362236=:1871
Content-Type: APPLICATION/octet-stream; name="oopsresult.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0208150957160.1871@brick.flying-brick.caverock.net.nz>
Content-Description: ksymdump
Content-Disposition: attachment; filename="oopsresult.bz2"

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
lTU17yCIzS0s1CLoiW+nU5/xdyRThQkAs/K5cA==
---1463811838-981727398-1029362236=:1871
Content-Type: APPLICATION/octet-stream; name="longresult.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0208150957161.1871@brick.flying-brick.caverock.net.nz>
Content-Description: longksymdump
Content-Disposition: attachment; filename="longresult.bz2"

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
/py+P/UCISAhH/i7kinChIFWMVWA
---1463811838-981727398-1029362236=:1871--
