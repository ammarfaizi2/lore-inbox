Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTHLJ47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbTHLJ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:56:59 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:42661
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265531AbTHLJ45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:56:57 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Mike Galbraith <efault@gmx.de>,
       Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy   ...
Date: Tue, 12 Aug 2003 03:23:13 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net> <5.2.1.1.2.20030810084805.01a0dfa8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030810084805.01a0dfa8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120323.14612.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 August 2003 03:11, Mike Galbraith wrote:
> Everything I've seen says "you need at least a 300Mhz cpu to decode".  My
> little cpu is 500Mhz, so I'd have to make more than half of my total
> computational power available for SCHED_SOFTRR tasks for video decode in
> realtime to work.  Even on my single user box, I wouldn't want to have to
> fight for cpu because some random developer decided to use
> SCHED_SOFTRR.  If I make that much cpu available, someone will try to use
> it.  Personally, I think you should need authorization for even tiny
> amounts of cpu at this priority.
>
>          -Mike

Perhaps you want some kind of extension to "renice" to allow a running process 
to be have its percent chopped back then?  (Without necessarily affecting the 
global reserve?)

Shouldn't require root, just require running as the same user as the process.  
(if you can 'kill -SIGSTOP" a task, you should be able to reduce its 
priority...)

Rob


