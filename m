Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTDDPzt (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 10:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTDDPyn (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 10:54:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29142 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263781AbTDDPnb (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 10:43:31 -0500
Date: Fri, 4 Apr 2003 17:54:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] only use 48-bit lba when necessary
Message-ID: <20030404155457.GA16144@suse.de>
References: <20030404122936.GB786@suse.de> <86k7ea2ydy.fsf@trasno.mitica> <20030404132214.GC786@suse.de> <86wuia1cxn.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wuia1cxn.fsf@trasno.mitica>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04 2003, Juan Quintela wrote:
> 
> Hi
> 
> jens> +	if (drive->addressing == 1 && block > 0xfffffff)
> jens> +		lba48 = 1;
> jens> +
> >> 
> >> lba48 = (drive->addressing == 1) && (block > 0xfffffff);
> >> 
> >> should do the trick.
> 
> jens> I'm not going to use such nonsense, sorry. The spelled out versions are
> jens> a lot more readable. The command ?: constructs used in ide-disk are a
> jens> joke, imo.
> 
> Read it again, please.  Told me wehre are the ?: command.

Oh, you are right. It was the one-liner style that threw me off.

> Reason is that:
> 
> if (expr)
>    var = true;
> else
>    var = false;
> 
> is always a bad construct.
>
> var = expr;
> 
> is a better construct to express that meaning.
> 
> And yes, your is a variation of the same theme:
> 
> var = false;
> if (expr)
>    var = true;

Yes, but mine is more readable. IMO of course, that's the way it is with
styles.

-- 
Jens Axboe

