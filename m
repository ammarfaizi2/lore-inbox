Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSGSGrj>; Fri, 19 Jul 2002 02:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSGSGrj>; Fri, 19 Jul 2002 02:47:39 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:47386 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S315762AbSGSGri>; Fri, 19 Jul 2002 02:47:38 -0400
Date: Fri, 19 Jul 2002 07:52:49 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: <stoffel@lucent.com>
cc: Robert Love <rml@tech9.net>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <15671.5657.312779.438143@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.30.0207190708260.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jul 2002 stoffel@lucent.com wrote:
> Szakacsits> About 99% of the people don't know about, don't understand
> Szakacsits> or don't care about resource limits. But they do care
> Szakacsits> about cleaning up when mess comes. Adding reserved root
> Szakacsits> memory would be a couple of lines
>
> So what does this buy you when root itself runs the box into the
> ground?  Or if a dumb user decides to run his process as root, and it
> takes down the system?

You would be able to point out them running stuffs as root is the
worst scenario from security and reliability point of view. You can
argue about security now but not reliability because it doesn't matter
who owns the "runaway" processes, the end result is either uncontrolled
process killing (default kernel) or livelock (strict overcommit patch).

You can't solve everybody's problems of course but you can educate
them however at present the kernel misses the features to do so [and
for a moment *please* ignore the resource control/accounting with all
its benefits and deficients on Linux, there are lot's of way to do
resource control and Linux is quite infant at present].

> You're arguing for the wrong thing here.

How about consulting with some Sun or ex-Dec engineers why they have
this feature for (internet) decades? Because at default they use
strict overcommit and that's shooting yourself in the foot without
reserved root vm on a general purposes system.

	Szaka

