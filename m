Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRDSQzn>; Thu, 19 Apr 2001 12:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131472AbRDSQze>; Thu, 19 Apr 2001 12:55:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3918 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131246AbRDSQzT>; Thu, 19 Apr 2001 12:55:19 -0400
Date: Thu, 19 Apr 2001 19:17:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010419191706.D752@athlon.random>
In-Reply-To: <20010411125731.B6472@draal.physics.wisc.edu> <E14nOzo-0007Ew-00@the-village.bc.nu> <20010413084805.B3118@draal.physics.wisc.edu> <20010417170717.H2696@athlon.random> <20010417102840.B21824@draal.physics.wisc.edu> <20010419112117.E22687@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010419112117.E22687@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Thu, Apr 19, 2001 at 11:21:17AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 11:21:17AM -0500, Bob McElrath wrote:
> I'm at 2 days uptime now, and have not seen the process-table-hang.
> Looks like this fixed it.  Previously I would get a hang in the first
> day or so.  I'm using your alpha-numa-3 and rwsem-generic-4 against
> 2.4.4pre3.

good, thanks for the report.

BTW, if you upgrade to 2.4.4pre4 you can apply those two patches:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre4aa1/00_alpha-numa-4
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre4aa1/00_rwsem-generic-6

really the first is not necessary anymore unless you're using a wildfire. The
second also resurrect the optimized rwsemaphores for all archs but alpha and
ia32.

Andrea
