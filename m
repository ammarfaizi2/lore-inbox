Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266416AbUAICiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 21:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266417AbUAICiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 21:38:03 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:7837 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266416AbUAICiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 21:38:02 -0500
Subject: Re: [PATCH] 2.6.1-rc2 ide barrier support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20040107134323.GB16720@suse.de>
References: <20040107134323.GB16720@suse.de>
Content-Type: text/plain
Message-Id: <1073615696.784.181.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 13:34:57 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	char		special_buf[8];	/* private command buffer */

Why not put that in struct drive instead ? You must be a bit more
careful on the lifetime, but it's less bloat, there are much less
instances of struct drive than struct request :)

Ben.


