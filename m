Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWEZVUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWEZVUx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWEZVUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:20:53 -0400
Received: from waste.org ([64.81.244.121]:51091 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751573AbWEZVUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:20:52 -0400
Date: Fri, 26 May 2006 16:12:49 -0500
From: Matt Mackall <mpm@selenic.com>
To: rjw@sisk.pl, pavel@ucw.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: APM suspend to RAM broken, culprit found
Message-ID: <20060526211249.GP24227@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bisection reveals that the patch entitled:

[PATCH] swsusp: add check for suspension of X-controlled devices

breaks resume of ipw2200, synaptics mouse, USB, and probably other
useful bits on my Thinkpad R51. Notably, I'm using APM.

-- 
Mathematics is the supreme nostalgia of our time.
