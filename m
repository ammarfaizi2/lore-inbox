Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUEURPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUEURPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 13:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUEURPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 13:15:49 -0400
Received: from gprs214-11.eurotel.cz ([160.218.214.11]:19329 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263663AbUEURPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 13:15:48 -0400
Date: Fri, 21 May 2004 19:15:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
Message-ID: <20040521171538.GI10052@elf.ucw.cz>
References: <40A8606D.1000700@linuxmail.org> <200405211542.40587.oliver@neukum.org> <20040521170847.GA14739@elf.ucw.cz> <200405211912.38354.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200405211912.38354.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Kernel threads are different, and each must be handled separately,
> > > > > maybe even with some ordering. But there's relatively small number of
> > > > > kernel threads... 
> > > > 
> > > > Yes, but what order? I played with that problem for ages. Perhaps I just 
> > > >   didn't find the right combination.
> > > 
> > > How about recording the order of creation and do it in opposite order?
> > 
> > Order of creation is pretty much hidden in pid, but I do not think
> > that will work.
> 
> Why? Build a list during kernel thread creation. It is not a hot code path.

Maybe the order in which kernel threads were created is not the same
as the order how they need to be frozen?
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
