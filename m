Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWGYTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWGYTjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWGYTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:39:45 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:19148 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964794AbWGYTjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:39:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: swsusp status report
Date: Tue, 25 Jul 2006 21:39:10 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200607251325.14747.rjw@sisk.pl> <20060725151145.GG14964@redhat.com>
In-Reply-To: <20060725151145.GG14964@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607252139.10356.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 17:11, Dave Jones wrote:
> On Tue, Jul 25, 2006 at 01:25:14PM +0200, Rafael J. Wysocki wrote:
> 
>  > V. Freeing memory
>  > 
>  > Step (3) of the suspend procedure is completed by calling the same
>  > functions that are normally used by kswapd, but in a slightly different way.
>  > The part of swsusp responsible for that is referred to as 'the memory
>  > shrinker' and it may sometimes be called by the suspend-to-RAM code as well
> 
> This isn't actually necessary though is it ?
> (Ie, it's a bug that needs fixing?)

Well, that depends on what FREE_PAGE_NUMBER, as defined in
kernel/power/main.c, is for.  Someone probably knows.
[I'm tempted to remove it, though. ;-) ]

> Good write-up btw, it may even be a nice addition to Documentation/power/  ?

I'm going to update the existing docs soon, so it probably won't be needed.
Still I think we can make it available from suspend.sf.net.

Rafael
