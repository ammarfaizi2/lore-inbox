Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVDESc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVDESc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVDESay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:30:54 -0400
Received: from thunk.org ([69.25.196.29]:31127 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261888AbVDESWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:22:24 -0400
Date: Tue, 5 Apr 2005 14:22:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, davem@davemloft.net,
       shemminger@osdl.org, netdev@oss.sgi.com
Subject: Re: [07/08] [TCP] Fix BIC congestion avoidance algorithm error
Message-ID: <20050405182202.GA11979@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	davem@davemloft.net, shemminger@osdl.org, netdev@oss.sgi.com
References: <20050405164539.GA17299@kroah.com> <20050405164758.GH17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164758.GH17299@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 09:47:59AM -0700, Greg KH wrote:
> 
> -stable review patch.  If anyone has any objections, please let us know.
> 
> While redoing BIC for the split up version, I discovered that the
> existing 2.6.11 code doesn't really do binary search. It ends up
> being just a slightly modified version of Reno.  See attached graphs
> to see the effect over simulated 1mbit environment.

I hate to be a stickler for the rules, but does this really meet this
criteria?

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing.)

If the congestion control alogirthm is "Reno-like", what is
user-visible impact to users?  There are OS's out there with TCP/IP
stacks that are still using Reno, aren't there?  

Knowing the answer to the question, "How does this bug `bother' either
users or network administrators?" would probably be really helpful.

						- Ted
