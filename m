Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTEKWTj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbTEKWTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:19:39 -0400
Received: from corky.net ([212.150.53.130]:10889 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S261288AbTEKWTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 18:19:36 -0400
Date: Mon, 12 May 2003 01:32:10 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <200305111642_MC3-1-3868-F544@compuserve.com>
Message-ID: <Pine.LNX.4.44.0305120115440.2983-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Not on the systems I've seen.  Max log file size is 4GB and the
> logs are on their own partition.  If the file fills up the system
> crashes immediately and only administrators can log in after reboot
> until the logs are archived.

Why would anyone design a system like that ?!
The logging of every security system is prone to flooding.  You may have
noticed that your syslog sometimes spits "Last message repeated N times"
so it won't repeat itself.  A system that doesn't deal with this issue in
any way can't be secure.  There are a lot of methods to deal with it but I
think we're going seriously off-topic here so if anyone wishes to continue
discussing this specific logging problem, I suggest we switch to non-lkml
mode.

>   Yes, but now any unsuccessful attempts to change the name will be
> logged, where before there was basically no risk for the attacker
> trying over and over until success.  Even a single failure could
> raise an alert on the target machine, something a cracker definitely
> does not want to happen.
>

Not necessarily - it depends on the case.  If the file being unlinked is
the logfile itself, and its checked by an cron job every once in a while
(a common situation), an attacker won't mind making a lot of noise into
the soon-to-be-a-free-inode logfile.  After-the-fact security systems are
usually not suitable for server protection, and the system you suggest,
being statistical, is after-the-fact by definition.

	Yoav Weiss


