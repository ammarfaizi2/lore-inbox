Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVBXVSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVBXVSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVBXVRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:17:43 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:65501 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262484AbVBXVR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:17:29 -0500
Date: Thu, 24 Feb 2005 22:17:27 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: raven@themaw.net, autofs@linux.kernel.org
Subject: Re: [Patch 2/6] Bind Mount Extensions 0.06
Message-ID: <20050224211727.GD4981@mail.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>, raven@themaw.net,
	autofs@linux.kernel.org
References: <20050222121129.GC3682@mail.13thfloor.at> <20050223230105.GD21383@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223230105.GD21383@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 11:01:05PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 22, 2005 at 01:11:29PM +0100, Herbert Poetzl wrote:
> > 
> > 
> > ;
> > ; Bind Mount Extensions
> > ;
> > ; This part adds the required checks for touch_atime() to allow
> > ; for vfsmount based NOATIME and NODIRATIME
> > ; autofs4 update_atime is the only exception (ignored on purpose)
> 
> and that purpose is?  

this is based on a statement from Al Viro:

| autofs4 use - AFAICS there we want atime updated unconditionally, 
| so calling update_atime() (update atime after checking 
| noatime/nodiratime/readonly flags) is wrong.

agreed, maybe a proper fix would be better ...

> Did you discuss this with the autofs maintainers?

not yet!
(cc-ed to automounter maintainer and list)

thanks,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
