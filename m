Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSFTMrp>; Thu, 20 Jun 2002 08:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSFTMro>; Thu, 20 Jun 2002 08:47:44 -0400
Received: from ns.suse.de ([213.95.15.193]:29446 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314096AbSFTMrm>;
	Thu, 20 Jun 2002 08:47:42 -0400
Date: Thu, 20 Jun 2002 14:47:39 +0200
From: Dave Jones <davej@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ckulesa@as.arizona.edu,
       torvalds@transmeta.com
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <20020620144739.A29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, rwhron@earthlink.net,
	linux-kernel@vger.kernel.org, ckulesa@as.arizona.edu,
	torvalds@transmeta.com
References: <20020620040749.GA32177@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020620040749.GA32177@rushmore>; from rwhron@earthlink.net on Thu, Jun 20, 2002 at 12:07:49AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 12:07:49AM -0400, rwhron@earthlink.net wrote:

 > The compile error on 2.5.23-dj1 was:
 > 
 > gcc -Wp,-MD,./.qlogicisp.o.d -D__KERNEL__ -I/usr/src/linux-2.5.23-dj1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=qlogicisp   -c -o qlogicisp.o qlogicisp.c
 > qlogicisp.c:2005: unknown field `abort' specified in initializer
 > qlogicisp.c:2005: warning: initialization from incompatible pointer type
 > qlogicisp.c:2005: unknown field `reset' specified in initializer
 > qlogicisp.c:2005: warning: initialization from incompatible pointer type

Ok, it looks like it hasn't been updated to include the new-style EH yet
(although there are/were some that had both). Setting the option
"Use SCSI drivers with broken error handling [DANGEROUS]" in the SCSI
submenu will give same behaviour as that driver does in Linus' tree.
Ie, it will compile, but possibly not have any working error handling.
It should be ok for benchmarking though..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
