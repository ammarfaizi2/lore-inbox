Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbTCDA2Q>; Mon, 3 Mar 2003 19:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268898AbTCDA2Q>; Mon, 3 Mar 2003 19:28:16 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:28604 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268896AbTCDA2P>; Mon, 3 Mar 2003 19:28:15 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Sampson Fung" <sampson@attglobal.net>
Date: Tue, 4 Mar 2003 08:53:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15971.52941.412287.148296@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops:2.5.63 accessing software raid5 volume
In-Reply-To: message from Sampson Fung on Sunday March 2
References: <000e01c2e0b0$35229540$bca8a8c0@noelpc>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 2, sampson@attglobal.net wrote:
> My /dev/md0 is created in 2.4.18 and accessible in 2.4.19, 2.4.20,
> 2.5.58 to 2.5.62.
> 
> As upgraded to 2.5.63, after mounting /dev/md0 to /mnt/md0, then cd
> /mnt/md0, it Oops.
> 
> Finally, I re-mkraid /dev/md0, then e2fsck /dev/md0, then it Oops again
> with the following details:

If you could decode this with kysymoops, or  compile with
CONFIG_KALLSYMS, it would make it much easier to decode.

NeilBrown

> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> Oops: 0000
> CPU:	0
> EIP:	0060:[<00000000>]	Not tainted
> EFLAGS: 00010046
> eax: 00000000	ebx: dfbc88bc	ecx: dfbc89e0	edx: dfee8720
> esi: dfee8720	edi: dfbc8994	ebp: dfe88000	esp: dfe89f4c
> ds: 007b	es: 007b	ss: 0068
> Process events/0 (pid: 3, threadinfo=dfe88000 task=dfe8cc40)
> Stack: 	c02fe847 dfbc88bc dfbc8998 c0130983 dfbc88bc dfee8724 dfe88000
> dfbc88bc
> 	c02fe850 dfee8724 dfee8720 dfe8ffa8 dfee872c c01305f8 dfee8720
> dfe89fa0
> 	00000000 00000000 dfe88000 dfe88000 dfe88000 00000001 00000000
> c011e770
> Call Trace: [<c02fe847>] [<c0130983>] [<c02fe850>] [<c01305f8>]
> [<c011e770>] [<c010b24e>] [<c011e770>] [<c0130430>] [<c0108ff9>]
> Code: Bad EIP value.
>  <6>note: events/0[3] exited with preempt_count 1
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> ++
> 
> My .config is attached as config-2.5.63.
> 
> Regards,
> Sampson Fung
> A New Comer to Kernel Testing.
> 
