Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWEUSLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWEUSLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWEUSLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:11:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5332 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751546AbWEUSLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:11:08 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 0/9] namespaces: Introduction
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<m1sln61jqs.fsf@ebiederm.dsl.xmission.com>
	<20060521162759.GA19707@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 21 May 2006 12:08:53 -0600
In-Reply-To: <20060521162759.GA19707@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Sun, 21 May 2006 11:27:59 -0500")
Message-ID: <m1verzntca.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

>
> Here are the numbers with the basic patchsets.  But I guess I should
> do another round with adding 7 more void*'s to represent additional
> namespaces.

I'm a little slow coming up to speed on these benchmarks.
dbench and tbench are measured in megabytes per second correct?
kernbench is the number of seconds it takes to compile a kernel?
reaim is measured in jobs per minute?

So if I read this right the differences are currently in
the noise levels, from your testing.

> (intervals are for 95% CI, tests were each run 15 times)
>
>            |  with nsproxy  |   without nsproxy |
> kernbench  | 68.90 +/- 0.21 |   69.06 +/- 0.22  |
> dbench     | 386.0 +/- 26.6 |   388.4 +/- 21.0  |
> tbench     | 391.6 +/- 8.00 |   389.4 +/- 10.95 |
>
> reaim with nsproxy
> 1 115600.000000 5512.441557
> 3 246985.712000 9375.780582
> 5 272309.092000 8029.833742
> 7 290020.000000 7288.367116
> 9 298591.580000 5557.531915
> 11 nan nan
> 13 nan nan
> 15 nan nan
>
> reaim without nsproxy
> 1 110160.000000 5728.697311
> 3 246985.712000 9375.780582
> 5 262204.197333 11138.510652
> 7 288660.000000 6880.898412
> 9 300631.580000 4351.926692
> 11 nan nan
> 13 nan nan
> 15 nan nan
