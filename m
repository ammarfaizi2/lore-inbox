Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRHEXgG>; Sun, 5 Aug 2001 19:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbRHEXf4>; Sun, 5 Aug 2001 19:35:56 -0400
Received: from redbull.speedroad.net ([195.139.232.25]:32265 "HELO
	redbull.speedroad.net") by vger.kernel.org with SMTP
	id <S264932AbRHEXfl>; Sun, 5 Aug 2001 19:35:41 -0400
Date: Mon, 06 Aug 2001 01:33:38 +0200
From: Arnvid Karstad <arnvid@karstad.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problems with 2.4.7-ac6 + SMP + FastTrak100
Cc: arnvid@karstad.org (Arnvid Karstad), linux-kernel@vger.kernel.org
In-Reply-To: <E15TX8D-00005G-00@the-village.bc.nu>
In-Reply-To: <20010806005905.B871.ARNVID@karstad.org> <E15TX8D-00005G-00@the-village.bc.nu>
Message-Id: <20010806013245.B877.ARNVID@karstad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

invalid operand: 0000
CPU:    0
EIP:    0010:[<c010bef8>]
EFLAGS: 00010206
eax: 0183fbff   ebx: cb648000   ecx: 40238cc0   edx: cb648000
esi: bffff3a0   edi: 0808dce8   ebp: 00000014   esp: cb649fb8
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 77, stackpage=cb649000)
Stack: c0107c69 cb648000 c0106d0c 400fb9d4 40238cc0 0808de50 bffff3a0 0808dce8 
       00000014 00000000 0000002b 0000002b ffffffff 400978a8 00000023 00010246 
       bffff374 0000002b 
Call Trace: [<c0107c69>] [<c0106d0c>] 

Code: 0f ae 8a 90 03 00 00 c3 dd a2 90 03 00 00 c3 90 8b 54 24 04 


00000000c010bee8 T restore_fpu
00000000c0107c50 T math_state_restore
00000000c0106d0c t ret_from_exception

That's with 2.4.5 but it continues..

Gonna try 2.4.4 and 2.4.6 now

2.2.19 still works

On Mon, 6 Aug 2001 00:16:25 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Even the 2.4.7 vanilla did die.. I booted a 2.4.5 perfectly before.. and
> > 2.2.19 SMP
> > Gonna try them both again now
> 
> Does 2.4.6 fail ?
> 
> > CPU:    0
> > EIP:    0010:[<c010bef8>]
> > EFLAGS: 00010206
> 
> Crashed doing FPU setup
> 
> Your boot CPU ends "cmov mmx" (ie Pentium II)
> 
> > bogomips        : 614.40
> 
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
> > cmov pat pse36 mmx fxsr
> > bogomips        : 616.03
> 
> And the second processor has fxsr (ie SSE - preventium III)
> 
> It looks like that is tripping a bug that got re-introduced in 2.4.6 or
> 2.4.7 (hence I asked which failed). That would explain why there haven't
> been millions of reports
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Mvh, 

Arnvid Karstad,


