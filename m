Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUEURVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUEURVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUEURVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 13:21:50 -0400
Received: from mail1.kontent.de ([81.88.34.36]:39647 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265900AbUEURVo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 13:21:44 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
Date: Fri, 21 May 2004 19:20:32 +0200
User-Agent: KMail/1.6.2
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40A8606D.1000700@linuxmail.org> <200405211912.38354.oliver@neukum.org> <20040521171538.GI10052@elf.ucw.cz>
In-Reply-To: <20040521171538.GI10052@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405211920.32187.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. Mai 2004 19:15 schrieb Pavel Machek:
> Hi!
> 
> > > > > > Kernel threads are different, and each must be handled separately,
> > > > > > maybe even with some ordering. But there's relatively small number of
> > > > > > kernel threads... 
> > > > > 
> > > > > Yes, but what order? I played with that problem for ages. Perhaps I just 
> > > > >   didn't find the right combination.
> > > > 
> > > > How about recording the order of creation and do it in opposite order?
> > > 
> > > Order of creation is pretty much hidden in pid, but I do not think
> > > that will work.
> > 
> > Why? Build a list during kernel thread creation. It is not a hot code path.
> 
> Maybe the order in which kernel threads were created is not the same
> as the order how they need to be frozen?

Possible, but unlikely. If there can be a deadlock if they are frozen in
reverse order, the same problem existed during creation and needed
to be specially handled.

	Regards
		Oliver
