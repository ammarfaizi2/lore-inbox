Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVDERuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVDERuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVDERtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:49:31 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:31395 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261855AbVDERbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:31:51 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bug with multiple help messages, the last one is shown
Date: Tue, 5 Apr 2005 19:36:12 +0200
User-Agent: KMail/1.7.2
Cc: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
References: <200503221832.41883.blaisorblade@yahoo.it> <Pine.LNX.4.61.0503222057580.25131@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0503222057580.25131@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504051936.12461.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late answer, Yahoo put your mail in its Spam folder, and I 
didn't check until now.

On Tuesday 22 March 2005 21:00, Roman Zippel wrote:
> Hi,
>
> On Tue, 22 Mar 2005, Blaisorblade wrote:
> > I've verified multiple times that if we have a situation like this
> >
> > bool A
> > depends on TRUE
> > help
> >   Bla bla1
> >
> > and
> >
> > bool A
> > depends on FALSE
> > help
> >   Bla bla2
> >
> > even if the first option is the displayed one, the help text used is the
> > one for the second option (the absence of "prompt" is not relevant here)!
>
> Is this based on a real problem?
Yes, look at the multiple help texts in lib/Kconfig.debug in vanilla 2.6.11, 
or, in the current bk tree, in lib/Kconfig.debug and arch/um/Kconfig for 
MAGIC_SYSRQ. For UML we need different help texts, so I'd like this solved.

If you definitely don't want to fix this, we can use the old 2.4 trick of 
having CONFIG_MAGIC_SYSRQ2, for instance, with the right help and defining 
MAGIC_SYSRQ as equal to MAGIC_SYSRQ2.
> I know that there's currently one help 
> text per symbol

> and the behaviour for multiple help texts is basically 
> undefined.
Yes, it's what I saw (actually I guess and seem to have verified that the last 
read text is used).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

