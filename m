Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTJNPHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTJNPHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:07:50 -0400
Received: from colin2.muc.de ([193.149.48.15]:51976 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262337AbTJNPHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:07:50 -0400
Date: 14 Oct 2003 17:08:07 +0200
Date: Tue, 14 Oct 2003 17:08:07 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide barrier support, #2
Message-ID: <20031014150807.GA99122@colin2.muc.de>
References: <GurO.7cg.43@gated-at.bofh.it> <m3zng4ou90.fsf@averell.firstfloor.org> <20031014125723.GR1107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014125723.GR1107@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uh be careful! It must be WRITEBARRIER, not WRITESYNC. I think I'll kill
> WRITEBARRIER and just call it WRITESYNC, it's more logical. I've added
> the modified variant, thanks.

Why? The journaling just checks if the write finished and then submits
the dependent writes. It doesn't care about reordering.

As long as WRITESYNC guarantees that the data hit disk when completed
then it should be ok.

-Andi
