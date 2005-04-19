Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVDSUM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVDSUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVDSUM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:12:28 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:4319 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261652AbVDSUM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:12:26 -0400
Date: Tue, 19 Apr 2005 16:12:25 -0400
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050419201225.GW4373@csclub.uwaterloo.ca>
References: <20050419121530.GB23282@schottelius.org> <20050419132417.GS17865@csclub.uwaterloo.ca> <1113938220.20178.0.camel@mindpipe> <20050419200011.GB16594@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419200011.GB16594@schottelius.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 10:00:12PM +0200, Nico Schottelius wrote:
> Can you tell me which ones?

top for example would probably break.  Maybe not but I suspect it would.
mplayer probably would since it uses it to find the cpu type and
features that cpu supports.

> And if there are really that many tools, which are dependent on
> those information, wouldn't it be much more senseful to make
> it (as far as possible) the same?

Well the tools that care are often architecture specific.  After all the
info in cpuinfo is very architecture specific.

> I must say I was really impressed, how easy I got the number of
> cpus on *BSD (I am not a bsd user, still impressed).

Well there still is that sysconf call to get the number of cpus, which
is way better in C than parsing a text file to get the info as far as I
am concerned.

> They also have the same format on every arch and mostly the same
> between different bsds (as far as I have seen).

What info do they provide in that on BSD?

> In general, where are the advantages of having very different cpuinfo
> formats? Tools would need to know less about the arch and could
> depend on "I am on Linux" only.

The info in cpuinfo is only of interest to a tool that knows about the
architecture it is on.

It is not meant to look up the number of cpus the system has.  It is
meant to provide the info about the cpus in the system, which means it
provides info relevant to the cpu on a given architecture.

Len Sorensen
