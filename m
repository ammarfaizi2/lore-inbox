Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTIUQth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 12:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTIUQth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 12:49:37 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:2002
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262454AbTIUQtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 12:49:36 -0400
Date: Sun, 21 Sep 2003 12:49:33 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA]  Xircom nic hang on boot since cs.c race condition
 patch
Message-Id: <20030921124933.6ef0d1bb.seanlkml@rogers.com>
In-Reply-To: <20030920222207.B4517@flint.arm.linux.org.uk>
References: <20030917144406.753953dd.seanlkml@rogers.com>
	<20030920222207.B4517@flint.arm.linux.org.uk>
Organization: 
X-Mailer: Sylpheed version 0.9.4-gtk2-20030802 (GTK+ 2.2.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.103.218.41] using ID <seanlkml@rogers.com> at Sun, 21 Sep 2003 12:49:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Sep 2003 22:22:07 +0100
Russell King <rmk@arm.linux.org.uk> wrote:


> Ok, can you try the attached patch please?  It basically juggles the
> initialisation so that we avoid the locking issues by moving the init
> between our the socket driver and our private thread.
> 
> The patch is against Linus' tree as of last Wednesday.
> 
> Note that I haven't compile-tested this exact patch, (but one similar)
> so I need feedback from both cardbus and pcmcia-using people before I
> submit it.

Russell,

Thanks for the patch!  It applied cleanly against linus-bk as of
this morning and fixed the problem here.

Cheers,
Sean
