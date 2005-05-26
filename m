Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVEZS1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVEZS1C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEZS1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:27:02 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1463 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261683AbVEZS0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:26:49 -0400
Date: Thu, 26 May 2005 11:26:33 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset rmdir scheduling while atomic fix
Message-Id: <20050526112633.5a8c3f84.pj@sgi.com>
In-Reply-To: <20050526143315.GB7068@in.ibm.com>
References: <20050526082516.927.6806.sendpatchset@tomahawk.engr.sgi.com>
	<20050526124110.GB6496@in.ibm.com>
	<20050526143315.GB7068@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> This was the same problem that I had reported earlier
> and fixed as well

You're right.  I even signed off on your change.

Andrew,

    Drop my "cpuset rmdir scheduling while atomic fix" patch. 

    Dinakar's dynamic-sched-domains-cpuset-changes.patch fixed it.

Dinakar's change wasn't quite the same as mine.  It is actually the
better of the two - it reduces the dentry spinlock region, instead of
moving the cpuset_sem region outside the spinlock.  I just ran my stress
test that shows this bug.  Dinakar's fix is fine, as expected.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
