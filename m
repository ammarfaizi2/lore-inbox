Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266647AbUBSHxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 02:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUBSHxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 02:53:51 -0500
Received: from mail.shareable.org ([81.29.64.88]:65413 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266647AbUBSHxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 02:53:49 -0500
Date: Thu, 19 Feb 2004 07:53:43 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Paul Jakma <paul@clubi.ie>
Cc: David Schwartz <davids@webmaster.com>, hasso@estpak.ee,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: raw sockets and blocking
Message-ID: <20040219075343.GA4113@mail.shareable.org>
References: <MDEHLPKNGKAHNMBLJOLKMENGKHAA.davids@webmaster.com> <Pine.LNX.4.58.0402190622010.25392@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402190622010.25392@fogarty.jakma.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> > 	It is, however, perfectly legal to say an operation can
> > complete without blocking (say, through 'select' or 'poll') and
> > later return EWOULDBLOCK. (So long as some operation could have
> > completed, not necessarily the one you tried.)
> 
> Right. But that's fine, we can deal with that, if the error is
> posted.
> 
> Problem is no error is posted when we sendmsg[1], yet the socket
> thereafter stays write-blocked, with (sane) way for us to recover.  

I hate to check the obvious, but did you try setting the O_NONBLOCK
flag for the socket?  Did you try setting the MSG_DONTWAIT flag for
the sendmsg operation?

-- Jamie
