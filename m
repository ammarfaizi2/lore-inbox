Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUAIATH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbUAIATH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:19:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:31437 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265880AbUAIARc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:17:32 -0500
Date: Thu, 8 Jan 2004 16:18:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ramon.rey@hispalinux.es, ramon.rey@augcyl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.1-rc2-mm1][BUG] Badness in unblank_screen at
 drivers/char/vt.c:2793
Message-Id: <20040108161843.1bbd16b1.akpm@osdl.org>
In-Reply-To: <1073607026.4067.178.camel@gaston>
References: <1073605532.1070.6.camel@debian>
	<20040108155940.68ab047a.akpm@osdl.org>
	<1073607026.4067.178.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> I don't have an update ready at the moment, nothing critical need
> updating and I was waiting to see if the WARN_ON would catch some
> stuffs :)
> 
> It's probably worth adding a WARN_CONSOLE_UNLOCKED() macro that
> does the above rather than fixing all the WARN_ON's don't you
> think ? If yes, then I'll do a new patch.

I wouldn't bust a gut over it - this is the only code path which I've seen
generate the warning (famous last words).

