Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUKMVYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUKMVYe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKMVYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:24:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:42946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261195AbUKMVWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:22:48 -0500
Date: Sat, 13 Nov 2004 13:22:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5 [u]
Message-Id: <20041113132232.5c201000.akpm@osdl.org>
In-Reply-To: <1100380593.12663.1.camel@nosferatu.lan>
References: <20041111012333.1b529478.akpm@osdl.org>
	<1100368553.12239.3.camel@nosferatu.lan>
	<1100380593.12663.1.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Schlemmer [c]" <azarah@nosferatu.za.org> wrote:
>
> > I want to imagine there is some reason why some threading apps will have
>  > issues?  I have since rc1-mm4 issues with evolution - some threads do
>  > not seem to come out of sleep or get running time for some reason.
>  > Unfortunately I cannot find the thread again.  Is there a patch I can
>  > apply/revert to get it to work for now?
>  > 
> 
>  I should note that if I killall -STOP and then killall -CONT all
>  evolution processes (evolution-data-server-1.0, evolution-alarm-notify
>  and evolution-2.0) it works again for a while.  The issue happens pretty
>  quick after I start evo ...

Could you please try:

wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/futex_wait-fix.patch
patch -R -p1 < futex_wait-fix.patch

the retest?
