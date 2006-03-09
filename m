Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWCITfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWCITfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 14:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWCITfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 14:35:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25027 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751165AbWCITfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 14:35:44 -0500
Subject: Re: [2.6.16-rc5-m3 PATCH] inotify: add the monitor for the event
	source
From: Arjan van de Ven <arjan@infradead.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <440FFB7F.8050902@gmail.com>
References: <440F075F.1030404@gmail.com>
	 <1141836798.12175.1.camel@laptopd505.fenrus.org>
	 <440FBA9C.3050109@gmail.com>
	 <1141882513.2883.2.camel@laptopd505.fenrus.org>
	 <440FFB7F.8050902@gmail.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 20:35:41 +0100
Message-Id: <1141932941.2883.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > it breaks ABI because this structure is communicated to userspace, and
> > you change both the layout and the size of it. What else would ABI
> > mean??
> >   
> Many structures exported to user space in kernel  are undergoing some 
> change, A good application shouldn't count on invariability forever,
> My test application hasn't any problem before change and after change.


this is absolutely incorrect. This is an ABI that cannot change in any
incompatible way.
> >
> > but... what makes you think it's not a kernel thread such as kjournald?
> > (which have basically meaningless current)
> >   
> you can get  values of these fields without any problem for kernel 
> thread although they are useless.

exactly

> >
> > there is no "full path name" concept in linux like that. And even worse,
> > many processes will not have *any* path because they have been deleted,
> > especially the viruses will use this ;)
> >   
> For this case you said, this patch has now way really, do you have a 
> good way to handle this case?

it sounds that what you want to achieve is broken in the first place...
(or should use audit etc)

