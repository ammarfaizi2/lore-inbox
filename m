Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbTHYXAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTHYXAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 19:00:50 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:40977
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262396AbTHYW6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:58:51 -0400
Date: Mon, 25 Aug 2003 15:58:47 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030825225847.GA16831@matchmail.com>
Mail-Followup-To: Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <20030821234709.GD1040@matchmail.com> <AC36AB3038685indou.takao@soft.fujitsu.com> <20030825041117.GN4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825041117.GN4306@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 09:11:17PM -0700, William Lee Irwin III wrote:
> On Thu, Aug 21, 2003 at 09:49:45AM +0900, Takao Indoh wrote:
> >>> Actually, in the system I constructed(RedHat AdvancedServer2.1, kernel
> >>> 2.4.9based), the problem occurred due to pagecache. The system's maximum
> >>> response time had to be less than 4 seconds, but owing to the pagecache,
> >>> response time get uneven, and maximum time became 10 seconds.
> 
> On Thu, 21 Aug 2003 16:47:09 -0700, Mike Fedyk wrote:
> >> Please try the 2.4.18 based redhat kernel, or the 2.4-aa kernel.
> 
> On Mon, Aug 25, 2003 at 11:45:58AM +0900, Takao Indoh wrote:
> > I need a tuning parameter which can control pagecache
> > like /proc/sys/vm/pagecache, which RedHat Linux has.
> > The latest 2.4 or 2.5 standard kernel does not have such a parameter.
> > 2.4.18 kernel or 2.4-aa kernel has a alternative method?
> 

Takao,

I doubt that there will be that option in the 2.4 stable series.  I think
you are trying to fix the problem without understanding the entire picture.
If there is too much pagechache, then the kernel developers need to know
about your workload so that they can fix it.  But you have to try -aa first
to see if it's already fixed.

> This is moderately misguided; essentially the only way userspace can
> utilize RAM at all is via the pagecache. It's not useful to limit this;
> you probably need inode-highmem or some such nonsense.

Exactly.  Every program you have opened, and all of its libraries will show
up as pagecache memory also, so seeing a large pagecache in and of itself
may not be a problem.

Let's get past the tuning paramenter you want in /proc, and tell us more
about what you are doing that is causing this problem to be shown.

