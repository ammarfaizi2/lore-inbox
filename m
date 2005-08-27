Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVH0M0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVH0M0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 08:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVH0M0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 08:26:24 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.19]:26667 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030371AbVH0M0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 08:26:23 -0400
Subject: Re: Linux 2.6 context switching and posix threads performance
	question
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050827121158.GA18406@oepkgtn.mshome.net>
References: <20050827121158.GA18406@oepkgtn.mshome.net>
Content-Type: text/plain
Date: Sat, 27 Aug 2005 14:26:22 +0200
Message-Id: <1125145582.20161.62.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-27 at 14:11 +0200, Mateusz Berezecki wrote:
> Hello List Readers,
> 
> I would really appreciate any comment on the overall performance of task
> switching with 25 000 threads running on the Linux system. I was asked to work
> on some software which spawns 25 000 threads and I am really worried if
> it will ever work on 2 CPU HP Blade. The kernel was modified to support
> bigger threads amount running (I have no idea how it was done, probably
> just changing hardcoded limits) What is the performance impact of
> so much threads on the overall system performance? Is there any ?
> Wouldn't it be that such application would spend all of its time
> switching contexts ? I'm asking for some kind of an authoritative answer
> quite urgently. What is the optimum thread amount on 2 CPU SMP system
> running Linux ?
> 
Well the obvious question is: what kernel version and which thread
library?

2.4 with LinuxThreads might have severe problems. However 2.6 with NPTL
should be able to handle it, IIRC Igno once did a million threads with
that combination just to show that it worked ;-).


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

