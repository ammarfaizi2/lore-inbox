Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266787AbUF3RKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266787AbUF3RKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbUF3RJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:09:21 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35712 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S266781AbUF3RHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:07:12 -0400
X-Sasl-enc: RHLQgKpKmSpZMsm48B3fzA 1088615231
Message-ID: <00df01c45ec4$b8d08210$62afc742@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Chris Mason" <mason@suse.com>
Cc: <linux-kernel@vger.kernel.org>
References: <006a01c45de6$e4442930$62afc742@ROBMHP> <1088604723.1589.1387.camel@watt.suse.com> <007901c45ebc$5dc0b730$62afc742@ROBMHP> <1088614262.1589.1395.camel@watt.suse.com>
Subject: Re: Processes stuck in unkillable D state (2.4 and 2.6)
Date: Wed, 30 Jun 2004 10:07:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, you've got two procs waiting for pages but it isn't entirely clear
> why they aren't getting them.  There have been quite a few fixes in this
> area since 2.6.4, how hard is it for you to upgrade?

We can upgrade, and probably will soon. It was just that this problem has 
been occuring for a long time (as I mentioned, since 2.4.18) and this is the 
first time I'd managed to capture some sysreq-t output for this problem, and 
I thought that the infornation might be in some way immediately useful. 
Given that it's stuck in io_schedule, and the long term nature of the 
problem, does that suggest a hardware/device driver issue maybe? It just 
surprised me that the backtrace for both procs showed they got stuck going 
through the exact same code path, wasn't sure if it was a coincidence or a 
sign of something definitely going funny in that code path.

Anyway, we're currently doing some stress tests, and will probably upgrade 
in the next week or two to a newer kernel. I'll see what happens then.

Rob

