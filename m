Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWCBBuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWCBBuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCBBuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:50:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751377AbWCBBuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:50:19 -0500
Date: Wed, 1 Mar 2006 17:52:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: [PATCH 0/4] map multiple blocks in get_block() and
 mpage_readpages()
Message-Id: <20060301175230.4b96e9ad.akpm@osdl.org>
In-Reply-To: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I noticed decent improvements (reduced sys time) on JFS, XFS and ext3.
> (on simple "dd" read tests).
> 
>          (rc3.mm1)      (rc3.mm1 + patches)
> real    0m18.814s       0m18.482s
> user    0m0.000s        0m0.004s
> sys     0m3.240s        0m2.912s

With which filesystem?  XFS and JFS implement a larger-than-b_size
->get_block, but ext3 doesn't.  I'd expect ext3 system time to increase a
bit, if anything?

