Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267568AbUHWIaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267568AbUHWIaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 04:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUHWIai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 04:30:38 -0400
Received: from sendar.prophecy.lu ([213.166.63.242]:58286 "EHLO
	sendar.prophecy.lu") by vger.kernel.org with ESMTP id S267545AbUHWIaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 04:30:11 -0400
Message-ID: <4129AB0B.8050109@linux.lu>
Date: Mon, 23 Aug 2004 10:30:03 +0200
From: Thierry Coutelier <Thierry.Coutelier@linux.lu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, fr-lu, de-lu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Freeze with 2.4.x- Followup
References: <40C06549.2030200@linux.lu>
In-Reply-To: <40C06549.2030200@linux.lu>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Propehcy.lu-MailScanner-Information: Please contact the ISP for more information
X-Propehcy.lu-MailScanner: Found to be clean
X-Propehcy.lu-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9,
	required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


A few weeks ago I sent the message below.
We were now able to get a Stack trace on a modified and on an unmodified 2.4.25 Kernel.

Here are the 2 ksymoops (separated by ----):


Unable to handle kernel paging request at virtual address 5f47534d
~ printing eip:
c0119923
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0119923>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: 5f47534d
esi: dfff6000   edi: 00000001   ebp: d0939fbc   esp: d0939f90
ds: 0018   es: 0018   ss: 0018
Process ip-up (pid: 27133, stackpage=d0939000)
Stack: 00000000 c0306438 00000000 5f47534d 00000000 d0938000 fffffc18
c0374ce0
~       d0938000 00000001 00000006 bfffe148 c010932d 00000000 082a73a4
082a71b8
~       00000001 00000006 bfffe148 082a71c4 0000002b 0000002b ffffff00
08096305
Call Trace:    [<c010932d>]

Code: 8b 02 89 45 e0 0f 18 00 81 fa 20 6e 30 c0 0f 85 79 ff ff ff


After ksymoops analysis :

ksymoops 2.4.1 on i686 2.4.25.  Options used
~     -V (default)
~     -k /proc/ksyms (default)
~     -l /proc/modules (default)
~     -o /lib/modules/2.4.25/ (default)
~     -m /boot/System.map-2.4.25 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ip_conntrack symbol
GPLONLY_ip_conntrack_expect_find_get not found in /lib/modules/2.4.25
/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring /lib/modules/2.4.25
/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_expect_put
not found in /lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_find_get
not found in /lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_put not
found in /lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_destroyed  ,
ip_conntrack says e0ed4b78, /lib/modules/2.4.25
/kernel/net/ipv4/netfilter/ip_conntrack.o says e0ed42e4.  Ignoring
/lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_hash  ,
ip_conntrack says e0ed4b90, /lib/modules/2.4.25
/kernel/net/ipv4/netfilter/ip_conntrack.o says e0ed42fc.  Ignoring
/lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_htable_size  ,
ip_conntrack says e0ed4b7c, /lib/modules/2.4.25
/kernel/net/ipv4/netfilter/ip_conntrack.o says e0ed42e8.  Ignoring
/lib/modules/2.4.25/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says
e0d4e274, /lib/modules/2.4.25/kernel/drivers/usb/usbcore.o says e0d4dcd4.
Ignoring /lib/modules/2.4.25/kernel/drivers/usb/usbcore.o entry
Unable to handle kernel paging request at virtual address 5f47534d
c0119923
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0119923>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: 5f47534d
esi: dfff6000   edi: 00000001   ebp: d0939fbc   esp: d0939f90
ds: 0018   es: 0018   ss: 0018
Process ip-up (pid: 27133, stackpage=d0939000)
Stack: 00000000 c0306438 00000000 5f47534d 00000000 d0938000 fffffc18
c0374ce0
~       d0938000 00000001 00000006 bfffe148 c010932d 00000000 082a73a4
082a71b8
~       00000001 00000006 bfffe148 082a71c4 0000002b 0000002b ffffff00
08096305
Call Trace:    [<c010932d>]
Code: 8b 02 89 45 e0 0f 18 00 81 fa 20 6e 30 c0 0f 85 79 ff ff ff


|>>>EIP; c0119923 <schedule+173/4c0>   <=====

Trace; c010932d <reschedule+5/c>
Code;  c0119923 <schedule+173/4c0>
00000000 <_EIP>:
Code;  c0119923 <schedule+173/4c0>   <=====
~   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c0119925 <schedule+175/4c0>
~   2:   89 45 e0                  mov    %eax,0xffffffe0(%ebp)
Code;  c0119928 <schedule+178/4c0>
~   5:   0f 18 00                  prefetchnta (%eax)
Code;  c011992b <schedule+17b/4c0>
~   8:   81 fa 20 6e 30 c0         cmp    $0xc0306e20,%edx
Code;  c0119931 <schedule+181/4c0>
~   e:   0f 85 79 ff ff ff         jne    ffffff8d <_EIP+0xffffff8d>
c01198b0 <schedule+100/4c0>


9 warnings issued.  Results may not be reliable.

- ----

ksymoops 2.4.1 on i686 2.4.25-SES.  Options used
~     -V (default)
~     -k /proc/ksyms (default)
~     -l /proc/modules (default)
~     -o /lib/modules/2.4.25-SES/ (default)
~     -m /boot/System.map-2.4.25-SES (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ip_conntrack symbol
GPLONLY_ip_conntrack_expect_find_get not found in
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_expect_put
not found in
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_find_get
not found in
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_put not
found in /lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o
entry
Warning (compare_maps): mismatch on symbol ip_conntrack_destroyed  ,
ip_conntrack says e0edab98,
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o says
e0eda304.  Ignoring
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_hash  ,
ip_conntrack says e0edabb0,
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o says
e0eda31c.  Ignoring
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol ip_conntrack_htable_size  ,
ip_conntrack says e0edab9c,
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o says
e0eda308.  Ignoring
/lib/modules/2.4.25-SES/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): mismatch on symbol my_classid  , sch_miq says
e0ed1a20, /lib/modules/2.4.25-SES/kernel/net/sched/sch_miq.o says e0ed19a0.
Ignoring /lib/modules/2.4.25-SES/kernel/net/sched/sch_miq.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says
e0d4e294, /lib/modules/2.4.25-SES/kernel/drivers/usb/usbcore.o says
e0d4dcf4.  Ignoring /lib/modules/2.4.25-SES/kernel/drivers/usb/usbcore.o
entry
Unable to handle kernel NULL pointer dereference at virtual address
00000000
c0119923
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0119923>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 083ca488   ecx: 00000001   edx: 00000000
esi: dfff6000   edi: 00000001   ebp: cc8a1f98   esp: cc8a1f6c
ds: 0018   es: 0018   ss: 0018
Process tbectrld (pid: 21783, stackpage=cc8a1000)
Stack: 00000082 cb1b44c0 cc8a0000 00000000 c01209dc cc8a0000 fffffc18
c0376ce0
~       c160c220 dfffb200 cc8a0000 00000000 c0120e4d cc8a0000 c160c220
cc8a0000
~       40170c44 00000000 bffffcd8 c0120fc3 00000000 c010927f 00000000
00001000
Call Trace:    [<c01209dc>] [<c0120e4d>] [<c0120fc3>] [<c010927f>]
Code: 8b 02 89 45 e0 0f 18 00 81 fa a0 7f 30 c0 0f 85 79 ff ff ff


|>>>EIP; c0119923 <schedule+173/4c0>   <=====

Trace; c01209dc <exit_notify+dc/360>
Trace; c0120e4d <do_exit+1ed/330>
Trace; c0120fc3 <sys_exit+13/20>
Trace; c010927f <system_call+33/38>
Code;  c0119923 <schedule+173/4c0>
00000000 <_EIP>:
Code;  c0119923 <schedule+173/4c0>   <=====
~   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c0119925 <schedule+175/4c0>
~   2:   89 45 e0                  mov    %eax,0xffffffe0(%ebp)
Code;  c0119928 <schedule+178/4c0>
~   5:   0f 18 00                  prefetchnta (%eax)
Code;  c011992b <schedule+17b/4c0>
~   8:   81 fa a0 7f 30 c0         cmp    $0xc0307fa0,%edx
Code;  c0119931 <schedule+181/4c0>
~   e:   0f 85 79 ff ff ff         jne    ffffff8d <_EIP+0xffffff8d>
c01198b0 <schedule+100/4c0>


10 warnings issued.  Results may not be reliable.

- ----

Thierry Coutelier wrote:
| Greeting,
|
| We are using Linux boxes to offer Satellite Internet. We still use
| RedHat 7.[23]
| The system works using rp-l2tp and/or pptpd with pppd. On the outgoing
| interface (the
| one that sends traffic to the Satellite we were using CBQ and now we use
| HTB queuing
| discipline.
|
| The kernels range from 2.4.6 to 2.4.25 with some modifications
| (tcp_input). We tried
| with the standard kernel with the only change that the dev_alloc_name
| has been
| changed to support up to 900 names.
|
| Every few weeks (sometimes 2 days, often 3 weeks and sometime up to 9
| weeks) the
| kernel freezes: nothing on screen or serial console except from some VJ
| decompression
| errors which we have at all times, even the Num-Lock does not respond.
| We tried to enable sysreq keys but those won't work either.
|
| 2 days ago we were able to catch the following message (12 hours before
| a freeze) :
| HTB: dequeue bug (8,12140714,12140714), report it please !
|
|
| The Hardware are Dell PowerEdge with Perc2 or Perc3. We tried with HP
| servers and
| have the same problem. We tried different firmware releases for the Perc
| cards and
| still no change.
|
| The NIC cards are mostly Intel EEpro 100. We tried with both drivers
| Intel and
| community with no better results.
|
| The problem may be happening more often (every 2/3 days) when we
| simulate a lot of
| ppp connections/disconnections (80 users/minute), but in some cases it
| hangs even
| without having many users.
|
| The platform we run have between 25 to 200 simultaneous connections.
| Some have single
| or dual or even quad CPU's. And RAM between 512Mbytes and 4 Gbytes.
|
| We could not detect any parameters that would rise before the freeze
| (load, memory,
| swap ...)
|
| Could anyone give me some hint as to what to do/test more ?
| Where could the problem be ?
|
|
| Thanks.
|
| --
| Thierry Coutelier
| No Patents on Software: http://www.linux.lu/epatent
|
- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBKasLPOfrcNNQX7oRAmKlAJ9t0rLUIRYz9GK92Q9wFgKaAhE24QCfcRG1
+AxC7biKUtgmZXY5ksizU6I=
=NHFd
-----END PGP SIGNATURE-----
