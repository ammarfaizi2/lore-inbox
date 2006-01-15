Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751912AbWAOMNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbWAOMNY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWAOMNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:13:22 -0500
Received: from mx02.qsc.de ([213.148.130.14]:47500 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1751912AbWAOMNV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:13:21 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Date: Sun, 15 Jan 2006 13:12:42 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
References: <200601151051.14827.rene@exactcode.de> <200601151141.30876.rene@exactcode.de> <20060115111922.GA13673@mars.ravnborg.org>
In-Reply-To: <20060115111922.GA13673@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601151312.42391.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sunday 15 January 2006 12:19, Sam Ravnborg wrote:
	> On Sun, Jan 15, 2006 at 11:41:30AM +0100, Ren? Rebe wrote: > > > So
	the real fix is to error out when .kernelrelease does not exists. > > >
	See attached patch. > > > > You expect us to run make prepare before
	make menuconfig or simillar? > > That sounds a bit odd ... > > The
	kernelrelease depends on the actual configuration. > So without having
	completed the make *config step kbuild cannot tell the > correct
	kernelrelease. > > Now with the patch attached to last mail kbuild will
	now error out in > case there is no valid kernelrelease. Thats obviously
	only a hack, since > we need to error out when .config has been updated
	and the new > kernelrelease has not been created. > > Maybe the better
	approach would be always to create the .kernelrelease > file as part of
	the configuration - based on the principle of least > suprise. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 15 January 2006 12:19, Sam Ravnborg wrote:
> On Sun, Jan 15, 2006 at 11:41:30AM +0100, Ren? Rebe wrote:
> > > So the real fix is to error out when .kernelrelease does not exists.
> > > See attached patch.
> >
> > You expect us to run make prepare before make menuconfig or simillar?
> > That sounds a bit odd ...
>
> The kernelrelease depends on the actual configuration.
> So without having completed the make *config step kbuild cannot tell the
> correct kernelrelease.
>
> Now with the patch attached to last mail kbuild will now error out in
> case there is no valid kernelrelease. Thats obviously only a hack, since
> we need to error out when .config has been updated and the new
> kernelrelease has not been created.
>
> Maybe the better approach would be always to create the .kernelrelease
> file as part of the configuration - based on the principle of least
> suprise.

Aside this "solution" still annoys me, you need at least patch the config 
stuff to not display an empty version string ;-)

I'm curious, aside rsbac, what in the .config is altering the KERNELRELEASE?

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
