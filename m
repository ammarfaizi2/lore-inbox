Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWCSO4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWCSO4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 09:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWCSO4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 09:56:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31211 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751083AbWCSO43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 09:56:29 -0500
Date: Sun, 19 Mar 2006 06:56:14 -0800
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cpuset: remove unnecessary NULL check
Message-Id: <20060319065614.371823f2.pj@sgi.com>
In-Reply-To: <m1acbmzfw5.fsf@ebiederm.dsl.xmission.com>
References: <20060319085743.18841.45970.sendpatchset@jackhammer.engr.sgi.com>
	<m1acbmzfw5.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> Comments that refer to a nebulous hack ...

Well, in this case, it wasn't so nebulous, to me anyway.

The "Hack" referred to has a big fat comment beginning:

 *
 * Hack:
 *
 *    Set the exiting tasks cpuset to the root cpuset (top_cpuset).
 *
 *    Don't leave a task unable to allocate memory, as ...

and is labeled at the scene of the Hack with:

        tsk->cpuset = &top_cpuset;      /* Hack - see comment above */

So "Hack" was intended as a proper noun, not a nebulous generic term.

But, sure, hard to argue with anyone wanting improved comments.

And while I'm at it, I will change the name of this Hack to something
less generic ... say "the_top_cpuset_hack".

Patch coming soon.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
