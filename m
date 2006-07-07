Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWGGRKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWGGRKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWGGRKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:10:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52969 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932197AbWGGRKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:10:31 -0400
Message-ID: <44AE9584.4040300@garzik.org>
Date: Fri, 07 Jul 2006 13:10:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ltuikov@yahoo.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
References: <20060707170029.18481.qmail@web31814.mail.mud.yahoo.com>
In-Reply-To: <20060707170029.18481.qmail@web31814.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> Andrew,
> 
> If this patch is so much affecting Garzik, please drop it.
> 
> As to "merged users in the kernel" -- my code is GPL, and at one point
> was in the -mm tree as maintained by yourself.
> 
> Currently it also implements a SAT-r08a complient SCSI/ATA Translation
> Layer for a SAS Stack including SATA capabilities adjustment as advertized
> by the protocol, NCQ, passthrough, etc, etc. (Garzik may see this as
> objectionable as it is not "libata", but it cannot be due to architectural
> hurdles.)
> 
> Anyway, kernel threads bear the name of STP/SATA bridge which is representable
> in 16+1 ASCII chars (IEEE NAA Registered format identifier, 8 bytes), and thus
> the last character (4 bits of the name) are chopped off in a 15+1 char array.

Your patch increases the size of a key data structure -- task struct -- 
for all users on all platforms, even when there are _no_ users currently 
in the kernel.

It is thus wasted space, for all users on all platforms.

Linux development doesn't work like this.  We don't know the future, 
until it happens.

Thus, this patch is appropriate when there are real users in the kernel, 
and not before.

	Jeff


