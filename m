Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263238AbUJ2LLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbUJ2LLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUJ2LLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:11:40 -0400
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:18305 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S263238AbUJ2LKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:10:54 -0400
Date: Fri, 29 Oct 2004 13:10:49 +0200
From: mmokrejs@ribosome.natur.cuni.cz
To: linux-kernel@vger.kernel.org
Cc: nathans@sgi.com
Subject: Re: Filesystem performance on 2.4.28-pre3 on hardware RAID5.
Message-ID: <20041029111049.GA554@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan, Marcello and others,
  the collested meminfo, slabinfo, vmstat output are at
http://www.natur.cuni.cz/~mmokrejs/crash/

Those precrash-* files contain output since the machine
was fresh, every second I appended current stats to each
of them. I believe some data were not flushed into the disk
before the problem.

I get on STDERR "fork: Cannot allocate memory"

Using anothe ropen console session and doing df gives me:

start_pipeline: Too many open files in system
fork: Cannot allocate memory

I had fortunately xdm to kill, so I could then do
sync and collect some stats (although some resources
got freed by xdm/X11). Those files are named with
prefix crash-*.

After that, I decided to put continue the suspended job,
and those files collected are precrash2-* prefixed.

There /var/log/messages included.

If you tell what kind of memory/xfs debugging I should turn
on adn *how*, I can do it immediately. I don't have access
to the machine daily, and already had to be in production. :(

Martin
P.S: It is hardware raid5. I use mkfs.xfs version 2.6.13.
