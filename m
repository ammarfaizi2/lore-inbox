Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUF1CBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUF1CBL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 22:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUF1CBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 22:01:11 -0400
Received: from web50609.mail.yahoo.com ([206.190.38.248]:7274 "HELO
	web50609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264609AbUF1CBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 22:01:08 -0400
Message-ID: <20040628020108.85755.qmail@web50609.mail.yahoo.com>
Date: Sun, 27 Jun 2004 19:01:08 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: 2.6.x signal handler bug
To: Davide Libenzi <davidel@xmailserver.org>,
       Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406271551000.19865@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, maybe the restoring to SIG_DFL was not required, but it doesn't seem
> > incorrect either. It may be a bit surprising.

Right. Thanks for looking deeper Andries. I understood Davide's explanation and
then immediately wondered why the program worked under 2.4. I want to think 2.4
was emulating the unreliable signal from the past when signal() was used. 

My main concern is that the behavior change may have broken some applications
that used to work. For example, valgrind caught & reported a problem under 2.4,
but valgrind never had a chance to catch it under 2.6.
 
> I think so. Maybe the attached patch?

I've applied the second patch to my kernel & started recompiling. I'll re-test it
tomrrow.

Thanks,
-Steve Grubb


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
