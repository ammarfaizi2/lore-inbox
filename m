Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVFGD0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVFGD0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVFGD0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:26:07 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:64255 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261806AbVFGD0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:26:04 -0400
Subject: Re: [PATCH] MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, anton.wilson@camotion.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1118112390.4533.10.camel@localhost.localdomain>
References: <1118112390.4533.10.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 06 Jun 2005 23:25:49 -0400
Message-Id: <1118114749.4533.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-06 at 22:46 -0400, Steven Rostedt wrote:

> This makes it look like the priority goes as follows:
> 
> prio: 0 .. MAX_RT_PRIO .. MAX_USER_RT_PRIO .. MAX_PRIO
> 
> where 0 is of highest priority

I'm correcting my own post :-)

What we really want is:

prio: 0 .. [MAX_RT_PRIO - MAX_USER_RT_PRIO] .. MAX_RT_PRIO .. MAX_PRIO

                                                    |---- nice -------|
                         |------ user RT prio ------|
      |------------ kernel RT prio -----------------|

Remember, 0 is of highest priority.


-- Steve


