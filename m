Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTLJMHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 07:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTLJMHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 07:07:33 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:19542 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262324AbTLJMHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 07:07:31 -0500
Date: Wed, 10 Dec 2003 23:06:56 +1100
From: Nathan Scott <nathans@sgi.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/4] fs.h: b_journal_head
Message-ID: <20031210230656.A2247055@wobbly.melbourne.sgi.com>
References: <20031209115806.GA472@reti> <20031209122418.GC472@reti> <20031209234655.GF783@frodo> <20031210084632.GA476@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031210084632.GA476@reti>; from thornber@sistina.com on Wed, Dec 10, 2003 at 08:46:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 08:46:32AM +0000, Joe Thornber wrote:
> On Wed, Dec 10, 2003 at 10:46:55AM +1100, Nathan Scott wrote:
> > Could you explain a bit more about when b_private should and
> > shouldn't be used with this change?
> 
> Once the io goes through generic_make_request() you shouldn't look at
> bh->b_private until the io has completed.  At which point it will have
> been correctly set back to the value it had when submitted.

OK.

> The problem with jbd wasn't the fact that it used it, but the fact
> that it peeked while the io was in flight.

Ah, I see now.  XFS doesn't have to do that, so should work fine as is.

thanks.

-- 
Nathan
