Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135828AbRAGQoP>; Sun, 7 Jan 2001 11:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135483AbRAGQoF>; Sun, 7 Jan 2001 11:44:05 -0500
Received: from lairdtest1.internap.com ([206.253.215.67]:13843 "EHLO
	lairdtest1.internap.com") by vger.kernel.org with ESMTP
	id <S135443AbRAGQoA>; Sun, 7 Jan 2001 11:44:00 -0500
Date: Sun, 7 Jan 2001 08:43:52 -0800 (PST)
From: Scott Laird <laird@internap.com>
To: Jeff Forbes <jgf@stellarhost.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM with raid5 and 2.4.0 kernel
In-Reply-To: <5.0.2.1.2.20010107112405.03223780@celticclans.com>
Message-ID: <Pine.LNX.4.21.0101070842391.13842-100000@lairdtest1.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It works if you compile the kernel with the processor type set to Pentium
II or higher, or disable RAID5.  I've been meaning to report this one, but
2.4.0 was released before I had time to test the last prerelease, and I
haven't had time to test the final release yet.


Scott

On Sun, 7 Jan 2001, Jeff Forbes wrote:

> I have been trying out the new 2.4.0 kernel and am unable to get
> raid5 to work. When I install the raid5 module with
> modprobe raid5
> I get a segmentation fault and the following error appears in the dmesg output:
> 
> raid5: measuring checksumming speed
>     8regs     :   806.577 MB/sec
>     32regs    :   548.259 MB/sec
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<d4862b09>]
> EFLAGS: 00010206
> eax: d240fe88   ebx: d23f2f40   ecx: 0000000f   edx: 8005003b
> esi: d23f0000   edi: 0001720a   ebp: 00000000   esp: d240fe80
> ds: 0018   es: 0018   ss: 0018
> Process modprobe (pid: 748, stackpage=d240f000)
> Stack: 00000000 00000000 00000020 c0113cba 0000059f 000010dd 00017209 00000005
>         c0257424 00000286 00000001 c0257423 c0257403 00000020 d4864090 
> d4864434
>         d486442d 00000224 d4864004 00000f40 d23f0000 d23f2f40 d23f0000 
> d23f2f40
> Call Trace: [<c0113cba>] [<d4864090>] [<d4864434>] [<d486442d>] 
> [<d4864004>] [<d4862aec>] [<d48640fc>]
>         [<d4864674>] [<d4864117>] [<d486463c>] [<d4862000>] [<d486409c>] 
> [<c012a0ca>] [<d4862000>] [<c01149a8>]
>         [<d484f000>] [<d4862060>] [<c0108d7f>]
> 
> Code: 0f 11 00 0f 11 48 10 0f 11 50 20 0f 11 58 30 0f 18 4e 00 0f
> 
> when I modprobe raid5 again no errors are reported and dmesg has the following
> 
> md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md.c: sizeof(mdp_super_t) = 4096
> raid5 personality registered
> 
> Of course raid5 cannot be compiled into the kernel since it also gives the 
> same error as above and dies.
> 
> Any ideas?
> 
> 
> Jeffrey Forbes, Ph.D.
> http://www.stellarhost.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
