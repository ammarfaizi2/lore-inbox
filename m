Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275325AbTHGNef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275314AbTHGNed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:34:33 -0400
Received: from Mix-Lyon-107-1-254.w193-249.abo.wanadoo.fr ([193.249.22.254]:40576
	"EHLO gaston") by vger.kernel.org with ESMTP id S275323AbTHGNdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:33:14 -0400
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
	notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20030807100309.GB166@elf.ucw.cz>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
	 <1060249101.1077.67.camel@gaston>  <20030807100309.GB166@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060263168.593.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 15:32:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 12:03, Pavel Machek wrote:

> I believe solution to this is simple: always switch to kernel-owned
> console during suspend. (swsusp does it, there's patch for S3 to do
> the same). That way, Xfree (or qtopia or whoever) should clean up
> after themselves and leave the console to the kernel. (See
> kernel/power/console.c)

I admit I quite like this solution. It would also help displaying
something sane (blank, pattern, whatever) on screen during driver
teardown instead of the junk left by X...

I'll look into including that switch into my pmac code as well
and see if it works properly in all cases (I think so). Also,
recent DRI CVS finally has working suspend/resume (works on
console switch too).

Ben.
