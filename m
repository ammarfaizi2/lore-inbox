Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRCTQPK>; Tue, 20 Mar 2001 11:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRCTQPB>; Tue, 20 Mar 2001 11:15:01 -0500
Received: from idiom.com ([216.240.32.1]:38413 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S130461AbRCTQOs>;
	Tue, 20 Mar 2001 11:14:48 -0500
Message-ID: <3AB779F9.6D7BAA38@namesys.com>
Date: Tue, 20 Mar 2001 18:40:41 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: david@fortyoz.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Fwd: [reiserfs-dev] [Fwd: [reiserfs-list] 2.4.3-pre1 oops w/ rsync & 
 ReiserFS]]
Content-Type: multipart/mixed;
 boundary="------------CD9BFB7EF276EB1BD2C46AA9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CD9BFB7EF276EB1BD2C46AA9
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

David, did you determine if it was a memory bug?
--------------CD9BFB7EF276EB1BD2C46AA9
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <NikitaDanilov@Yahoo.COM>
Delivered-To: reiser@namesys.com
Received: (qmail 28047 invoked from network); 20 Mar 2001 12:20:23 -0000
Received: from srg.access.comstar.ru (HELO beta.namesys.com) (195.210.131.190)
  by thebsh.namesys.com with SMTP; 20 Mar 2001 12:20:23 -0000
Received: (from god@localhost)
	by beta.namesys.com (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) id PAA20262;
	Tue, 20 Mar 2001 15:18:28 +0300
X-Authentication-Warning: beta.namesys.com: god set sender to NikitaDanilov@Yahoo.COM using -f
From: Danilov Nikita <NikitaDanilov@Yahoo.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15031.19092.764777.859191@beta.namesys.com>
Date: Tue, 20 Mar 2001 15:18:28 +0300
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [reiserfs-dev] [Fwd: [reiserfs-list] 2.4.3-pre1 oops w/ rsync & ReiserFS]
In-Reply-To: <3AB6967A.2D849ACA@namesys.com>
In-Reply-To: <3AB6967A.2D849ACA@namesys.com>
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
X-Mozilla-Status2: 00000000

Just to note: stack trace doesn't involve reiserfs at all. Other people
suggested that it may me memory bug.

Nikita.

