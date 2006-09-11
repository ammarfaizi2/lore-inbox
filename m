Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWIKRXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWIKRXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWIKRXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:23:54 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:413 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751247AbWIKRXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:23:53 -0400
In-Reply-To: <Pine.LNX.4.44L0.0609111246110.10623-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0609111246110.10623-100000@iolanthe.rowland.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DA530D09-FD88-4BAF-996B-00E900F6CA51@kernel.crashing.org>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Oliver Neukum <oliver@neukum.org>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Uses for memory barriers
Date: Mon, 11 Sep 2006 19:23:49 +0200
To: Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This can't be right.  Together 1 and 2 would obviate the need for  
> wmb().
> The CPU doing "STORE A; STORE B" will always see the operations  
> occuring
> in program order by 1, and hence every other CPU would always see them
> occurring in the same order by 2 -- even without wmb().
>
> Either 2 is too strong, or else what you mean by "perceived" isn't
> sufficiently clear.

2. is only for multiple stores to a _single_ memory location -- you
use wmb() to order stores to _separate_ memory locations.


Segher

