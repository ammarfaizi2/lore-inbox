Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278149AbRJRVox>; Thu, 18 Oct 2001 17:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278171AbRJRVon>; Thu, 18 Oct 2001 17:44:43 -0400
Received: from nature.Berkeley.EDU ([128.32.175.19]:38273 "EHLO
	nature.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S278168AbRJRVoc>; Thu, 18 Oct 2001 17:44:32 -0400
Date: Thu, 18 Oct 2001 14:45:05 -0700
From: "Brian C. Thomas" <bcthomas@nature.Berkeley.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: severe performance degradation on serverworks with high mem
Message-ID: <20011018144504.B134@nature.Berkeley.edu>
Mail-Followup-To: "Brian C. Thomas" <bcthomas@nature.Berkeley.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011018125714.A360@nature.Berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018125714.A360@nature.Berkeley.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I don't know if this helps, but I seem to have stumbled onto a
possible "fix" for this...

With 64GB high memory enabled in kernel 2.4.12-ac3, and mtrr turned
on, I was able to see all 8GB RAM on my machine by using the old
'append="mem=8000M"' command in my lilo.conf file... AND WITH NO LOSS
OF PERFORMANCE!

Does that help anyone with defining where this problem is coming from?

BCT

____________________________
Brian C. Thomas
bcthomas@nature.berkeley.edu

On Thu, Oct 18, 2001 at 12:57:15PM -0700, Brian C. Thomas wrote:
> Hi
> 
> I have a Supermicro S2QR6 board, which has the "Serverworks serverset
> III HE" chipset.  (Also, i have 8GB RAM, 4 Xeon P3 700MHz processors,
> and an Adaptec Ultra160 SCSI system - aix7xxx, built onto the 
> motherboard)
> 
> In all the 2.4.x series kernels (even up to 2.4.12-ac3 or
> 2.4.13-pre4), as soon as the high memory, 64GB option is enabled, the
> server slows down to a crawl, with no load showing.  (A "crawl"
> example is a kernel recompile time going from ~5 min to >2 hr!)
> 
> I have tried numerous kernel config options, removing scsi support,
> networking, and have narrowed the problem down to the serverworks
> chipset- on a SC440NX mb, also with 8GB and everything else in the
> system, all the new kernels work with no slowdown.
> 
> I've tried...
> kernels: 2.4.1, 2.4.3, 2.4.5, 2.4.7-ac9, 2.4.9, 2.4.12 (-pre4, -ac3)
> with and w/o mtrr support kernel config
> 
> Any ideas?
> 
> Thanks,
> 
> BCT
> 
> ____________________________
> Brian C. Thomas
> bcthomas@nature.berkeley.edu
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
