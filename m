Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWDTA1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWDTA1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 20:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWDTA1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 20:27:17 -0400
Received: from pr-117-102.ains.net.au ([202.147.117.102]:35780 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S1751338AbWDTA1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 20:27:15 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
cc: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@sgi.com>, Dean Nelson <dnc@sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>
Subject: Re: [(resend)patch 0/7] Notify page fault call chain 
In-reply-to: Your message of "Wed, 19 Apr 2006 15:14:19 MST."
             <20060419221419.382297865@csdlinux-2.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Apr 2006 10:27:17 +1000
Message-ID: <19803.1145492837@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anil S Keshavamurthy (on Wed, 19 Apr 2006 15:14:19 -0700) wrote:
>Hi Andrew,
>
>Currently in the do_page_fault() code path, we call
>notify_die(DIE_PAGE_FAULT, ...) to notify the page fault. 
>The only interested components for this page fault 
>notifications  are  Kprobes  and/or  kdb.

Only kprobes.  kdb does not care about page faults.

