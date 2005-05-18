Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVERRrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVERRrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVERRrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:47:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59527 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262195AbVERRrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:47:20 -0400
Subject: Re: software mixing in alsa
From: Lee Revell <rlrevell@joe-job.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0505181540440.1840@pnote.perex-int.cz>
References: <20050517095613.GA9947@kestrel>
	 <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel>
	 <1116354762.31830.12.camel@mindpipe>
	 <20050517192412.GA19431@kestrel.twibright.com>
	 <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
	 <1116362191.32210.24.camel@mindpipe> <20050518133215.GB13736@kestrel>
	 <Pine.LNX.4.58.0505181540440.1840@pnote.perex-int.cz>
Content-Type: text/plain
Date: Wed, 18 May 2005 13:47:17 -0400
Message-Id: <1116438438.4866.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 15:53 +0200, Jaroslav Kysela wrote:
> On Wed, 18 May 2005, Karel Kulhavy wrote:
> 
> > On Tue, May 17, 2005 at 04:36:30PM -0400, Lee Revell wrote:
> > 
> > [...]
> > 
> > > alsa-lib, which is part of userspace.  From the application's point of
> > > view, it does not matter whether the mixing happens in kernel or not.
> > > ALSA follows the philosophy of doing as little as possible in the
> > > kernel, and since mixing and volume control work fine in userspace,
> > > that's where they live.
> > 
> > Mixing is IMHO action that should be in kernel because
> > 
> > 1) needs realtime scheduling to keep latency down
> 
> With a realtime scheduler and properly written drivers (no "schedule"  
> gaps) you'll reach same results. For x86 we use special instructions like
> xchg and locking-free algorithm in dmix, so the latency is SAME for all 
> concurent apps with minimal overhead..

Also doing it in userspace lets us use SSE/MMX.

Lee

