Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287487AbSAXL3E>; Thu, 24 Jan 2002 06:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSAXL2p>; Thu, 24 Jan 2002 06:28:45 -0500
Received: from aboukir-101-2-1-easter.adsl.nerim.net ([62.4.19.191]:64645 "HELO
	verveine") by vger.kernel.org with SMTP id <S287487AbSAXL2l>;
	Thu, 24 Jan 2002 06:28:41 -0500
Date: Thu, 24 Jan 2002 12:28:23 +0100
From: Brugier Pascal <pbrugier@easter-eggs.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 cpqarray eepro100 ext3
Message-ID: <20020124122823.B8063@easter-eggs.com>
In-Reply-To: <20020122145844.A622@easter-eggs.com> <Pine.LNX.4.33.0201221211100.20907-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201221211100.20907-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Tue, Jan 22, 2002 at 12:11:52PM -0500
X-Operating-System: Debian Gnu/Linux 2.4.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 12:11:52PM -0500, Mark Hahn wrote:
> > The server hangs when (it seems) we want to read or cp big 
> > file (140 Mo).
> 
> that's not a large file.
> 
> > Invalid operand 00000 (i'm not sur about thenumber of 0 because
> > someone else read for me and doesn't remember)
> 
> that's a bug or oops, and you must capture the whole thing,
> and run it through ksymoops for it to be meaningful.
> 
Hi 

Remember i'm not on the mailing list, pleased CC'ed answer to my 
message, thank you.

I've best informations:

I've 4 partitions on the server
/dev/ida/c0d0 swap
/dev/ida/c0d1 /
/dev/ida/c0d2 /tmp
/dev/ida/c0d3 /var

When  i want to edit a file: /var/log/mylogdir/mylogfile (140 Mb)
the server hangs whith this messages:

invalid operand
CPU:	0L
EIP:	0010:[<c0123154>] Not tainted
EFLAGS: 00010046
eax: 00000000	ebx: d99a9f60	ecx: 00000002	edx: c1665740
esi: 00000002	edi: c1665740	ebp: 00000001	esp: c01fbf18
ds: 0018	es: 0018	ss: 0018
Process swapper (pid: 0, stackpage=c01fb000)
Stack: d99a9f60 c012f92b 00000000 dfa01f48 c1821800 e082a885 d99a9f60
00000001
       dfffa680 24000001 00000003 c01fbf94 00000002 c0107f8d 00000003
       c1821800
       c01fbf94 00000060 c0230960 00000003 c01fbf8c c01080f6 00000003
       c01fbf94
Call Trace: [<c012f92b>] [<e082a885>] [<c0107f8d>] [<c01080f6>]
[<c01053e9>] [<c0105360>] [<c0109ed8>] [<c0105360>] [<c0105360>]
[<c0105383>] [<c01053e9<] [<c0105000>] [<c0105027>]

Code: 0f 0b 8d 5a 24 8d 42 28 39 42 28 74 11 b9 01 00 00 00 ba 03
<0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

###############

If i want to copy /var/log/mylogdir/mylogfile

Kernel saya:

invalid request on ida/c0d0 = (cmd=30 sect=837624 cnt=248 sg=1 ret=10)

###############

After writing this message i will downgrad to a 2.4.13 which is patched
for ext3 and runnig whithout any problem on an other server whith the 
same hardware. The difference between the 2 servers is that the
2.4.14's one is running on Raid 1 and the 2.4.13 on Raid 5.

I hope i give you enought informations .

Thanks a lot

Best regards

-- 
Pascal Brugier
---------------------------------------------------------------
Easter-eggs                               Spécialiste GNU/Linux
44-46 rue de l'Ouest  -  75014 Paris  -  France  -  Métro Gaité
Phone: +33 (0) 1 43 35 00 37    -    Fax: +33 (0) 1 43 35 00 76
mailto:pbrugier@easter-eggs.com  -   http://www.easter-eggs.com
---------------------------------------------------------------
709D77A2 -   ED24 4E29 E5B4 FDE7 56A4  352D F24E 7E68 709D 77A2
_______________________________________________________________
