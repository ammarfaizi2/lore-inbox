Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVH3RqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVH3RqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVH3RqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:46:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34247 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932237AbVH3RqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:46:13 -0400
Date: Tue, 30 Aug 2005 10:46:09 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Mateusz Berezecki <mateuszb@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 context switching and posix threads performance question
In-Reply-To: <20050827121158.GA18406@oepkgtn.mshome.net>
Message-ID: <Pine.LNX.4.62.0508301044400.15675@schroedinger.engr.sgi.com>
References: <20050827121158.GA18406@oepkgtn.mshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2005, Mateusz Berezecki wrote:

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

At 32k threads you run into the limit of waiters for RW semaphores. So 
make sure that the number stays lower than that or use a 64 bit platform 
that supports more threads.

