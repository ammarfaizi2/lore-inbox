Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752160AbWCJCGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbWCJCGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbWCJCGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:06:06 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3551 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752106AbWCJCGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:06:05 -0500
Subject: Re: How can I link the kernel with libgcc ?
From: Lee Revell <rlrevell@joe-job.com>
To: Valdis.Kletnieks@vt.edu
Cc: Carlos Munoz <carlos@kenati.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200603100145.k2A1jMem005323@turing-police.cc.vt.edu>
References: <4410D9F0.6010707@kenati.com>
	 <200603100145.k2A1jMem005323@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 21:06:01 -0500
Message-Id: <1141956362.13319.105.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 20:45 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 09 Mar 2006 17:44:16 PST, Carlos Munoz said:
> > I'm writing an audio driver and the hardware requires floating point 
> > arithmetic.  When I build the kernel I get the following errors at link 
> > time:
> 
> Tough break, that.  You sure you can't figure a way to either push the
> floating point out to userspace

Audio drivers should never have to directly manipulate the samples -
they just manage the DMA buffers and interrupts and wake up the process
at the right time.  Mixing, routing, volume control, DSP go in
userspace.

Lee

