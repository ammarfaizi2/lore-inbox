Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVCHEdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVCHEdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVCHEdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:33:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59331 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261364AbVCHEdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:33:02 -0500
Date: Tue, 8 Mar 2005 04:32:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, hch@infradead.org, paul@linuxaudiosystems.com,
       mpm@selenic.com, joq@io.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, rlrevell@joe-job.com, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308043250.GA32746@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	paul@linuxaudiosystems.com, mpm@selenic.com, joq@io.com,
	cfriesen@nortelnetworks.com, chrisw@osdl.org, rlrevell@joe-job.com,
	arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308035503.GA31704@infradead.org> <20050307201646.512a2471.akpm@osdl.org> <20050308042242.GA15356@elte.hu> <20050307202821.150bd023.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307202821.150bd023.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 08:28:21PM -0800, Andrew Morton wrote:
> > please describe this "very simple and very real-world problem" in simple
> > terms. Lets make sure "problem" and "solution" didnt become detached.
> > 
> 
> Well others can do that better than I but I'd describe it as
> 
> - Audio apps need to meet their realtime requirements
> 
> - The way to implement that is to give them !SCHED_OTHER and mlockall
>   capabilities.
> 
> - But they don't want to run as root.

Which all fits very nicely with MEMLOCK rlimit and a tiny wrapper
that sets !SCHED_OTHER and execs the audio app..

and as I mentioned a few times if we really want to go for a magic
uid/gid-based approach we should at least have one that's useable for
all capabilities so it can replace the oracle hack aswell.  But the
proponents of the patch weren't iterested to invest the tiniest bit
of work over what they submited.
