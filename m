Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264988AbUD2V7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264988AbUD2V7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbUD2V7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:59:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:18579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264992AbUD2V44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:56:56 -0400
Date: Thu, 29 Apr 2004 14:57:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429145725.267ea7b8.akpm@osdl.org>
In-Reply-To: <20040429143403.35a7a550.pj@sgi.com>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<20040429141947.1ff81104.akpm@osdl.org>
	<20040429143403.35a7a550.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
> > Two things:
> > a) a knob to say "only reclaim pagecache".  We have that now.
> > b) a knob to say "reclaim vfs caches harder" ...
> 
> Are these knobs system wide in affect, or per job?
> I am presuming system wide.

yup, system-wide.

> When I'm working late, I want my updatedb/backup jobs
> to scrunch themselves into a corner, even as my builds
> and gui desktop continue to fly and suck up RAM.

Sure.  That's not purely a cacheing thing though. Even if the background
activity was clamped to just a few megs of cache you'll find that the
seek activity is a killer, and needs a limitation mechanism.  Although the
anticipatory scheduler helps here a lot.
