Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbUKQAbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbUKQAbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUKQAbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:31:38 -0500
Received: from hera.kernel.org ([63.209.29.2]:64418 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261910AbUKQAaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:30:08 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
Date: Tue, 16 Nov 2004 16:32:57 -0800
Organization: Open Source Development Lab
Message-ID: <20041116163257.0e63031d@zqx3.pdx.osdl.net>
References: <419A9151.2000508@atmos.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1100651398 16809 172.20.1.73 (17 Nov 2004 00:29:58 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 17 Nov 2004 00:29:58 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 15:46:25 -0800
Harry Edmon <harry@atmos.washington.edu> wrote:

> I have a system that is running a program that receives and sends 
> atmospheric data via TCP.  Most of the data is either in little packets 
> (between 64 and 127 bytes) and large packets (between 1024 and 1517).  I 
> am running this on a dual Xeon box (Tyan S2721-533 motherboard) with 2 
> GB of memory and a Intel gigabit ethernet (82546EB).  I have been 
> running this under 2.6.7.  When I switch to 2.6.9 on the same hardware, 
> my network throughtput is cut by more than half.  All I can tell from 
> looking at "netstat -s" is that my TCP resets are orders of magnitude 
> higher under 2.6.9 than 2.6.7.  Enclosed is my 2.6.7 and 2.6.9 config 
> files.  Anyone have any ideas where I should look to find the problem?

Do an OpenBSD or other firewall in the way that doesn't understand window
scaling? OpenBSD pf doesn't correctly TCP window scaling so it ruins the
throughput (typically 1/4 of expected).
