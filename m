Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274104AbRISQsf>; Wed, 19 Sep 2001 12:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274107AbRISQsZ>; Wed, 19 Sep 2001 12:48:25 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:21767 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S274104AbRISQsO>; Wed, 19 Sep 2001 12:48:14 -0400
Date: Wed, 19 Sep 2001 17:37:26 +0200
From: Jens Axboe <axboe@suse.de>
To: "steve j. kondik" <shade@chemlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
Message-ID: <20010919173725.B11991@suse.de>
In-Reply-To: <1000912739.17522.2.camel@discord>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1000912739.17522.2.camel@discord>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19 2001, steve j. kondik wrote:
> i've been using encrypted swap over loopdev using the new cryptoapi
> patches.  i just built a 2.4.10-pre12 kernel and i got a panic doing
> mkswap on the loopdev.  the mkswap process becomes unkillable after this
> and never finishes.  this is repeatable everytime.  i've had no problems
> whatsoever until this kernel even under high load..  any ideas? :>
> 
> Sep 19 11:06:13 discord kernel: Unabl
> Sep 19 11:06:13 discord kernel: e to handle kernel NULL pointer
> dereference at virtual address 00000000
> Sep 19 11:06:13 discord kernel:  printing eip:
> Sep 19 11:06:13 discord kernel: 00000000
> Sep 19 11:06:13 discord kernel: *pde = 0f444067
> Sep 19 11:06:13 discord kernel: *pte = 00000000
> Sep 19 11:06:13 discord kernel: Oops: 0000
> Sep 19 11:06:13 discord kernel: CPU:    0
> Sep 19 11:06:13 discord kernel: EIP:    0010:[<00000000>]
> Sep 19 11:06:13 discord kernel: EFLAGS: 00010206
> Sep 19 11:06:13 discord kernel: eax: c02fbca0   ebx: cf47d000   ecx:
> 00000400   edx: cfb428c0
> Sep 19 11:06:13 discord kernel: esi: 00001000   edi: 00000c00   ebp:
> c1394d78   esp: cf447efc
> Sep 19 11:06:13 discord kernel: ds: 0018   es: 0018   ss: 0018
> Sep 19 11:06:13 discord kernel: Process mkswap (pid: 9902,
> stackpage=cf447000)
> Sep 19 11:06:13 discord kernel: Stack: c012a371 cfb428c0 c1394d78
> 00000400 00001000 cfcd61b0 001828c4 00000000 
> Sep 19 11:06:13 discord kernel:        00000000 00001000 00000400
> 00000c00 fffffff4 00000000 00000400 00000000 
> Sep 19 11:06:13 discord kernel:        cfa9210c cfa92060 00000000
> c01a1ba0 00126000 00001000 00000003 32000022 
> Sep 19 11:06:13 discord kernel: Call Trace: [<c012a371>] [<c01a1ba0>]
> [<c01359c0>] [<c01357fe>] [<c0106ebb>] 
> Sep 19 11:06:13 discord kernel: 
> Sep 19 11:06:13 discord kernel: Code:  Bad EIP value.
> Sep 19 11:06:13 discord kernel:  Unable to find swap-space signature

ksymoops it please

-- 
Jens Axboe

