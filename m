Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTETL4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 07:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTETL4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 07:56:32 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:54989 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263732AbTETL4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 07:56:30 -0400
Date: Tue, 20 May 2003 13:17:17 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       plars@austin.ibm.com, akpm@digeo.com
Subject: Re: [PATCH] Exception trace for i386
Message-ID: <20030520131717.J626@nightmaster.csn.tu-chemnitz.de>
References: <20030519192814.GA975@averell.suse.lists.linux.kernel> <1053377808.588720@palladium.transmeta.com.suse.lists.linux.kernel> <p73k7cmzl7d.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <p73k7cmzl7d.fsf@oldwotan.suse.de>; from ak@suse.de on Mon, May 19, 2003 at 11:21:42PM +0200
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19I5vt-0000nB-00*yUMhcBCLBq6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 11:21:42PM +0200, Andi Kleen wrote:
> I especially like it being a global option. It has catched bugs on x86-64 
> that were never noticed before (e.g. subprocesses silently segfaulting 
> that nobody noticed doing the same on i386). Clearly it's an debugging 
> thing and you definitely want an option to turn it off. But having 
> the global option is useful.

Would you consider doing the logging only, if the process has no
real handler for that? (so it's blocking, ignoring or not caring
about this signal)

This will reveal only the bugs and not disturb the applications,
which do sth. useful with segfaults.

Regards

Ingo Oeser
