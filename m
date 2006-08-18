Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWHRVnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWHRVnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWHRVnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:43:25 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:17792 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751490AbWHRVnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:43:24 -0400
Message-ID: <44E63476.201@garzik.org>
Date: Fri, 18 Aug 2006 17:43:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Kai Petzke <wpp@marie.physik.tu-berlin.de>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Complaint about return code convention in queue_work() etc.
References: <Pine.LNX.4.44L0.0608181730510.5732-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0608181730510.5732-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> I'd like to lodge a bitter complaint about the return codes used by 
> queue_work() and related functions:
> 
> 	Why do the damn things return 0 for error and 1 for success???
> 	Why don't they use negative error codes for failure, like 
> 	everything else in the kernel?!!

It's a standard programming idiom:  return false (0) for failure, true 
(non-zero) for success.  Boolean.

Certainly the kernel often uses the -errno convention, but it's not a rule.

	Jeff



