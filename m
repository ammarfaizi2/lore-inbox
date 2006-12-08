Return-Path: <linux-kernel-owner+w=401wt.eu-S1760719AbWLHN5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760719AbWLHN5d (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 08:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760724AbWLHN5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 08:57:33 -0500
Received: from [212.33.187.138] ([212.33.187.138]:32922 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760719AbWLHN5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 08:57:33 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: additional oom-killer tuneable worth submitting?
Date: Fri, 8 Dec 2006 16:58:29 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081658.29338.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> > On an embedded platform this allows the designer to engineer the system
> > and protect critical apps based on their expected memory consumption.
> > If one of those apps goes crazy and starts chewing additional memory
> > then it becomes vulnerable to the oom killer while the other apps remain
> > protected.
>
> That is why we have no-overcommit support.

Alan, I think you know that this isn't really true, due to shared-libs.

> Now there is an argument for
> a meaningful rlimit-as to go with it, and together I think they do what
> you really need.

The problem with rlimit is that it works per process.  Tuning this by hand 
may be awkward and/or wasteful.  What we need is to rlimit on a global 
basis, by calculating an upperlimit dynamically, such as to avoid 
overcommit/OOM.


Thanks!

--
Al

