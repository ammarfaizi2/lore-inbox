Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265861AbUEURNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265861AbUEURNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 13:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUEURNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 13:13:41 -0400
Received: from mail1.kontent.de ([81.88.34.36]:5321 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265861AbUEURNk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 13:13:40 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
Date: Fri, 21 May 2004 19:12:38 +0200
User-Agent: KMail/1.6.2
References: <40A8606D.1000700@linuxmail.org> <200405211542.40587.oliver@neukum.org> <20040521170847.GA14739@elf.ucw.cz>
In-Reply-To: <20040521170847.GA14739@elf.ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405211912.38354.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. Mai 2004 19:08 schrieben Sie:
> Hi!
> 
> > > > Kernel threads are different, and each must be handled separately,
> > > > maybe even with some ordering. But there's relatively small number of
> > > > kernel threads... 
> > > 
> > > Yes, but what order? I played with that problem for ages. Perhaps I just 
> > >   didn't find the right combination.
> > 
> > How about recording the order of creation and do it in opposite order?
> 
> Order of creation is pretty much hidden in pid, but I do not think
> that will work.

Why? Build a list during kernel thread creation. It is not a hot code path.

	Regards
		Oliver
