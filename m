Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWJJW7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWJJW7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWJJW7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:59:43 -0400
Received: from gw.goop.org ([64.81.55.164]:29864 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030276AbWJJW7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:59:41 -0400
Message-ID: <452C25D9.3060108@goop.org>
Date: Tue, 10 Oct 2006 15:59:37 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       tim.c.chen@linux.intel.com, Andrew Morton <akpm@osdl.org>,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
References: <B41635854730A14CA71C92B36EC22AAC3F4CAB@mssmsx411> <Pine.LNX.4.58.0610101712370.10398@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0610101712370.10398@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> In todays world, SMP is becoming more and more common (still waiting to
> get that DualCore cell phone).  So that means that writing to a variable
> is going to carry more weight than it use to, and gcc needs to take note
> of this.  So, to avoid a short condition jump by adding a write to
> memory, is not going to save anying.
>   

In general shared variables are going to be pretty rare, and its 
reasonable for gcc to assume they aren't.  But it would be nice to have 
a good way to solve cases like this (though it seems like (condition) && 
__warn_once is the right way to go here anyway).

    J
