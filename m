Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbTGLQVr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267874AbTGLQVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:21:30 -0400
Received: from RJ161046.user.veloxzone.com.br ([200.149.161.46]:55027 "EHLO
	mf.dnsalias.org") by vger.kernel.org with ESMTP id S265779AbTGLQTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:19:11 -0400
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
From: Miguel Freitas <miguel@cetuc.puc-rio.br>
To: Jamie Lokier <jamie@shareable.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030712162029.GE9547@mail.jlokier.co.uk>
References: <1058017391.1197.24.camel@mf>
	<Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
	<20030712154942.GB9547@mail.jlokier.co.uk>
	<Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com> 
	<20030712162029.GE9547@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jul 2003 13:41:04 -0300
Message-Id: <1058028064.1196.111.camel@mf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 13:20, Jamie Lokier wrote:
> I'm wondering what happens if the tasks are both good, early to bed
> without a fuss.  Neither runs their entire timeslice.
> 
> Or to illustrate: say xine uses 10% of my CPU.  What happens when I
> open 11 xine windows?

well of course 110% is more than what you have of resources and xine
would have to drop frames to keep it up... :)

anyway, if xine uses 10% of your CPU, that time is mostly likely spent
at the decoder thread. the only thread that i would set to use SOFTRR
would be the output thread, which does use very like CPU.

regards,

Miguel

