Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVE1GzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVE1GzX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 02:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVE1GzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 02:55:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22662 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262102AbVE1GzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 02:55:18 -0400
Date: Sat, 28 May 2005 07:55:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bill Huey <bhuey@lnxw.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050528065500.GA17005@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bill Huey <bhuey@lnxw.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Andi Kleen <ak@muc.de>,
	Sven-Thorsten Dietrich <sdietrich@mvista.com>,
	Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527233645.GA2283@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 04:36:45PM -0700, Bill Huey wrote:
> Now think about this. You're a single kernel engineer. You don't have
> the resources to make every kernel subsystems hard RT capable. You
> have this idea where you'd like get at SGI's XFS's homogenous object
> storage to stream video data with guaranteed IO rates. This needs to
> be running in an RT domain so that guarantees can be tightly controlled
> since you're running an app that doing multipule file streaming of
> those objects. What kernel subsystems does this include ?
> 
> It includes the VFS system, parts of the VM, all of the IO subsystems
> including SCSI/IDE and IO schedulers, etc..., the softirq subsystem
> supporting the SCSI layers and IO schedulers, all the parts of XFS
> itself. The list goes on.

You're on crack as usual, but today you go much too far.  XFS doesn't
ahave anything to do with you're so Hard RT pipedreams.  The so-called
'RT' subvolulme only provides a more determinitistic block allocator.
GRIO doesn't require any RT guarantees, it's entirely about I/O scheduling
and has been ported to various operating systems with sane locking semantics.

