Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVFQS2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVFQS2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVFQS2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:28:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35494 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262049AbVFQS22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:28:28 -0400
Date: Fri, 17 Jun 2005 19:28:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify.
Message-ID: <20050617182826.GA20250@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@novell.com>, Arnd Bergmann <arnd@arndb.de>,
	Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Andrew Morton <akpm@osdl.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de> <20050617175404.GA19463@infradead.org> <1119032213.3949.124.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119032213.3949.124.camel@betsy>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 02:16:53PM -0400, Robert Love wrote:
> We considered your feedback, Christoph.  Ultimately, John, Andrew, and I
> settled on the current approach.  In life, not everyone agrees on every
> little detail and there usually exists a large difference between "not
> exactly the same" and "horrible".  And never does the histrionics result
> in anything productive.

This shows exactly on how you're refusing feedback on the basis totally
unfounded claims again.

You are using ioctl as an really bad syscall multiplexer.  You're
not using the file descriptor it's called on at all, so it does not qualify
as a valid ioctl() usage even under the most lax rules.

Also you claimed the resource shortage for the proposed architecture
with just a single syscall, aka one watch per fd without showing any
reasons why that would be true, in fact by any means there's no reason
to believe file descriptors are a rare ressource in a modern Linux system.

I don't care whether you adopt my interface proposal or a different passable
one, but the current one is not acceptable at all.
