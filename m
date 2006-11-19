Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWKSSEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWKSSEb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWKSSEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:04:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51168 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932652AbWKSSEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:04:30 -0500
Message-ID: <45609CA9.8030806@garzik.org>
Date: Sun, 19 Nov 2006 13:04:25 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Oleg Verych <olecom@flower.upol.cz>
CC: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [e-mail problems] with infradead.org recipients
References: <slrnem0qco.fp5.olecom@flower.upol.cz>
In-Reply-To: <slrnem0qco.fp5.olecom@flower.upol.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych wrote:
> Hi, guys. I have problems with you.
> 
> Is some special NS or route needed? I can add, no problem (ISP problems
> are very unlikely, but possible ;).
> 
> Final-Recipient: RFC822; arjan infradead.org
> Action: failed
> Status: 4.4.7
> Remote-MTA: DNS; canuck.infradead.org
> Last-Attempt-Date: Sun, 19 Nov 2006 14:27:52 +0100
> 
> Final-Recipient: RFC822; matthew wil.cx
> Action: delayed
> Status: 4.4.1
> Remote-MTA: DNS; canuck.infradead.org
> Last-Attempt-Date: Sun, 19 Nov 2006 12:49:26 +0100
> Will-Retry-Until: Fri, 24 Nov 2006 08:43:49 +0100


I bet this is greylisting on infradead.org.  Greylisting will put 
unknown IPs into a database, and /temporarily/ reject the mail, asking 
for the remote mail server to queue it.  Once $GREYLIST_TIME has passed, 
infradead.org will accept the email.  This successfully filters out a 
lot of spammers, and broken SMTP servers that have broken retransmit 
[rules].

You probably need to fix the mail server delivering the mails to 
properly retransmit...

	Jeff



