Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265886AbUFXXWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUFXXWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUFXXWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:22:44 -0400
Received: from gizmo12ps.bigpond.com ([144.140.71.43]:41445 "HELO
	gizmo12ps.bigpond.com") by vger.kernel.org with SMTP
	id S265886AbUFXXWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:22:37 -0400
Message-ID: <40DB6237.2050704@bigpond.net.au>
Date: Fri, 25 Jun 2004 09:22:31 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Jacobson <erikj@subway.americas.sgi.com>
CC: linux-kernel@vger.kernel.org, jlan@engr.sgi.com, limin@engr.sgi.com
Subject: Re: [PATCH] Process Aggregates (PAGG) for 2.6.7
References: <Pine.SGI.4.53.0406241239400.340142@subway.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.53.0406241239400.340142@subway.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Jacobson wrote:
> Attached is a PAGG patch to kernel 2.6.7.
> 
> The maintainers of two patches that make use of PAGG will post their patches
> in to this discussion thread shortly.
> 
> The biggest change in this patch from the last one I posted is that
> Peter Williams supplied an implementation for the init function pointer
> in the pagg hook.  We kicked this around a few times to flush out
> locking issues.


I wish that you had included me in this discussion.  Can you explain 
exactly what the locking issues with my code were?  We might have been 
able to come up with a better solution than the one you have used which 
places unnecessary restrictions (i.e. no blocking) on the init() 
callbacks which weren't applicable in the code that I provided.  Since 
these callbacks are highly likely to want to allocate dynamic memory 
there is always a chance that they will block and the no blocking 
restriction becomes an unnecessary burden.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

