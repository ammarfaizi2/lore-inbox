Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVB0PDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVB0PDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVB0PDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:03:46 -0500
Received: from ptr210-netcat ([66.230.167.210]:63683 "EHLO
	mail.globalproof.net") by vger.kernel.org with ESMTP
	id S261399AbVB0PDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:03:38 -0500
Date: Sun, 27 Feb 2005 17:03:48 +0200
From: nuclearcat <nuclearcat@nuclearcat.com>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: nuclearcat <nuclearcat@nuclearcat.com>
Organization: NUC
X-Priority: 3 (Normal)
Message-ID: <1414300562.20050227170348@nuclearcat.com>
To: nuclearcat <nuclearcat@nuclearcat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re[3]: pty_chars_in_buffer NULL pointer (kernel oops)
In-Reply-To: <1232377275.20050227165254@nuclearcat.com>
References: <1567604259.20050218105653@nuclearcat.com>
 <20050225230432.GD15251@logos.cnet> <1232377275.20050227165254@nuclearcat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear, nuclearcat.

You wrote Sunday, February 27, 2005, 4:52:54 PM:

P.S. new kernel - 2.4.29 vanilla

> Dear, Marcelo.

> You wrote Saturday, February 26, 2005, 1:04:32 AM:

> Sorry about delay, i had switched kernel to non-SMP mode.
> I cannot debug on kernel (it is loaded VPN server, and there is no
> redundancy for now).
> I have only few old oopses, saved before (it is on old redhat kernel)
> Feb 16 06:44:41 nss kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000
> Feb 16 06:44:41 nss kernel:  printing eip:
> Feb 16 06:44:41 nss kernel: 00000000
> Feb 16 06:44:41 nss kernel: *pde = 00000000
> Feb 16 06:44:41 nss kernel: Oops: 0000
> Feb 16 06:44:41 nss kernel: cls_u32 sch_sfq sch_cbq ip_nat_ftp
> ip_conntrack_ftp tun ipt_REJECT ipt_REDIRECT nls_iso8859-1 loop
> cipcb ip_gre ipip ppp_async pp
> Feb 16 06:44:41 nss kernel: CPU:    3
> Feb 16 06:44:41 nss kernel: EIP:    0060:[<00000000>]    Not tainted
> Feb 16 06:44:41 nss kernel: EFLAGS: 00010286
> Feb 16 06:44:41 nss kernel:
> Feb 16 06:44:41 nss kernel: EIP is at [unresolved] (2.4.20-20.9smp)
> Feb 16 06:44:41 nss kernel: eax: d4b26000   ebx: ce7fe000   ecx: c01997c0   edx: ef7c6b80
> Feb 16 06:44:41 nss kernel: esi: 00000000   edi: ce7fe000   ebp: e040a880   esp: cfdf7ee0
> Feb 16 06:44:41 nss kernel: ds: 0068   es: 0068   ss: 0068
> Feb 16 06:44:41 nss kernel: Process pptpctrl (pid: 15960, stackpage=cfdf7000)
> Feb 16 06:44:41 nss kernel: Stack: c019d839 d4b26000 00000000
> c019b2e6 ce7fe000 ce7fe974 cfdf7f48 ce7fe000
> Feb 16 06:44:41 nss kernel:        e040a880 00000004 00000010
> c0197a15 ce7fe000 e040a880 00000000 00000000
> Feb 16 06:44:41 nss kernel:        e040a880 c01662b7 e040a880
> 00000000 cfdf6000 00000145 cfdf6000 00001962
> Feb 16 06:44:41 nss kernel: Call Trace:   [<c019d839>]
> pty_chars_in_buffer [kernel] 0x39 (0xcfdf7ee0))
> Feb 16 06:44:41 nss kernel: [<c019b2e6>] normal_poll [kernel] 0x106 (0xcfdf7eec))
> Feb 16 06:44:41 nss kernel: [<c0197a15>] tty_poll [kernel] 0x85 (0xcfdf7f0c))
> Feb 16 06:44:41 nss kernel: [<c01662b7>] do_select [kernel] 0x247 (0xcfdf7f24))
> Feb 16 06:44:41 nss kernel: [<c016663e>] sys_select [kernel] 0x34e (0xcfdf7f60))
> Feb 16 06:44:41 nss kernel: [<c01098cf>] system_call [kernel] 0x33 (0xcfdf7fc0))
> Feb 16 06:44:41 nss kernel:
> Feb 16 06:44:41 nss kernel:
> Feb 16 06:44:41 nss kernel: Code:  Bad EIP value.



