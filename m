Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbUKEX4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUKEX4B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUKEX4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:56:01 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:45992
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261271AbUKEXz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:55:56 -0500
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages /
	all_unreclaimable braindamage
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <200411051532.51150.jbarnes@sgi.com>
References: <20041105200118.GA20321@logos.cnet>
	 <200411051532.51150.jbarnes@sgi.com>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 06 Nov 2004 00:47:36 +0100
Message-Id: <1099698456.2810.138.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-05 at 15:32 -0800, Jesse Barnes wrote:
> On Friday, November 05, 2004 12:01 pm, Marcelo Tosatti wrote:
> > Comments?
> 
> Sounds good, though we may want to do a couple of more things, we shouldn't 
> kill root tasks quite as easily and we should avoid zombies since they may be 
> large apps in the process of exiting, and killing them would be bad (iirc 
> it'll cause a panic).
> 

Yep, it makes sense, but it still does not fix the selection problem,
where e.g. sshd is killed while a out of control forking server floods
the machine with child processes. 

Patch to address this:
 http://marc.theaimsgroup.com/?l=linux-kernel&m=109922680000746&w=2

tglx






