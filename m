Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWGDBcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWGDBcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 21:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWGDBcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 21:32:05 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:24227 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751168AbWGDBcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 21:32:04 -0400
Message-ID: <351976722.07217@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 4 Jul 2006 09:32:49 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>
Subject: Re: [PATCH 7/7] iosched: introduce deadline_kick_page()
Message-ID: <20060704013248.GA7333@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Lubos Lunak <l.lunak@suse.cz>
References: <20060624082006.574472632@localhost.localdomain> <20060624082312.833976992@localhost.localdomain> <20060624110104.GP4083@suse.de> <20060625063232.GA5867@mail.ustc.edu.cn> <20060628112731.GP32115@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628112731.GP32115@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

On Wed, Jun 28, 2006 at 01:27:32PM +0200, Jens Axboe wrote:
> > The overhead of deadline_kick_page() becomes large when the request is
> > large (256 pages). But I guess there's way to optimize it:
> > - most requests will be consisted of a set of continuous pages, i.e. a
> >   range comparison will be sufficient.
> > - for a system with lots of queued requests(>100), maybe the gain can
> >   well pay for the overheads?
> 
> Sorry, there's just no way that something like that is acceptable for
> inclusion. I don't care much about the overhead numbers (I can see from
> the code that it sucks :-), I wanted to see some numbers on what
> scenarios this helps performance and by how much.

Ok, thanks. I hope that I'll be able to bring with some performance
numbers the next time :-)

Regards,
Wu
