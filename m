Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270332AbTGMWn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 18:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270426AbTGMWn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 18:43:26 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:52388 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270332AbTGMWnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 18:43:25 -0400
Date: Mon, 14 Jul 2003 00:53:10 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Style question: Should one check for NULL pointers?
Message-ID: <20030714005310.G639@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org>; from stern@rowland.harvard.edu on Thu, Jul 10, 2003 at 04:28:09PM -0400
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19bpml-0001Ua-00*kmG.GFwQ22o*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 10, 2003 at 04:28:09PM -0400, Alan Stern wrote:
> There are many places in the kernel where a function checks whether a
> pointers it has been given is NULL.  Now sometimes this makes perfect
> sense because the function's description explicitly says that a NULL
> pointer argument is valid.  But in many, many cases (maybe even the
> majority) it is nothing more than paranoia: the pointer can never be NULL
> in a properly functioning system.

There are many meanings of NULL.

a) NULL -> I don't know
   Reaction: Ok, then do a generic/default variant.

b) NULL -> failure in caller passed down to us.
   Reaction: Pass it on, return -EINVAL or ignore the call

c) NULL -> failure in API (argument can't be NULL)
   Reaction: BUG_ON()
   
...

So the answer isn't only taste, it's a matter of simplicity and
roboustness.

Regards

Ingo Oeser
