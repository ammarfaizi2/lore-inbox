Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbUCZUyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbUCZUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:54:39 -0500
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:8338 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP id S264128AbUCZUyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:54:36 -0500
Date: Fri, 26 Mar 2004 14:54:31 -0600
From: Daniel Forrest <forrest@lmcg.wisc.edu>
Message-Id: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: Somewhat OT: gcc, x86, -ffast-math, and Linux
Reply-to: Daniel Forrest <forrest@lmcg.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried Googling for an answer on this, but have come up empty and
I think it likely that someone here probably knows the answer...

We are testing and breaking in 6 racks of compute nodes, each rack
containing 30 1U boxes, each box containing 2 x 2.8GHz Xeon CPUs.
Each rack contains identical hardware (single purchase) with the
exception that one rack has double the memory per node.  The 6 racks
are located in six different labs across our campus.  It is available
to me only as a "black box" queueing system.

I am running one of our applications that has been compiled using gcc
with the -ffast-math option.  I am finding that the identical program
using the same input data files is producing different results on
different machines.  However, the differences are all less than the
precision of a single-precision floating point number.  By this I mean
that if the results (which are written to 15 digits of precision) are
only compared to 7 digits then the results are the same.  Also, most
of the time the 15 digit values are the same.

My question is this: Why aren't the results always the same?  What is
the -ffast-math option doing?  How are the excess bits of precision
dealt with during context switches?  Shouldn't the same binary with
the same inputs produce the same output on identical hardware?

I have run the same test with the program compiled without -ffast-math
enabled and the results are always identical.

Any insight would be appreciated.

-- 
Daniel K. Forrest	Laboratory for Molecular and
forrest@lmcg.wisc.edu	Computational Genomics
			University of Wisconsin, Madison
