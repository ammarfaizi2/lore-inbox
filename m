Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262063AbSI3Nl7>; Mon, 30 Sep 2002 09:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262064AbSI3Nl5>; Mon, 30 Sep 2002 09:41:57 -0400
Received: from c0202001.roe.itnq.net ([217.112.132.110]:6784 "EHLO
	thinkpad.objectsecurity.cz") by vger.kernel.org with ESMTP
	id <S262063AbSI3Nlz>; Mon, 30 Sep 2002 09:41:55 -0400
Date: Mon, 30 Sep 2002 15:47:29 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.objectsecurity.cz
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps
 forever)
In-Reply-To: <20020930220130.6c4dd808.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.43.0209301538460.457-100000@thinkpad.objectsecurity.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Stephen Rothwell wrote:

> > But you don't have clean 2.4.19.
>
> True, I should try that.

Did you try it?

> > I've done it right now and it seems 2.4.19 w/o any patch is broken for me.
> > i.e. it behaves the same wrong way and hd is sleeping forevere after apm
> > resume...
> >
> > Anything what should I test now?
>
> Can you try 2.4.19 with the arch/i386/kernel/apm.c from 2.4.18?

I've tried it and w/o success so hd is still sleeping after resume. So
maybe the problem is somewhere else. Do you have any advice what should I
try now? 2.4.20-pre<latest>? Or some other files from 2.4.18?

BTW: I'm always waiting at most 5 minutes for hd wakeup, is that enough? I
hope so, since it's enough on 2.4.18...

<after some time looking into syslog>

Maybe you'll find usefull that I have these messages after resume in
syslog:

Sep 28 22:07:39 thinkpad apmd[211]: System Suspend
Sep 29 19:31:28 thinkpad apmd[211]: apmd_call_proxy: Executing proxy: '/etc/apm/apmd_proxy' 'resume' 'suspend'
Sep 29 19:31:45 thinkpad kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Sep 29 19:31:45 thinkpad kernel: hda: lost interrupt
Sep 29 19:31:48 thinkpad apmd[211]: apmd_call_proxy: +  Setting the System Clock using the Hardware Clock as reference... System Clock set. Local time: Sun Sep 29 19:31:48 CEST 2002
Sep 29 19:31:48 thinkpad apmd[211]: Normal Resume

But I don't know if they appear after every resume on working 2.4.18. I'd
have to check it.

Thanks a lot,

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com

