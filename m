Return-Path: <linux-kernel-owner+w=401wt.eu-S1751931AbWLNBVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWLNBVw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWLNBVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:21:52 -0500
Received: from quechua.inka.de ([193.197.184.2]:48922 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbWLNBVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:21:51 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Processes with hidden PID files in /proc
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20061213180801.A16952@yoda.lmcg.wisc.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1GufIC-0002Un-00@calista.eckenfels.net>
Date: Thu, 14 Dec 2006 02:21:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20061213180801.A16952@yoda.lmcg.wisc.edu> you wrote:
> I've Googled on this enough to find out that these are Linux threads,
> that "ps -m" will show them, that "ls -a /proc" will show /proc/.PPID,
> etc, but I'm still wondering what exact sequence of system calls will
> create a process like this?

clone(2) can be used to create a thread in a new thread group. If that
thread forks, the resulting child has the (invisible) thread group as parent
pid.

Gruss
Bernd
