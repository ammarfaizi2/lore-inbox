Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSFTS5U>; Thu, 20 Jun 2002 14:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSFTS5U>; Thu, 20 Jun 2002 14:57:20 -0400
Received: from fwvan1.pyr.ec.gc.ca ([199.212.20.2]:11653 "HELO
	siebs.pyr.ec.gc.ca") by vger.kernel.org with SMTP
	id <S315416AbSFTS5S>; Thu, 20 Jun 2002 14:57:18 -0400
Message-ID: <3D122589.4060301@sieb.net>
Date: Thu, 20 Jun 2002 11:57:13 -0700
From: Samuel Sieb <samuel@sieb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020619
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 Assert
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded a computer yesterday from Redhat 7.2 to 7.3 and got this 
assert not long after.
It's a dual P3-600.  I don't know what the motherboard, etc. is, but if 
necessary, I could find out.
I saw a message in the archives that asserts cause immediate failure for 
ext3.  Given this, I'm assuming this is still the case.  Is this correct?

/proc/version:
Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc version 
2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 07:27:31 
EDT 2002

This is what was in the syslog:
kernel: Assertion failure in journal_commit_transaction() at 
commit.c:535: "buffer_jdirty(bh)"
kernel: ------------[ cut here ]------------
kernel: kernel BUG at commit.c:535!
kernel: invalid operand: 0000
kernel: nfsd nfs lockd sunrpc eepro100 ide-cd cdrom usb-uhci usbcore 
ext3 jbd aic7xxx
kernel: CPU:    1
kernel: EIP:    0010:[<e08560e4>]    Not tainted
kernel: EFLAGS: 00010286
kernel:
kernel: EIP is at journal_commit_transaction [jbd] 0xb04 (2.4.18-3smp)
kernel: eax: 0000001c   ebx: 0000000a   ecx: c02eee60   edx: 0000341d
kernel: esi: d90d72b0   edi: ded07300   ebp: df550000   esp: df551e78
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process kjournald (pid: 172, stackpage=df551000)
kernel: Stack: e085ceee 00000217 50000086 00000000 00000fb4 c93bc04c 
00000000 dec0ed20
kernel:        df422910 00005395 c01a16e1 c03cbd44 dfecbe40 00b4f0d1 
d2e5a660 d2e5a600
kernel:        d2e5a5a0 d2e5a540 d2e5a4e0 d2e5a480 d2e5a420 d80a50e0 
d80a5140 d80a51a0
kernel: Call Trace: [<e085ceee>] .rodata.str1.1 [jbd] 0x26e
kernel: [<c01a16e1>] start_request [kernel] 0x1a1
kernel: [<c010a53e>] handle_IRQ_event [kernel] 0x5e
kernel: [<c010a745>] do_IRQ [kernel] 0xa5
kernel: [<c010a767>] do_IRQ [kernel] 0xc7
kernel: [<c0119048>] schedule [kernel] 0x348
kernel: [<e08587d6>] kjournald [jbd] 0x136
kernel: [<e0858680>] commit_timeout [jbd] 0x0
kernel: [<c0107286>] kernel_thread [kernel] 0x26
kernel: [<e08586a0>] kjournald [jbd] 0x0
kernel:
kernel:
kernel: Code: 0f 0b 5a 59 6a 04 8b 44 24 18 50 56 e8 4b f1 ff ff 8d 47 48


