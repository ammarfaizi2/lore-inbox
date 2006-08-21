Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751861AbWHUK5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbWHUK5D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWHUK5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:57:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49857 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751861AbWHUK5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:57:00 -0400
Date: Mon, 21 Aug 2006 11:56:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060821105637.GB28759@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru> <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru> <20060818104607.GB20816@infradead.org> <20060818112336.GB11034@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818112336.GB11034@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 03:23:36PM +0400, Evgeniy Polyakov wrote:
> > defines make some sense for userspace-visible ABIs because then people
> > can test for features with ifdef.  It doesn't make any sense for constants
> > that are used purely in-kernel.  For those enums make more sense because
> > you can for example looks at the symbolic names with a debugger.
> 
> Enums are only usefull when value is increased with each new member by
> one.

No, they are not.  Please search the lkml archives, this came up multiple
times.

> There will be either several syscalls or multiplexer...
> I prefer to have one syscall and a lot of multiplexers inside.

To make life for everyone to detangle the mess hard.  Please at least
try to follow existing design principles.

> > > I created a char device in first releases and was forced to not use it
> > > at all.
> > 
> > Do you have a reference to it?  In this case a char devices makes a lot of
> > sense because you get a filedescriptor and have operations only defined on
> > it.  In fact given that you have a multiplexer anyway there's really no
> > point in adding a syscall for that aswell, you could rather use the existing
> > and debugged ioctl() multiplexer.  Sure, it's still not what we consider
> > nice, but better than adding even more odd multiplexer syscalls.
> 
> Somewhere in february.
> Here is link to initial anounce which used ioctl and raw char device and
> enums for all constants.
> 
> http://marc.theaimsgroup.com/?l=linux-netdev&m=113949344414464&w=2

That thread only shows your patch but no comments to it.  Do you have
an url for the complaint about this design?  And please include the author
of it in the cc list of your reply so we can settle the arguments.
