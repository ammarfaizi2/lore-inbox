Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271103AbTHLUmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271105AbTHLUmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:42:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:41876 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S271103AbTHLUmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:42:54 -0400
Date: Tue, 12 Aug 2003 22:42:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Chris Heath <chris@heathens.co.nz>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 problem
Message-ID: <20030812204246.GA23011@ucw.cz>
References: <20030726093619.GA973@win.tue.nl> <20030726212513.A0BD.CHRIS@heathens.co.nz> <20030727020621.A11637@devserv.devel.redhat.com> <20030727104726.GA1313@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030727104726.GA1313@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 12:47:26PM +0200, Andries Brouwer wrote:
 
> So, apart from other things you might try, it seems to me that
> changing the timeout in atkbd_sendbyte from the 10000 that is
> there to the 100000 that the comment implies, should help.
> 
> Andries
> 
> 
> -         int timeout = 10000; /* 100 msec */
> +         int timeout = 100000; /* 100 msec */

Note that we do udelay(10) in the loop, so with this change you're
waiting for a whole second. The timeout might need to be made bigger,
but not that much.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
