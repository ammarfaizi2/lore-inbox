Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSFFVg4>; Thu, 6 Jun 2002 17:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSFFVgz>; Thu, 6 Jun 2002 17:36:55 -0400
Received: from ns.suse.de ([213.95.15.193]:15877 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317216AbSFFVgy>;
	Thu, 6 Jun 2002 17:36:54 -0400
Date: Thu, 6 Jun 2002 23:36:55 +0200
From: Dave Jones <davej@suse.de>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
Message-ID: <20020606233655.E16262@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Thomas 'Dent' Mirlacher <dent@cosy.sbg.ac.at>,
	Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3CFFBCA9.843C40F0@zip.com.au> <Pine.GSO.4.05.10206062318190.19900-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 11:23:11PM +0200, Thomas 'Dent' Mirlacher wrote:
 > > and then go edit every SMP-capable arch's config.in/Config.help
 > > files.  But the arch maintainers should test one case please - x86
 > > was locking up at boot on quad CPU with NR_CPUS=2.  Others may do
 > > the same.
 > 
 > well, what you need to do is make sure smp_num_cpu <= NR_CPUS,
 > otherwise the kernel will go ballistic on several places within
 > the code.

*nod*, relying on the user to get it right may not be as simple
as it seems. Quite a few people were pleasantly surprised when
their 2-way P4 Xeon become a 4-way HT P4 box.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
