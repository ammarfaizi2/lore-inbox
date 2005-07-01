Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263414AbVGARjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263414AbVGARjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 13:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVGARjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 13:39:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23206 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263414AbVGARjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 13:39:47 -0400
Date: Fri, 1 Jul 2005 19:41:14 +0200
From: Jens Axboe <axboe@suse.de>
To: "Manfred.Scherer.Mhm@t-online.de" <Manfred.Scherer.Mhm@t-online.de>
Cc: paul@paulbristow.net, linux-kernel@vger.kernel.org,
       manfred.scherer@siemens.com
Subject: Re: Re: PATCH for ide_floppy
Message-ID: <20050701174112.GK2243@suse.de>
References: <1DoNSU-0kLq880@fwd18.aul.t-online.de> <20050701161534.GJ2243@suse.de> <1DoOqm-0TquC80@fwd16.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1DoOqm-0TquC80@fwd16.aul.t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01 2005, Manfred.Scherer.Mhm@t-online.de wrote:
> it's not really a performance issue but more a timeout issue.
> 'IDEFLOPPY_TICKS_DELAY  60' avoids error messages in /var/log/messages
> like 'reset ide ...'.
> Without the idefloppy_timer_expiry the data transfer to the ide-floppy
> is pending a long time between some transfer of data. The floppy LED
> indicated this too.
> With kernel 2.4.x I've never had this problem.

Ah, so you did see lots of timeouts. The solution is, I suspect, just
to adjust the ticks to be based off HZ like Bart suggests.

-- 
Jens Axboe

