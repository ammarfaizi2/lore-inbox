Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVCHE3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVCHE3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVCHE3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:29:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:15590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVCHE3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:29:18 -0500
Date: Mon, 7 Mar 2005 20:28:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: hch@infradead.org, paul@linuxaudiosystems.com, mpm@selenic.com, joq@io.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, rlrevell@joe-job.com,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050307202821.150bd023.akpm@osdl.org>
In-Reply-To: <20050308042242.GA15356@elte.hu>
References: <20050112185258.GG2940@waste.org>
	<200501122116.j0CLGK3K022477@localhost.localdomain>
	<20050307195020.510a1ceb.akpm@osdl.org>
	<20050308035503.GA31704@infradead.org>
	<20050307201646.512a2471.akpm@osdl.org>
	<20050308042242.GA15356@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > next we
> > > $CAPABILITY for $FOO and we're headed straight to interface-hell.
> > 
> > "interface hell"?  Wow.
> > 
> > Still.  It seems to be what we deserve if all that fancy stuff we have
> > cannot address this very simple and very real-world problem.
> 
> please describe this "very simple and very real-world problem" in simple
> terms. Lets make sure "problem" and "solution" didnt become detached.
> 

Well others can do that better than I but I'd describe it as

- Audio apps need to meet their realtime requirements

- The way to implement that is to give them !SCHED_OTHER and mlockall
  capabilities.

- But they don't want to run as root.

