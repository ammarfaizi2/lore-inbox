Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293709AbSCPFP1>; Sat, 16 Mar 2002 00:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293712AbSCPFPR>; Sat, 16 Mar 2002 00:15:17 -0500
Received: from mail.bstc.net ([63.90.24.2]:47634 "HELO mail.bstc.net")
	by vger.kernel.org with SMTP id <S293709AbSCPFPK>;
	Sat, 16 Mar 2002 00:15:10 -0500
Date: Sat, 16 Mar 2002 16:12:48 +1100
From: Anton Blanchard <anton@samba.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Momchil Velikov <velco@fadata.bg>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316051248.GA9396@krispykreme>
In-Reply-To: <20020313085217.GA11658@krispykreme> <20020314112725.GA2008@krispykreme> <87wuwfxp25.fsf@fadata.bg> <E16la2m-0000SX-00@starship> <20020315121656.GA8030@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315121656.GA8030@tapu.f00f.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> What about doing soft TLB reloads then?

ppc32 linux preloads entries into the hashed pagetable in
update_mmu_cache. Im about to commit a patch to do the same thing
in ppc64, at the moment we take two exceptions per pagefault which
is pretty ugly.

Some ppc32 hardware does allow you to take an exception for a TLB miss
(ie bypass the hashed pagetable completely).

Anton
