Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWILRu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWILRu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWILRu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:50:56 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:14994 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030305AbWILRuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:50:55 -0400
In-Reply-To: <200609121707.32078.oliver@neukum.org>
References: <20060911162059.GA1496@us.ibm.com> <200609121222.01260.oliver@neukum.org> <20060912145509.GE1291@us.ibm.com> <200609121707.32078.oliver@neukum.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FBEFB0CC-982A-4282-AC37-8EBBC3FDC967@kernel.crashing.org>
Cc: paulmck@us.ibm.com, David Howells <dhowells@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Uses for memory barriers
Date: Tue, 12 Sep 2006 19:50:24 +0200
To: Oliver Neukum <oliver@neukum.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In both cases, the CPU might "discard" the write, if there are no  
>> intervening
>> reads or writes to the same location.  The only difference between  
>> your
>
> How can it know that?

Because it holds the cache line in the "O" (owned) state, for example.

And it doesn't matter how a CPU would do this; the only thing that
matters is that you do not assume anything that is not guaranteed
by the model.


Segher

