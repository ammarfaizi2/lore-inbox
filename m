Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbVKJDOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbVKJDOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 22:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbVKJDOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 22:14:52 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:13185 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751719AbVKJDOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 22:14:52 -0500
Date: Thu, 10 Nov 2005 11:15:00 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-mm@vger.kernel.org
Subject: Re: [PATCH 01/16] mm: delayed page activation
Message-ID: <20051110031500.GA6084@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-mm@vger.kernel.org
References: <20051109134938.757187000@localhost.localdomain> <20051109141432.393114000@localhost.localdomain> <4372928D.80100@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4372928D.80100@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 11:21:33AM +1100, Nick Piggin wrote:
> Wu Fengguang wrote:
> >When a page is referenced the second time in inactive_list, mark it with
> >PG_activate instead of moving it into active_list immediately. The actual
> >moving work is delayed to vmscan time.
> >
> 
> This is something similar to what Rik and I have both wanted in the
> past. In my case it was to simplify and improve the "use once"
> streaming io mechanism.
> 
> I wouldn't feel comfortable lumping this together with your readahead
> work all at once (ditto for some of the other vm changes).
> 
> Mabe we should look at making a decision on some of these peripheral
> patches before readahead proper.
Indeed I'm not quite sure about all the vm thing. One needs wide spread &
long term experiences to make good judgements in this area. But for the sake
of better read-ahead, I feel obliged to propose some read-ahead friendly vm
changes, and hope someone to consider and improve it with the whole picture
in mind.

So it's perfectly ok for me to leave the vm patches out for more discussion.

Regards,
Wu
