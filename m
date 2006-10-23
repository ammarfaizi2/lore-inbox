Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWJWOoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWJWOoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWJWOoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:44:24 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:55740 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964894AbWJWOoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:44:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2: reproducible hang on shutdown on i386
Date: Mon, 23 Oct 2006 16:43:31 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610211930.05492.rjw@sisk.pl>
In-Reply-To: <200610211930.05492.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231643.32148.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 21 October 2006 19:30, Rafael J. Wysocki wrote:
> On Friday, 20 October 2006 10:56, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> > 
> > - Added the IOAT tree as git-ioat.patch (Chris Leech)
> > 
> > - I worked out the git magic to make the wireless tree work
> >   (git-wireless.patch).  Hopefully it will be in -mm more often now.
> 
> [Margin note: bcm43xx doesn't work on my test boxes although it used to on one
> of them, but I have to play with it a bit more.]
> 
> It looks like i386 cannot shut down cleanly with this kernel.  On my test
> boxes (2 of them) it hangs after killing all processes, 100% of the time.

I've carried out a binary search which shows that

add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch

causes this to happen.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
