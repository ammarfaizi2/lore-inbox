Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161300AbWG1U65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbWG1U65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161301AbWG1U65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:58:57 -0400
Received: from [212.70.37.8] ([212.70.37.8]:26637 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161300AbWG1U65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:58:57 -0400
From: Al Boldi <a1426z@gawab.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Sat, 29 Jul 2006 00:00:16 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com> <200607281623.55290.rjw@sisk.pl> <200607282042.51831.rjw@sisk.pl>
In-Reply-To: <200607282042.51831.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607290000.16933.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Friday 28 July 2006 16:23, Rafael J. Wysocki wrote:
> > On Friday 28 July 2006 15:58, Al Boldi wrote:
> > > Rafael J. Wysocki wrote:
> > > > On Wednesday 26 July 2006 23:34, Al Boldi wrote:
> > > > > Rafael J. Wysocki wrote:
> > > > > > On Wednesday 26 July 2006 21:06, Al Boldi wrote:
> > > > > > > swsusp is really great, most of the time.  But sometimes it
> > > > > > > hangs after coming out of STR.  I suspect it's got something
> > > > > > > to do with display access, as this problem seems hw related. 
> > > > > > > So I removed the display card, and it positively does not
> > > > > > > resume from ram on 2.6.16+.
> > > > > > >
> > > > > > > Any easy fix for this?
> > > > > >
> > > > > > I have one idea, but you'll need a patch to test.  I'll try to
> > > > > > prepare it tomorrow.
> > > > > >
> > > > > > I guess your box is an i386?
> > > > >
> > > > > That should be assumed by default :)
> > > >
> > > > I had hoped I would be able to test it somewhere, but I couldn't.  I
> > > > hope it will compile. :-)
> > > >
> > > > If it does, please send me the output of dmesg after a fresh boot.
> > >
> > > See attached.  patched against 2.6.17.
> >
> > Well, the nosave ranges are the same in both cases, so it doesn't look
> > very promising.
> >
> > Have you tried to suspend with the patch applied?
>
> Ouch, sorry, it won't work.  It will have a chance to work with the
> appended patch applied.
>
> However, I've just noticed you said it didn't resume from RAM and these
> two patches could only fix the resume from disk. ;-)

Actually, I'm using suspend-to-disk to work around this STR problem, and STD 
seems to work fine.  It's STR that sometimes hangs after resuming.

> As far as the
> resume from RAM is concerned, I can only advise you to use a
> newest possible kernel and see if the problem is still there.

Have there been patches that address this issue?

Thanks!

--
Al

