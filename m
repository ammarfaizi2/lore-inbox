Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265049AbUFWNdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbUFWNdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 09:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUFWNdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 09:33:14 -0400
Received: from web41101.mail.yahoo.com ([66.218.93.17]:28056 "HELO
	web41101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265049AbUFWNdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 09:33:13 -0400
Message-ID: <20040623133309.43964.qmail@web41101.mail.yahoo.com>
Date: Wed, 23 Jun 2004 06:33:09 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: proc_misc.c comments
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was toying around with the idea of making /proc/meminfo use KiB as
the unit instead of KB [just something to waste 10 mins] when I noticed
that you guys have prototypes like

static int meminfo_read_proc(char *page, char **start, off_t off,
				 int count, int *eof, void *data)


Then do things like

	len = sprintf(page,

Wouldn't it be safer to pass the size of "page" into the function and
use snprintf to prevent any possible buffer overflows?

Sure right now it's not a problem but it would make the code easier to
review, say when someone wants to add a /proc/thingymagingy later on in
the future.

I'm still a kernel newbie so I'll defer the coding work to other people
;-)  Just thought I would point that out.

Tom



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
