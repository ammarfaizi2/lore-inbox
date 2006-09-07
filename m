Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWIGGke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWIGGke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 02:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWIGGke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 02:40:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5288 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750819AbWIGGkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 02:40:33 -0400
Date: Wed, 6 Sep 2006 23:40:29 -0700
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: serue@us.ibm.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-Id: <20060906234029.a4b74c6f.pj@sgi.com>
In-Reply-To: <20060907012537.GA11138@sergelap.austin.ibm.com>
References: <20060906182719.GB24670@sergelap.austin.ibm.com>
	<20060906135113.00051e89.pj@sgi.com>
	<20060907012537.GA11138@sergelap.austin.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge wrote:
> With SECURITY_FS_CAPABILITIES=y, what changes is that it is possible for
> a binary to be marked as granting CAP_SYS_NICE to anyone running it.

Nice explanation - it almost made sense to me.  Thanks.

Sounds like this patch would slightly increase the situations
under which a user task could do a cpuset attach_task on another
user task ... if it had CAP_SYS_NICE, or some such, it could gain
this attach_task ability that it had lacked on older kernels.

Sounds good to me.

My concern would be more if an existing user configuration stopped
working when these filesystem capabilities became available to them,
due to some previously ok operation becoming illegal.

As to exactly which CAP_SYS_* it is that has this power of
allowing a cpuset attach_task, I don't think I really care.

I'm happy.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
