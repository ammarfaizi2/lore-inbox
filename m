Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUGRWQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUGRWQz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUGRWQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:16:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60589 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264542AbUGRWQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:16:53 -0400
Date: Mon, 19 Jul 2004 00:16:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [12/25] Merge pmdisk and swsusp
Message-ID: <20040718221653.GD31958@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171529530.22290-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0407171529530.22290-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static void wait_io(void)
> +{
> +	while(atomic_read(&io_done))
> +		io_schedule();
> +}
...
> +	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
> +	wait_io();
> + Done:
> +	bio_put(bio);
> +	return error;
> +}

Perhaps it is worth it to inline wait_io?
						Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
