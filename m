Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTK1HSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 02:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTK1HSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 02:18:35 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:13225 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262050AbTK1HSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 02:18:34 -0500
Date: Fri, 28 Nov 2003 08:18:12 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, Andries.Brouwer@cwi.nl
Subject: Re: BUG (non-kernel), can hurt developers.
Message-ID: <20031128071812.GA28728@louise.pinerecords.com>
References: <Pine.LNX.4.53.0311261153050.10929@chaos> <Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov-26 2003, Wed, 10:29 -0800
Linus Torvalds <torvalds@osdl.org> wrote:

> You can't just randomly use library functions in signal handlers. You can
> only use a very specific "signal-safe" set.
> 
> POSIX lists that set in 3.3.1.3 (3f), and says
> 
> 	"All POSIX.1 functions not in the preceding table and all
> 	 functions defined in the C standard {2} not stated to be callable
> 	 from a signal-catching function are considered to be /unsafe/
> 	 with respect to signals. .."
> 
> typos mine.
> 
> The thing is, they have internal state that makes then non-reentrant (and
> note that even the re-entrant ones might not be signal-safe, since they
> may have deadlock issues: being thread-safe is _not_ the same as being
> signal-safe).

I believe it would be very useful to have this information included in
the standard Linux signal(2) manpage.  (I've just verified it's not in
man-pages-1.60.)

What do you think, Andries?

-- 
Tomas Szepe <szepe@pinerecords.com>
