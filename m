Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWJMXkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWJMXkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWJMXkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:40:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:28616 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752002AbWJMXkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:40:11 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Matt Helsley <matthltc@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20061012235127.GA15767@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011223927.GA29943@kroah.com> <1160609160.6389.80.camel@linuxchandra>
	 <20061012235127.GA15767@kroah.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 13 Oct 2006 16:40:08 -0700
Message-Id: <1160782808.18766.553.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 16:51 -0700, Greg KH wrote:

<snip>

> > BTW, it it not just CKRM/RG, Paul Menage as recently extracted the
> > processes aggregation from cpuset to have an independent infrastructure
> > (http://marc.theaimsgroup.com/?l=ckrm-tech&m=116006307018720&w=2), which
> > has its own file system. I was advocating him to use configfs. But, he
> > also has this issue/limitation. 
> 
> That's one reason it is so easy to just write your own filesystem then.
> What is it these days, less than 200 lines of code?  I bet you can even

For my_school_project_fs perhaps 200 lines is sufficient.

Paul Menage's patch which Chandra was referring to:

http://lkml.org/lkml/2006/9/28/104

is 1700 insertions. RCFS was around 1500 lines -- similar to Paul's
patch -- before we moved to configfs and reduced that to about 300-400
lines. This suggests we'd need around 1500 lines of filesystem code --
7.5 times your estimate.

> condence more things to make it 100 lines if you really try.  That seems
> much more sane than trying to bend configfs into something different.

	I don't agree. I think it's insane not to use configfs just because we
need a list of pids for each group of tasks.

> Why are people so opposed to creating their own filesystems?

	There are lots of reasons not to create your own filesystem. When
you're not already a kernel maintainer it's no small task to create and
get a non-trivial filesystem accepted into the kernel. Getting people to
review whole new filesystems has its own problems:

http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/1928.html

Cheers,
	-Matt Helsley