Hans Reiser writes:
 > Who is taking this one?
 > 
 > HansReturn-Path: <reiserfs-list-return-3481-reiser=namesys.com@namesys.com>
 > Delivered-To: reiser@namesys.com
 > Received: (qmail 30581 invoked by uid 501); 19 Mar 2001 23:27:52 -0000
 > Mailing-List: contact reiserfs-list-help@namesys.com; run by ezmlm
 > Precedence: bulk
 > list-help: <mailto:reiserfs-list-help@namesys.com>
 > list-unsubscribe: <mailto:reiserfs-list-unsubscribe@namesys.com>
 > list-post: <mailto:reiserfs-list@namesys.com>
 > Delivered-To: mailing list reiserfs-list@namesys.com
 > Received: (qmail 30574 invoked from network); 19 Mar 2001 23:27:52 -0000
 > Date: Mon, 19 Mar 2001 15:28:42 -0800
 > From: David Raufeisen <david@fortyoz.org>
 > To: linux-kernel@vger.kernel.org
 > Cc: reiserfs-list@namesys.com
 > Message-ID: <20010319152842.A11014@fortyoz.org>
 > Reply-To: David Raufeisen <david@fortyoz.org>
 > Mime-Version: 1.0
 > Content-Type: text/plain; charset=us-ascii
 > Content-Disposition: inline
 > User-Agent: Mutt/1.3.12i
 > X-Operating-System: Linux 2.2.17 i686
 > Subject: [reiserfs-list] 2.4.3-pre1 oops w/ rsync & ReiserFS
 > X-Mozilla-Status2: 00000000
 > 
 > Getting oops every time I run rsync today.. happens after it receives file list and is starting to stat all the files.. filesystem is reiser.
 > 
 > Linux prototype 2.4.3-pre1 #2 Thu Mar 15 00:24:43 PST 2001 i686 unknown
 > 
 > 15:25:28 up 1 day, 20:05,  4 users,  load average: 0.00, 0.03, 0.00
 > 
 > Linux prototype 2.4.3-pre1 #2 Thu Mar 15 00:24:43 PST 2001 i686 unknown
 >  
 > Gnu C                  2.95.3
 > Gnu make               3.79.1
 > binutils               2.11.90.0.1
 > util-linux             2.11a
 > modutils               2.4.2
 > e2fsprogs              1.19
 > reiserfsprogs          3.x.0b
 > Linux C Library        2.2.2
 > Dynamic linker (ldd)   2.2.2
 > Procps                 2.0.7
 > Net-tools              1.59
 > Kbd                    command
 > Sh-utils               2.0.11
 > Modules Loaded         NVdriver
 > 
 > prototype:~# ksymoops oops.txt    
 > ksymoops 2.3.7 on i686 2.4.3-pre1.  Options used
 >      -V (default)
 >      -k /proc/ksyms (default)
 >      -l /proc/modules (default)
 >      -o /lib/modules/2.4.3-pre1/ (default)
 >      -m /System.map (default)
 > 
 > Warning: You did not tell me where to find symbol information.  I will
 > assume that the log matches the kernel and modules that are running
 > right now and I'll use the default options above for symbol resolution.
 > If the current kernel and/or modules do not match the log, you can get
 > more accurate output by telling me the kernel version and where to find
 > map, modules, ksyms etc.  ksymoops -h explains the options.
 > 
 > Unable to handle kernel paging request at virtual address 4280d8c4
 > c01410c0
 > *pde = 00000000
 > Oops: 0000
 > CPU:    0
 > EIP:    0010:[<c01410c0>]
 > Using defaults from ksymoops -t elf32-i386 -a i386
 > EFLAGS: 00210207
 > eax: c7fdc5e0   ebx: 4280d8ac   ecx: 0000000e   edx: 21cd5a87
 > esi: 00000000   edi: c71424c0   ebp: 4280d8c4   esp: c37b1f04
 > ds: 0018   es: 0018   ss: 0018
 > Process rsync (pid: 16269, stackpage=c37b1000)
 > Stack: c37b1f68 00000000 c71424c0 c37b1fa4 c7fdc5e0 c5919022 21cd5a87 0000000a 
 >        c01392d0 c71424c0 c37b1f68 c37b1f68 c0139a92 c71424c0 c37b1f68 00000000 
 >        c5919000 00000000 c37b1fa4 00000000 c5919000 00000000 c01390da 00000008 
 > Call Trace: [<c01392d0>] [<c0139a92>] [<c01390da>] [<c013a0dc>] [<c0137116>] [<c012f453>] [<c0108e8b>] 
 > Code: 8b 6d 00 8b 54 24 18 39 53 48 75 7c 8b 44 24 24 39 43 0c 75 
 > 
 > >>EIP; c01410c0 <d_lookup+60/100>   <=====
 > Trace; c01392d0 <cached_lookup+10/60>
 > Trace; c0139a92 <path_walk+562/7d0>
 > Trace; c01390da <getname+5a/a0>
 > Trace; c013a0dc <__user_walk+3c/60>
 > Trace; c0137116 <sys_lstat64+16/70>
 > Trace; c012f453 <sys_close+43/60>
 > Trace; c0108e8b <system_call+33/38>
 > Code;  c01410c0 <d_lookup+60/100>
 > 00000000 <_EIP>:
 > Code;  c01410c0 <d_lookup+60/100>   <=====
 >    0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
 > Code;  c01410c3 <d_lookup+63/100>
 >    3:   8b 54 24 18               mov    0x18(%esp,1),%edx
 > Code;  c01410c7 <d_lookup+67/100>
 >    7:   39 53 48                  cmp    %edx,0x48(%ebx)
 > Code;  c01410ca <d_lookup+6a/100>
 >    a:   75 7c                     jne    88 <_EIP+0x88> c0141148 <d_lookup+e8/100>
 > Code;  c01410cc <d_lookup+6c/100>
 >    c:   8b 44 24 24               mov    0x24(%esp,1),%eax
 > Code;  c01410d0 <d_lookup+70/100>
 >   10:   39 43 0c                  cmp    %eax,0xc(%ebx)
 > Code;  c01410d3 <d_lookup+73/100>
 >   13:   75 00                     jne    15 <_EIP+0x15> c01410d5 <d_lookup+75/100>
 > 
 > 
 > 1 warning issued.  Results may not be reliable.
 > 
 > 
 > 
 > -- 
 > David Raufeisen <david@fortyoz.org>
 > Cell: (604) 818-3596
 > 


--------------CD9BFB7EF276EB1BD2C46AA9--

