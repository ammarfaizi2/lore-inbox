Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWIKRVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWIKRVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWIKRVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:21:45 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:3818 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751202AbWIKRVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:21:44 -0400
In-Reply-To: <20060911162059.GA1496@us.ibm.com>
References: <200609090049.20416.oliver@neukum.org> <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> <20060911162059.GA1496@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <52D5A4D1-ACE2-4D55-A01D-135FEC606B85@kernel.crashing.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Uses for memory barriers
Date: Mon, 11 Sep 2006 19:21:22 +0200
To: paulmck@us.ibm.com
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.	All stores to a given single memory location will be perceived
> 	as having occurred in the same order by all CPUs.

All CPUs that _do_ see two stores to the same memory location happening,
will see them occurring in the same order -- not all CPUs seeing a
later store will necessarily see the earlier stores.


Segher

