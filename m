Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbREMLQu>; Sun, 13 May 2001 07:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbREMLQb>; Sun, 13 May 2001 07:16:31 -0400
Received: from steve.prima.de ([62.72.84.2]:18960 "EHLO steve.prima.de")
	by vger.kernel.org with ESMTP id <S261398AbREMLQX>;
	Sun, 13 May 2001 07:16:23 -0400
Message-ID: <XFMail.010513131521.ingo@plato.prima.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.0.Linux:010513131521:701=_"
In-Reply-To: <E14yNPC-0001te-00@the-village.bc.nu>
Date: Sun, 13 May 2001 13:15:21 +0200 (CEST)
Organization: Private Site
From: Ingo Renner <ingo@plato.prima.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OOPS on 2.4.4-ac4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.0.Linux:010513131521:701=_
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
so I removed the binary modules and one day got by without oops. So I inser=
ted
my TV Card Askey CPH051 and tried to record a videostream with kwintv.
After a while I got an oops 0002 (prev was 0000) saying Unable to handle ke=
rnel
paging request at virtual address ... which I also found in the previous oo=
ps.
I hope this time the oops report is usefull for you.

On 12-May-01 Alan Cox wrote:
>>=20
>> Ok, I will remove vmware and switch from the nvidia driver the nv driver
>> from
>> XFree 4.3. Maybe I get the oops again.
>=20
> Let me know if you do. I've got some other dmfe reports I'm looking at so=
 its
> quite possible that is the trigger, but this time I'll be able to know it=
s
> not
> giant binary stuff 8)

        Ciao,
                Ingo

"Here you will see the heart and soul of Babylon 5...also its spleen, its
 kidneys, a veritable parade of internal organs."
        -- Londo (to Lennier), "The Quality of Mercy"


--_=XFMail.1.4.0.Linux:010513131521:701=_
Content-Disposition: attachment; filename="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Description: oops.txt
Content-Type: text/plain; charset=iso-8859-1; name=oops.txt; SizeOnDisk=3109

ksymoops 2.4.1 on i686 2.4.4-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-ac4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May 12 18:13:19 lara kernel: ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (IC
E1232)
May 13 03:46:14 lara kernel: ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (IC
E1232)
May 13 11:27:29 lara kernel: ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (IC
E1232)
May 13 11:51:11 lara kernel: ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (IC
E1232)
May 13 12:47:24 lara kernel: ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (IC
E1232)
May 13 12:55:45 lara kernel: Unable to handle kernel paging request at virtual a
ddress 00050311
May 13 12:55:45 lara kernel: c012010b
May 13 12:55:45 lara kernel: Oops: 0002
May 13 12:55:45 lara kernel: CPU:    0
May 13 12:55:45 lara kernel: EIP:    0010:[do_mmap_pgoff+475/1040]
May 13 12:55:45 lara kernel: EFLAGS: 00010206
May 13 12:55:45 lara kernel: eax: c8914228   ebx: c1081014   ecx: c1080ff8   edx
: 00050311
May 13 12:55:45 lara kernel: esi: c1080ff8   edi: c8914228   ebp: 000001e9   esp
: c8e4def4
May 13 12:55:45 lara kernel: ds: 0018   es: 0018   ss: 0018
May 13 12:55:45 lara kernel: Process kwintv (pid: 666, stackpage=c8e4d000)
May 13 12:55:45 lara kernel: Stack: c0126476 c1080ff8 c0280938 c0280b10 00000001
 00000000 c01277fd c0280938 
May 13 12:55:45 lara kernel:        00000000 c0280b18 00000000 d3f97f14 c01278f2
 c0280b0c 00000000 00000001 
May 13 12:55:45 lara kernel:        00000001 00000000 c8e4df94 0001f628 d3f97f14
 00000005 00000001 c0280b0c 
May 13 12:55:45 lara kernel: Call Trace: [kmem_cache_shrink+6/64] [swap_out_vma+
141/224] [swap_out+66/176] [filemap_sync+162/544] [shmem_parse_options+6/464] 
May 13 12:55:45 lara kernel: Code: 89 02 8b 41 10 8b 51 34 c7 41 08 00 00 00 00 
85 c0 74 03 89 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 02                     mov    %eax,(%edx)
Code;  00000002 Before first symbol
   2:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  00000005 Before first symbol
   5:   8b 51 34                  mov    0x34(%ecx),%edx
Code;  00000008 Before first symbol
   8:   c7 41 08 00 00 00 00      movl   $0x0,0x8(%ecx)
Code;  0000000f Before first symbol
   f:   85 c0                     test   %eax,%eax
Code;  00000011 Before first symbol
  11:   74 03                     je     16 <_EIP+0x16> 00000016 Before first sy
mbol
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

--_=XFMail.1.4.0.Linux:010513131521:701=_--
End of MIME message
