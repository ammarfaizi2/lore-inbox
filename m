Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSA1LZR>; Mon, 28 Jan 2002 06:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287148AbSA1LZF>; Mon, 28 Jan 2002 06:25:05 -0500
Received: from sushi.toad.net ([162.33.130.105]:18079 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S287111AbSA1LZC>;
	Mon, 28 Jan 2002 06:25:02 -0500
Subject: Re: 2.4.18-pre7 slow ... apm problem
From: Thomas Hood <jdthood@mail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <E16V8oV-0004FV-00@the-village.bc.nu>
In-Reply-To: <E16V8oV-0004FV-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 28 Jan 2002 06:25:05 -0500
Message-Id: <1012217107.746.5.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-28 at 05:14, Alan Cox wrote:
> Suppose vmware decides to switch between running Linux and its virtualised
> Windows OS. Can it do this during an interrupt - if so what ensures that
> vmware isnt switched to after we have done APM idle calls and slowed the
> CPU right down ?
> 
> If so then I suspect vmware should be issuing APM cpu busy calls itself

Do you see a difference between VMware and other processes
in their susceptibility to this problem?  If VMware runs
slowly because it gets scheduled in while the CPU is idle
and the apm driver fails to busyize the CPU, won't the same
thing happen for other processes?  If so, then our idle 
handling is fundamentally broken.  If not, then what makes
VMware special?


