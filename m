Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285495AbRLGUE6>; Fri, 7 Dec 2001 15:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285496AbRLGUEr>; Fri, 7 Dec 2001 15:04:47 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:42912 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S285495AbRLGUEb>; Fri, 7 Dec 2001 15:04:31 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Brian <hiryuu@envisiongames.net>
Date: Sat, 8 Dec 2001 07:04:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15377.8389.648294.417287@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: knfsd and memory usage
In-Reply-To: message from Brian on Friday December 7
In-Reply-To: <200112071645.fB7GjLE03441@demai05.mw.mediaone.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 7, hiryuu@envisiongames.net wrote:
> So I have this new file server (2.4.16), and it's memory looks like
> Mem:    771952K total,   767492K used,     4460K free,    22016K buffers
> Swap:        0K total,        0K used,        0K free,    71848K cached
> 
> So cache, buffers, and free memory account for ~100MB.
> There are a handful of userspace processes taking ~20MB.
> 
> Obviously I expect the kernel to take up some memory, but 650 megs?

Have a look at /proc/slabinfo.  It might show you where the memory is.

> 
> Is there I way I can find out where all of that memory went?
> If knfsd is hoarding (no other box has this much unaccounted for), is 
> there a way to tweak it at runtime?  Are there 'safe' things to adjust at 
> compile time?

knfsd directly uses about 20K per thread.  Maybe as much as 30.  Any
other memory usage is incidental and should be cleaned up by memory
pressure.

NeilBrown
