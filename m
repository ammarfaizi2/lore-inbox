Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbTFSPkn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbTFSPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:40:43 -0400
Received: from relay.pair.com ([209.68.1.20]:50961 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S265810AbTFSPkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:40:42 -0400
X-pair-Authenticated: 65.247.36.27
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like 
	Windows!
From: Daniel Gryniewicz <dang@fprintf.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3EF189D2.6080207@aitel.hist.no>
References: <200306172030230870.01C9900F@smtp.comcast.net>
	 <3EF0214A.3000103@aitel.hist.no> <bcrqq4$edi$1@cesium.transmeta.com>
	 <3EF189D2.6080207@aitel.hist.no>
Content-Type: text/plain
Organization: 
Message-Id: <1056038080.2050.6.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 19 Jun 2003 11:54:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 06:00, Helge Hafting wrote:
[...]
> Good point.
> The question is still what to pull in.  Stuff in swap
> is one option.  It has been used before, and might
> be needed again.
> 
> Contents of memory mapped files (executables and others) are another.
> We can't know what we will need next, but at least the already opened
> files ought to be as likely as swap.
> 
> Pulling other files into cache is a third option.  Going for open
> files (readahead) or recently used ones might be smart.
> 

How about a hint from userspace?  A window manager could say "this is my
working set", and you could try to pull files/maps/swap in for that
working set first.  The window manager could keep an LRU based on
windows getting focus, or something like that, to keep the working set
up to date.  The hint is, of course, open to abuse, so care would have
to be taken, but my window manager could get most of this correct just
based on window input.  Things like xmms would be harder, since I rarely
actually interact with it, but it's also less likely to be swapped out,
because it's always running.

Or, you could start swapping in based on interactive bonus in the
scheduler, but that requires sharing the information with the MM and
trusting the bonus' are correct.

Daniel
-- 
Daniel Gryniewicz <dang@fprintf.net>

