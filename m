Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTKWTmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 14:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTKWTmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 14:42:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:15842 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263424AbTKWTmU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 14:42:20 -0500
From: Juergen Hasch <lkml@elbonia.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Using get_cwd inside a module.
Date: Sun, 23 Nov 2003 20:40:28 +0100
User-Agent: KMail/1.5.4
Cc: Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
References: <3FBEA83B.1060001@bangstate.com> <200311221145.39585.lkml@elbonia.de> <20031122110459.A31359@infradead.org>
In-Reply-To: <20031122110459.A31359@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200311232040.29132.lkml@elbonia.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:464ad01b81b0f762cd239ce6f3ab8323
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 22. November 2003 12:04 schrieb Christoph Hellwig:
> On Sat, Nov 22, 2003 at 11:45:39AM +0100, Juergen Hasch wrote:
> > > What are the exact requirements of changedfiles or samba?
> >
> > Samba needs to be able to notify a client machine, when a file in a
> > directory changes (i.e. is added/removed/modified/renamed). The directory
> > to be watched is given by the client and can include subdirectories.
>
> Well, reporting a single path component relative to the parent directory
> is doable, there's just no way to have a canonical absolute or
> multi-component pathname.

If dnotify is able to return name and event type for each dnotify event,
it is quite simple to make use of it in Samba. I tested this some time
ago, but it was too much of a hack to consider sending this to the list.

What are the chances of such an extension being accepted in the
kernel at all ?
>From the LKML archives I haven't seen much love for dnotify and I
think only few Samba users would consider using a custom kernel.

...Juergen

