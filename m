Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVHXTNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVHXTNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVHXTNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:13:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4804 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751406AbVHXTNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:13:48 -0400
Date: Wed, 24 Aug 2005 12:13:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cpu_exclusive sched domains on partial nodes temp fix
Message-Id: <20050824121340.3edf79d8.pj@sgi.com>
In-Reply-To: <20050824190651.GA10586@redhat.com>
References: <200508240401.j7O41qlB029277@hera.kernel.org>
	<20050824190651.GA10586@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> > [PATCH] cpu_exclusive sched domains on partial nodes temp fix
> 
> This broke ppc64 for me.


Thanks to Paul Mackerras's report, I sent a patch for this a few hours ago:

  [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix

It just makes a local copy of the cpumask_t in a local variable on the stack.

I'm still a couple of hours from actually verifying that ppc64 builds with
this - due to unrelated confusions on my end.  Perhaps you or Mackerras will
report in first, to verify if this patch works as advertised.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
