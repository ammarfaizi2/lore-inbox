Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWAOKly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWAOKly (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 05:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWAOKly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 05:41:54 -0500
Received: from mx02.qsc.de ([213.148.130.14]:47835 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1751867AbWAOKlx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 05:41:53 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Date: Sun, 15 Jan 2006 11:41:30 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
References: <200601151051.14827.rene@exactcode.de> <20060115100530.GB8195@mars.ravnborg.org>
In-Reply-To: <20060115100530.GB8195@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601151141.30876.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sunday 15 January 2006 11:05, Sam Ravnborg wrote:
	> On Sun, Jan 15, 2006 at 10:51:14AM +0100, Ren? Rebe wrote: > > Hi all,
	> > > > with at least 2.6.15-mm{2,3,4} untaring the kernel and running
	make > > menuconfig (or most other favourite config tools) do not
	display a > > version anymore since .kernelrelease it not build as
	dependecy. > > > > I only noticed this because my build scripts grab the
	version before the > > build for later file names on installations and
	leave this string empty > > after configuration of latest linux kernels.
	> > It is correct that "make kernelrelease" does not display correct
	info > until you have done a proper build of the kernel or at least the
	prepare > step. > > The issue here is that we shall avoid sideeffects
	when running "make > kernelrelease" so it does not trigger all sorts of
	commands when running > as root for instance. > > So the real fix is to
	error out when .kernelrelease does not exists. > See attached patch.
	[...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 15 January 2006 11:05, Sam Ravnborg wrote:
> On Sun, Jan 15, 2006 at 10:51:14AM +0100, Ren? Rebe wrote:
> > Hi all,
> >
> > with at least 2.6.15-mm{2,3,4} untaring the kernel and running make
> > menuconfig (or most other favourite config tools) do not display a
> > version anymore since .kernelrelease it not build as dependecy.
> >
> > I only noticed this because my build scripts grab the version before the
> > build for later file names on installations and leave this string empty
> > after configuration of latest linux kernels.
>
> It is correct that "make kernelrelease" does not display correct info
> until you have done a proper build of the kernel or at least the prepare
> step.
>
> The issue here is that we shall avoid sideeffects when running "make
> kernelrelease" so it does not trigger all sorts of commands when running
> as root for instance.
>
> So the real fix is to error out when .kernelrelease does not exists.
> See attached patch.

You expect us to run make prepare before make menuconfig or simillar?
That sounds a bit odd ...

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
