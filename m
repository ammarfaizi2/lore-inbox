Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTD3RfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTD3RfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:35:23 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:38100 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262228AbTD3RfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:35:22 -0400
Date: Wed, 30 Apr 2003 19:45:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc1 compile failure [toshoboe]
Message-ID: <20030430174530.GA453@elf.ucw.cz>
References: <20030429015841.GA17454@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030429015841.GA17454@bougret.hpl.hp.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I get compile failure for 2.4.21-rc1:
> > 
> > "in irda_device_init: undefined reference to toshoboe_init".
> 
> 	Non-modular IrDA is not supported in 2.4.X and is known to be
> broken in various way (see bottom of my web page). This was fixed in
> 2.5.24, but won't be fixed in the 2.4.X serie. However, I always
> accept trivial patches...
> 	Have fun...

Fix was to kill toshoboe_init() from irda_device_init(): it is
module_init() so it gets called, anyway.

Unfortunately toshoboe in 2.4.21-rc1 works as badly as in 2.5: the
"new" driver does not even detect it and the "old" driver breaks with
max_baud > 9600.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
