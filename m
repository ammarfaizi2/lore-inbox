Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWERFZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWERFZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWERFZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:25:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750909AbWERFZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:25:50 -0400
Date: Wed, 17 May 2006 22:25:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, clameter@sgi.com, pj@sgi.com
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Message-Id: <20060517222543.600cb20a.akpm@osdl.org>
In-Reply-To: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Fix a couple of infrequently encountered 'sleeping function
>  called from invalid context' in the cpuset hooks in
>  __alloc_pages.  Could sleep while interrupts disabled.

I'd have thought that if all the callers get their __GFP_HARDWALLS correct
then that fishy-looking in_interrupt() test in __cpuset_zone_allowed()
could be removed?
