Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbRC0MW7>; Tue, 27 Mar 2001 07:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRC0MWk>; Tue, 27 Mar 2001 07:22:40 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:41483 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S131241AbRC0MWa>; Tue, 27 Mar 2001 07:22:30 -0500
From: mshiju@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        linux-mca@vger.kernel.org, linux-tr@linuxtr.net,
        ibm-linux-tech@linux.ibm.com
Message-ID: <CA256A1C.0043BE80.00@d73mta05.au.ibm.com>
Date: Tue, 27 Mar 2001 17:40:10 +0530
Subject: kernel Oops message -2.4.x - contains ksymoops <oops.txt 
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
      I am doing some testing on IBM Lanstreamer MCA tokenring adapter on
IBM PS/2 server-9595. Inserting the driver ( as module)  it is perfect. But
when I do an ifconfig tr0 up then I get an kernel panic and Oops message is
printed out . It occures when the function interruptible_sleep_on_timeout()
is called within the device driver ..  . I am using kernel-2.4.0 with
redhat -7 installation. Same effect was also there on 2.4.2 .But I didn't
had any problem when the driver is compiled and run on 2.2.x version . Can
anyone help me to resolve the problem.  . The following is the output of
ksymoops < oops.txt  message.

Unable to handle kernel NULL pointer dereference at virtual address
00000004
c0111720
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0111720>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000000   ebx: 00000086   ecx: c0d08c1c   edx: c0b9ddc8
esi: c0d08c18   edi: 000001f4   ebp: c0b9dddc   esp: c0b9ddc0
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 651, stackpage=c0b9d000)
Stack: 00000000 c0b9c000 00000001 ffffffff c0b9c000 00001c68 000007ce
c0d08c00
       c2810add c0b9ddf8 1c681c62 00000001 00000202 1c0073e0 00000002
40017000
       00000246 00000000 00000246 00000000 c0b9f6f4 00000246 00000000
00000246
Call Trace: [<c2810add>] [<c012926c>] [<c01223b0>] [<c014239f>]
[<c01232eb>] [<c01202bf>] [<c0120411>]
       [<c01416f0>] [<c01407b9>] [<c01e9402>] [<c01ea142>] [<c020d7b7>]
[<c01e52e0>] [<c013cab7>] [<c0108fe3>]
Code: 89 50 04 89 45 ec 89 4d f0 89 56 04 89 f8 e8 ed f7 ff ff 89

>>EIP; c0111720 <interruptible_sleep_on_timeout+30/60>   <=====
Trace; c2810add <[lanstreamer]streamer_open+2cd/8f0>
Trace; c012926c <inactive_shortage+2c/40>
Trace; c01223b0 <__find_get_page+30/70>
Trace; c014239f <get_new_inode+df/160>
Trace; c01232eb <filemap_nopage+cb/440>
Trace; c01202bf <do_no_page+4f/c0>
Trace; c0120411 <handle_mm_fault+e1/160>
Trace; c01416f0 <destroy_inode+30/40>
Trace; c01407b9 <dput+129/150>
Trace; c01e9402 <dev_open+42/a0>
Trace; c01ea142 <dev_change_flags+52/f0>
Trace; c020d7b7 <devinet_ioctl+2d7/640>
Trace; c01e52e0 <sock_ioctl+20/30>
Trace; c013cab7 <sys_ioctl+187/1a0>
Trace; c0108fe3 <system_call+33/40>
Code;  c0111720 <interruptible_sleep_on_timeout+30/60>
00000000 <_EIP>:
Code;  c0111720 <interruptible_sleep_on_timeout+30/60>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0111723 <interruptible_sleep_on_timeout+33/60>
   3:   89 45 ec                  mov    %eax,0xffffffec(%ebp)
Code;  c0111726 <interruptible_sleep_on_timeout+36/60>
   6:   89 4d f0                  mov    %ecx,0xfffffff0(%ebp)
Code;  c0111729 <interruptible_sleep_on_timeout+39/60>
   9:   89 56 04                  mov    %edx,0x4(%esi)
Code;  c011172c <interruptible_sleep_on_timeout+3c/60>
   c:   89 f8                     mov    %edi,%eax
Code;  c011172e <interruptible_sleep_on_timeout+3e/60>
   e:   e8 ed f7 ff ff            call   fffff800 <_EIP+0xfffff800>
c0110f20 <schedule_timeout+0/a0>
Code;  c0111733 <interruptible_sleep_on_timeout+43/60>
  13:   89 00                     mov    %eax,(%eax)

Thanks & Regards
Shiju

Shiju A Mathew
Software Engineer
IBM Global Services
Golden Enclave,Bangalore
Tel:91-80-5262355 Extn.:2862


