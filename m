Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUJLQ2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUJLQ2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUJLQ2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:28:37 -0400
Received: from holomorphy.com ([207.189.100.168]:4233 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266115AbUJLQ2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:28:32 -0400
Date: Tue, 12 Oct 2004 09:28:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
Message-ID: <20041012162820.GY9106@holomorphy.com>
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain> <416B6594.5080002@nortelnetworks.com> <20041012052210.GW9106@holomorphy.com> <416BF72F.2080804@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416BF72F.2080804@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Oct 11, 2004 at 11:03:16PM -0600, Chris Friesen wrote:
>>> I must be able to run an app that uses over 90% of system memory, and 
>>> calls fork().  I was under the impression this made strict accounting 
>>> unfeasable?

William Lee Irwin III wrote:
>> Not so. Just add enough swapspace to act as the backing store for the
>> aggregate anonymous virtualspace.

On Tue, Oct 12, 2004 at 09:24:31AM -0600, Chris Friesen wrote:
> In my first message I mentioned that I had no swap.  It's embedded, so I do 
> not have the ability to add swap.

Then the closest thing to a good idea may be to enable overcommitment.
echo 1 > /proc/sys/vm/overcommit_memory to do that.


-- wli
