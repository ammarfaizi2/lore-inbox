Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSF0CLX>; Wed, 26 Jun 2002 22:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSF0CLW>; Wed, 26 Jun 2002 22:11:22 -0400
Received: from colossus.systems.pipex.net ([62.190.223.73]:56201 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S313202AbSF0CLV> convert rfc822-to-8bit; Wed, 26 Jun 2002 22:11:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Philip Wyett <philipwyett@dsl.pipex.com>
Reply-To: philipwyett@dsl.pipex.com
Subject: Re: kernel: journal /ext3 problem. "Assertion failure"
Date: Thu, 27 Jun 2002 03:11:18 +0100
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206270311.18861.philipwyett@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 Jun 2002 2:58 am, louie miranda wrote:
> Jun 26 05:16:56 chsvr kernel: Assertion failure in
> journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
> Jun 26 05:16:56 chsvr kernel: ------------[ cut here ]------------
> Jun 26 05:16:56 chsvr kernel: kernel BUG at commit.c:535!
> Jun 26 05:16:56 chsvr kernel: invalid operand: 0000
> Jun 26 05:16:56 chsvr kernel: iptable_filter ip_tables eepro100 usb-ohci
> usbcore ext3 jbd aic7xxx sd_mod scs
> Jun 26 05:16:56 chsvr kernel: CPU:    1
> Jun 26 05:16:56 chsvr kernel: EIP:    0010:[<f88540e4>]    Not tainted
> Jun 26 05:16:56 chsvr kernel: EFLAGS: 00010286
> Jun 26 05:16:56 chsvr kernel:
> Jun 26 05:16:56 chsvr kernel: EIP is at journal_commit_transaction [jbd]
> 0xb04 (2.4.18-3smp)
> Jun 26 05:16:56 chsvr kernel: eax: 0000001c   ebx: 0000000a   ecx: c02eee60
> edx: 00003684
> Jun 26 05:16:56 chsvr kernel: esi: f7376b80   edi: f7271f00   ebp: f75aa000
> esp: f75abe78
> Jun 26 05:16:56 chsvr kernel: ds: 0018   es: 0018   ss: 0018
> Jun 26 05:16:56 chsvr kernel: Process kjournald (pid: 191,
> stackpage=f75ab000)
> Jun 26 05:16:56 chsvr kernel: Stack: f885aeee 00000217 f74d2eb8 00000000
> 00000fbc f1745044 00000000 f23a2460
> Jun 26 05:16:56 chsvr kernel:        f6558610 00001a64 00000001 f882ad2f
> f74d2e00 00000008 f1905260 edec9560
> Jun 26 05:16:56 chsvr kernel:        edec95c0 edec9620 edec9680 edec96e0
> edcbc9e0 edcbca40 edcbcaa0 edcbcb00
> Jun 26 05:16:56 chsvr kernel: Call Trace: [<f885aeee>] .rodata.str1.1 [jbd]
> 0x26e
> Jun 26 05:16:56 chsvr kernel: [<f882ad2f>] rw_intr [sd_mod] 0x20f
> Jun 26 05:16:56 chsvr kernel: [<c0119048>] schedule [kernel] 0x348
> Jun 26 05:16:56 chsvr kernel: [<f88567d6>] kjournald [jbd] 0x136
> Jun 26 05:16:56 chsvr kernel: [<f8856680>] commit_timeout [jbd] 0x0
> Jun 26 05:16:56 chsvr kernel: [<c0107286>] kernel_thread [kernel] 0x26
> Jun 26 05:16:56 chsvr kernel: [<f88566a0>] kjournald [jbd] 0x0
> Jun 26 05:16:56 chsvr kernel:
> Jun 26 05:16:56 chsvr kernel:
> Jun 26 05:16:56 chsvr kernel: Code: 0f 0b 5a 59 6a 04 8b 44 24 18 50 56 e8
> 4b f1 ff ff 8d 47 48
>
>
>
>
>
> Hi, i've encountered this error yesterday.
> The machine dont run anything big and its
> not yet on production.
>
> The machine hangs, and does not accept some
> connections on some apps like ssh, etc.
>
> I tried to reboot the machine, and after it works
> fine again.
>
> Im not sure where to send it, and not sure
> if its redhat problem or the main kernel.
>
>
>
> BTW: its redhat 7.3
> Kernel 2.4.18-3smp
> A default install so far.
>
>
> Please advise,
> louie...

This is a known ext3 issue with 7.3 SMP and kicked me in the teeth when I
installed 7.3 :). See the below link for info about the kernel update.

http://rhn.redhat.com/errata/RHBA-2002-085.html

To note this has since been superceded by a newer kernel 2.4.18-5 as against
the -4 referred too in the link. Register your system and run 'up2date' to
aquire the latest kernel and all should be well.

Regards

Philip Wyett

