Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbTFYUQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTFYUQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:16:53 -0400
Received: from imap.gmx.net ([213.165.64.20]:12258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265025AbTFYUPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:15:32 -0400
Message-Id: <5.2.0.9.2.20030625222455.00cf33f0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 25 Jun 2003 22:33:58 +0200
To: Daniel Gryniewicz <dang@fprintf.net>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: patch O1int for 2.5.73 - interactivity work
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <1056569692.1594.30.camel@athena.fprintf.net>
References: <5.2.0.9.2.20030625204242.00ceda90@pop.gmx.net>
 <5.2.0.9.2.20030625204242.00ceda90@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:34 PM 6/25/2003 -0400, Daniel Gryniewicz wrote:
>On Wed, 2003-06-25 at 15:00, Mike Galbraith wrote:
> > At 02:09 AM 6/26/2003 +1000, Con Kolivas wrote:
> >
> > >I'm still working on something for the "xmms stalls if started during very
> > >heavy load" as a different corner case.
> >
><snip scheduler suggestion>
> > Just a couple random thoughts, both of which I can see problems with ;-)
> >
>
>At least on 2.4 (I use 21-ck3), it appears to be I/O starvation that
>gets xmms, not scheduler starvation.  When xmms skips for me, there's
>load, but there's also usually some idle time.  The common thread seems
>to be heavy I/O on the drive xmms is using, possibly combined with a
>(formerly?) interactive process (evolution rebuilding my LKML index, for
>example) doing the disk I/O.  Because of the assorted I/O scheduler
>changes in 2.5, this is unlikley to be the problem there.

Ahah.  I thought Con was referring to the delay at new song, new task 
starting at priority 20 while things higher are using the cpu.  Yeah, your 
skips sound like xmms is just running out of buffered data.

         -Mike 

