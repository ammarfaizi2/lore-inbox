Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUAWU10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 15:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266693AbUAWU10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 15:27:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4874 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S266691AbUAWU1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 15:27:25 -0500
Date: Fri, 23 Jan 2004 21:32:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
       linux-kernel@vger.kernel.org
Subject: Re: make in 2.6.x
Message-ID: <20040123203216.GC7311@mars.ravnborg.org>
Mail-Followup-To: Wakko Warner <wakko@animx.eu.org>,
	Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
	linux-kernel@vger.kernel.org
References: <20040123145048.B1082@beton.cybernet.src> <20040123124224.B1343@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123124224.B1343@animx.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 12:42:24PM -0500, Wakko Warner wrote:
> > Is it correct to issue "make bzImage modules modules_install"
> > or do I have to do make bzImage; make modules modules_install?
> > 
> > Is there any documentation where I can read answer to this question?
> 
> I see nothing wrong with the first invocation, the second you should change
> the ; to &&.  if make bzImage fails, it'll stop there.
> 
> I typically do all seperate like this:
> make -j 20 bzImage && make -j 20 modules && make -j modules_install
> 
> Sometimes it doesn't complete, not sure why.

Could you please enable verbose output, and send me a private mail with
the log when it fails.

Maybe I can dig out why it fails.
I'm sitting on UP here, so i usually never tries with -jN
where N > 2.

make V=1 -j20 && make V=1 -j20 modules && make V=1 -j20 modules_install

	Sam
