Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTEOJHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTEOJHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:07:38 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:60840 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263880AbTEOJHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:07:37 -0400
To: Robert Love <rml@tech9.net>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <1052990397.3ec35bbd5e008@netmail.pipex.net>
Date: Thu, 15 May 2003 10:19:57 +0100
From: "Shaheed R. Haque" <srhaque@iee.org>
Cc: shaheed <srhaque@iee.org>, Felipe Alfaro Solana <yo@felipe-alfaro.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net>  <1052910149.586.3.camel@teapot.felipe-alfaro.com>  <1052927975.883.9.camel@icbm>  <200305142201.59912.srhaque@iee.org> <1052946917.883.25.camel@icbm>
In-Reply-To: <1052946917.883.25.camel@icbm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail 2.2.0-pre13
X-PIPEX-username: aozw65%dsl.pipex.com
X-Originating-IP: 195.166.116.245
X-Usage: Use of PIPEX NetMail is subject to the PIPEX Terms and Conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Robert Love <rml@tech9.net>:

> More important to me is getting it into Red Hat and SuSE. I have heard
> encouring words from Matt Wilson at Red Hat about schedutils possibly
> going into Rawhide soon. It would not hurt to let Red Hat/SuSE/whoever
> know that schedutils is something their customers want.
>
> Both Red Hat and SuSE's kernels have the CPU affinity system calls
> merged, so you do not need to wait until 2.6 is out to use them.

These are the distros I am interested in too. I knew it was in RH AS/ES, but 
are you saying it is in RH9.0? That would be good news.

On the technical point, I tried out taskset in rc.sysinit, and as you said, it 
works just fine. On reflection, I feel that editing rc.sysinit is not the right 
answer given the confidence/competence level of our customers' typical 
sysadmins: but I can see that a carefully crafted rc5.d/S00aaaaa script could 
set the affinity of the executing shell, and its parent(s) upto init to fix all 
subsequent rcN.d children in the desired manner.

I do suspect that other commercial users will also baulk at editing rc.sysint, 
and so have to brew the same rcN.d solution. Now, the rcN.d script hackery 
would be greatly simplified if taskset had a mode of "set the affinity of the 
identified process, and all its parent processes upto init". Would you accept a 
patch to taskset along those lines?

I think that would be a very acceptable, easy to deploy, solution.

Thoughts? Shaheed


