Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUJLPep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUJLPep (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUJLPeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:34:16 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:56817 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265910AbUJLPdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:33:02 -0400
Message-ID: <416BF927.7000000@nortelnetworks.com>
Date: Tue, 12 Oct 2004 09:32:55 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain> <416B6594.5080002@nortelnetworks.com> <20041012094439.GA3223@pclin040.win.tue.nl>
In-Reply-To: <20041012094439.GA3223@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

> The default allows a job to take ten times what is available,
> and bad things happen later.
> With overcommit mode 2 there is an upper bound, but you can
> twiddle the bound as desired. From proc(5):

Okay, that may be a possibility.  I'll look into that.

However, isn't it a bad thing that a vanilla 2.6.9-rc3 can be totally locked up 
by an unpriviledged user by running two tasks?

It seems to me that the OOM-killer not waking up is a bug.  I should not be able 
to lock up the system by running it out of memory--it should wake up and start 
killing things rather than hang the system.

Chris
