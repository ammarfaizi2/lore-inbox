Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVAGA3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVAGA3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVAGA3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:29:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:7393 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261250AbVAGAZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:25:43 -0500
Date: Thu, 6 Jan 2005 16:24:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
In-Reply-To: <1105053007.17176.291.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501061623350.2272@ppc970.osdl.org>
References: <20050106190538.GB1618@us.ibm.com>  <1105039259.4468.9.camel@laptopd505.fenrus.org>
  <20050106201531.GJ1292@us.ibm.com>  <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
  <20050106210408.GM1292@us.ibm.com>  <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
  <20050106152621.395f935e.akpm@osdl.org> <1105053007.17176.291.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jan 2005, Alan Cox wrote:

> On Iau, 2005-01-06 at 23:26, Andrew Morton wrote:
> > I think the exports should be restored.  So does Linus ("Not that I like it
> > all that much, but I don't think we should break existing modules unless we
> > have a very specific reason to break just those modules.").
> 
> What happens when the feature is just not (ab)usable in the way proposed ? 

At that point there is a specific _reason_ to break it, aka "that function 
simply doesn't exist any more".

I'm known for happily breaking binary modules, but I think we should do it 
only if we have a reason _other_ than "let's break a module". 

		Linus
