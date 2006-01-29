Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWA2IVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWA2IVq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 03:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWA2IVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 03:21:46 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32424 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750869AbWA2IVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 03:21:45 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com,
       paulmck@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060129075144.GA15056@elte.hu>
References: <20060124213802.GC7139@in.ibm.com>
	 <1138224506.3087.22.camel@mindpipe> <20060126191809.GC6182@us.ibm.com>
	 <1138388123.3131.26.camel@mindpipe> <20060128170302.GB5633@in.ibm.com>
	 <1138471203.2799.13.camel@mindpipe> <1138474283.2799.24.camel@mindpipe>
	 <20060128193412.GH5633@in.ibm.com> <43DBCB62.7030308@cosmosbay.com>
	 <1138520283.2799.103.camel@mindpipe>  <20060129075144.GA15056@elte.hu>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 03:21:41 -0500
Message-Id: <1138522902.2799.111.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 08:51 +0100, Ingo Molnar wrote:
> 
> well, softirq preemption is not really a drastic step - its biggest 
> problem is that it cannot be included in v2.6.16 ;-) But i agree that
> if a solution can be found to break up a latency path, that is
> preferred.
> 

Agreed.  It's only drastic in the context of my target (meeting a 1ms
soft RT constraint) as this happens to be the one of the only code paths
getting in the way.  Also I'd like to be able to go down to 1ms without
requiring a custom kernel config...

Lee

