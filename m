Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWHTLMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWHTLMw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 07:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWHTLMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 07:12:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40350 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750737AbWHTLMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 07:12:51 -0400
Subject: Re: Complaint about return code convention in queue_work() etc.
From: Ingo Molnar <mingo@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Kai Petzke <wpp@marie.physik.tu-berlin.de>,
       "Theodore Ts'o" <tytso@mit.edu>, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.44L0.0608181730510.5732-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0608181730510.5732-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 13:06:21 +0200
Message-Id: <1156071981.19017.60.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 17:39 -0400, Alan Stern wrote:
>         Why do the damn things return 0 for error and 1 for success???
>         Why don't they use negative error codes for failure, like 
>         everything else in the kernel?!!
> 
> I've tripped over this at least twice, and on each occasion spent a
> considerable length of time trying to track down the problem. 

yeah, lets just flip the logic over, but combined with a rename so that
we dont surprise not-yet-in-tree code [and documentation/books].
queue_work() -> add_work() or something like that.

	Ingo

