Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272226AbTHNGxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 02:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272227AbTHNGxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 02:53:41 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:17326
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272226AbTHNGxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 02:53:33 -0400
From: Con Kolivas <kernel@kolivas.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] O12.2int for interactivity
Date: Thu, 14 Aug 2003 16:59:33 +1000
User-Agent: KMail/1.5.3
Cc: rob@landley.net, Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F3A5D61.7080207@techsource.com> <20030814060959.GK32488@holomorphy.com>
In-Reply-To: <20030814060959.GK32488@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308141659.33447.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 16:09, William Lee Irwin III wrote:
> William Lee Irwin III wrote:

> "scale" on which scheduling events should happen, and as tasks become
> more cpu-bound, they have longer timeslices, so that two cpu-bound
> tasks of identical priority will RR very slowly and have reduced
> context switch overhead, but are near infinitely preemptible by more
> interactive or short-running tasks.

Actually the timeslice handed out is purely dependent on the static priority, 
not the priority it is elevated or demoted to by the interactivity estimator. 
However lower priority tasks (cpu bound ones if the estimator has worked 
correctly) will always be preempted by higher priority tasks (interactive 
ones) whenever they wake up.

Con

