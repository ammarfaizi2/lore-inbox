Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbTKEWYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTKEWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 17:24:15 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:31672 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263256AbTKEWXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 17:23:03 -0500
Date: Wed, 5 Nov 2003 14:23:02 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
Message-ID: <20031105222302.GA12992@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20031105204522.GA11431@work.bitmover.com> <20031105125813.A5648@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105125813.A5648@one-eyed-alien.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 12:58:13PM -0800, Matthew Dharm wrote:
> Out of curiosity, what were the changed lines?

--- GOOD        2003-11-05 13:46:44.000000000 -0800
+++ BAD 2003-11-05 13:46:53.000000000 -0800
@@ -1111,6 +1111,8 @@
                schedule();
                goto repeat;
        }
+       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
+                       retval = -EINVAL;
        retval = -ECHILD;
 end_wait4:
        current->state = TASK_RUNNING;

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
