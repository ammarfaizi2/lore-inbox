Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWHWHe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWHWHe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 03:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWHWHe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 03:34:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:11744 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751426AbWHWHe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 03:34:56 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <20060820174839.GH13917@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	 <20060820174839.GH13917@in.ibm.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 09:43:28 +0000
Message-Id: <1156326208.6265.33.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 23:18 +0530, Srivatsa Vaddagiri wrote:

> As an example, follow these steps to create metered cpusets:
> 
> 
> 	# cd /dev
> 	# mkdir cpuset
> 	# mount -t cpuset cpuset cpuset
> 	# cd cpuset
> 	# mkdir grp_a
> 	# cd grp_a
> 	# /bin/echo "6-7" > cpus	# assign CPUs 6,7 for this cpuset
> 	# /bin/echo 0 > mems		# assign node 0 for this cpuset
> 	# /bin/echo 1 > cpu_exclusive
> 	# /bin/echo 1 > meter_cpu

Implementation might need some idiot proofing.

After mount/cd cpuset, somebody might think "gee, why should I need to
create a group 'all', when it's right there in the root, including all
it's tasks?  I'll just set cpu_exclusive, set meter_cpu...

...and after my box finishes rebooting, I'll alert the developer of this
patch set that very bad things happen the instant you do that :)

	-Mike

