Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWFPBFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWFPBFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 21:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWFPBFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 21:05:09 -0400
Received: from ozlabs.org ([203.10.76.45]:20937 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750808AbWFPBFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 21:05:08 -0400
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Mackerras <paulus@samba.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <17553.56625.612931.136018@cargo.ozlabs.ibm.com>
References: <17553.56625.612931.136018@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 11:04:55 +1000
Message-Id: <1150419895.10290.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 08:20 +1000, Paul Mackerras wrote:
> Update stop_machine.c to spawn stop_machine as kthreads rather
> than the deprecated kernel_threads.
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

kthread does a lot of stuff we don't need, and stop_machine is fairly
special, low-level interface.

Seems like change for change's sake, to me, *and* it added more code
than it removed.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

