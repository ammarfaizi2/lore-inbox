Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVK2TFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVK2TFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVK2TFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:05:50 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:7060 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932351AbVK2TFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:05:49 -0500
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
From: Lee Revell <rlrevell@joe-job.com>
To: John Reiser <jreiser@BitWagon.com>
Cc: Andi Kleen <ak@suse.de>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
In-Reply-To: <438C9E1B.8040204@BitWagon.com>
References: <20051129151515.GG19515@wotan.suse.de>
	 <200511291056.32455.raybry@mpdtxmail.amd.com>
	 <20051129180903.GB6611@frankl.hpl.hp.com>
	 <20051129181344.GN19515@wotan.suse.de>  <438C9E1B.8040204@BitWagon.com>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 14:05:43 -0500
Message-Id: <1133291144.4627.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 10:29 -0800, John Reiser wrote:
> Andi Kleen wrote:
> > I think it's also a useful convention - RDTSC is becomming more and more
> > useless and you cannot expect user applications who just want to
> > measure some cycles to rely on ever changing instable or non existing
> > performance counter APIs.
> 
> Users are even more unhappy with ever-changing ABIs -- such as the
> kernel taking away RDTSC.
> 
> RDTSC+perfctr [Pettersson] still is the fastest way for user-mode code
> to count something that is highly correlated with both "billable"
> CPU time and "code quality" for a fixed task.  With a little care
> RDTSC is close enough to monotonic that I find it very useful.
> Please don't take away user-mode RDTSC.
> 

The kernel didn't take this away, the hardware vendors did.  For years
although it was risky on paper it was perfectly usable as a cheap high
res timer.  I agree that it's unfortunate.

Lee