> in new kernel there is no debug messages to find where is problem, but
> problem looks very similar

> Feb 17 13:13:54 nss kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000
> Feb 17 13:13:54 nss kernel:  printing eip:
> Feb 17 13:13:54 nss kernel: 00000000
> Feb 17 13:13:54 nss kernel: *pde = 00000000
> Feb 17 13:13:54 nss kernel: Oops: 0000
> Feb 17 13:13:54 nss kernel: CPU:    3
> Feb 17 13:13:54 nss kernel: EIP:    0010:[<00000000>]    Not tainted
> Feb 17 13:13:54 nss kernel: EFLAGS: 00010286
> Feb 17 13:13:54 nss kernel: eax: ec32e000   ebx: f6891000   ecx: c01f56a0   edx: d6547980
> Feb 17 13:13:54 nss kernel: esi: f6891000   edi: 00000000   ebp: f39c4c00   esp: d66bbed8
> Feb 17 13:13:54 nss kernel: ds: 0018   es: 0018   ss: 0018
> Feb 17 13:13:54 nss kernel: Process pptpctrl (pid: 10632, stackpage=d66bb000)
> Feb 17 13:13:54 nss kernel: Stack: c01f9829 ec32e000 00000000
> c01f7e66 f6891000 00000010 00000202 f68910c0
> Feb 17 13:13:54 nss kernel:        f6891000 f39c4c00 00000000
> c01f3bb0 f6891000 f39c4c00 00000000 00000000
> Feb 17 13:13:54 nss kernel:        f39c4c00 00000004 00000010
> c0153a87 f39c4c00 00000000 d66ba000 00000145
> Feb 17 13:13:54 nss kernel: Call Trace:    [<c01f9829>]
> [<c01f7e66>] [<c01f3bb0>] [<c0153a87>] [<c0153e0e>]
> Feb 17 13:13:54 nss kernel:   [<c010ae99>] [<c0108f67>]
> Feb 17 13:13:54 nss kernel:
> Feb 17 13:13:54 nss kernel: Code:  Bad EIP value.


> And problem disappearing in non-SMP kernel.


>> Hi, 

>> On Fri, Feb 18, 2005 at 10:56:53AM +0200, nuclearcat wrote:

>>> Is discussed at

>>> http://kerneltrap.org/mailarchive/1/message/12508/thread 

>>> bug fixed in 2.4.x tree? Cause seems i have downloaded 2.4.29, and it
>>> is not fixed (still my kernel on vpn server crashing almost at start),
>>> i have grepped fast pre and bk patches, but didnt found any fixed
>>> related to tty/pty.

>> Can you please post the oops? Have you done so already? 

>> What makes you think it is the same race discussed in the above thread?

>> BTW, I fail to see any drivers/char/pty.c change related to the race which triggers
>> the pty_chars_in_buffer->0 oops.

>> Quoting the first message from thread you mention:
>> "That last call trace entry is the call in pty_chars_in_buffer() to

>>         /* The ldisc must report 0 if no characters available to be read */
>>         count = to->ldisc.chars_in_buffer(to);
>> "

>> Alan, Linus, what correction to the which the above thread discusses has
>> been deployed? 

>>> Provided in thread patch from Linus working, but after night i have
>>> checked server, and see load average jumped to 700.
>>> Can anybody help in that? I am not kernel guru to provide a patch, but
>>> seems by search in google it is actual problem for people, who own
>>> poptop vpn servers, it is really causing serious instability for
>>> servers.

>> Can you compile a list of such v2.4 reports? 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/






-- 
With best regards,
GlobalProof Globax Division Manager,
Denys Fedoryshchenko
mailto:denys@globalproof.net

