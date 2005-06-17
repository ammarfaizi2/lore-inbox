Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVFQRyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVFQRyW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVFQRyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:54:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50341 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262037AbVFQRyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:54:12 -0400
Date: Fri, 17 Jun 2005 18:54:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Robert Love <rml@novell.com>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify.
Message-ID: <20050617175404.GA19463@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Robert Love <rml@novell.com>,
	Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Andrew Morton <akpm@osdl.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506171907.39940.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 07:07:38PM +0200, Arnd Bergmann wrote:
> Sorry to bring up a topic that should have been settled a long time ago.
> 
> I found that the interface consisting of
>  - open a handle
>  - add a file descriptor with an event mask to handle
>  - remove a file/watch descriptor from handle
>  - wait on handle, get events
>  - close handle
> 
> in inotify is _very_ similar to how epoll is represented to user
> space. Is there a good reason that epoll is a set of syscalls while
> inotify is a character device, or is one of them simply wrong?

It's because Robert and John insist on their horrible interface and
simply ignore any feedback on how to do a better one.
