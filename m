Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWALLI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWALLI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWALLI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:08:26 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:40069 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932169AbWALLIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:08:25 -0500
Date: Thu, 12 Jan 2006 12:08:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ben Collins <ben.collins@ubuntu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-Reply-To: <1137031253.9643.38.camel@grayson>
Message-ID: <Pine.LNX.4.61.0601121155450.30994@scrub.home>
References: <0ISL003ZI97GCY@a34-mta01.direcway.com> <200601090109.06051.zippel@linux-m68k.org>
 <1136779153.1043.26.camel@grayson> <200601091232.56348.zippel@linux-m68k.org>
 <1136814126.1043.36.camel@grayson> <Pine.LNX.4.61.0601120019430.30994@scrub.home>
 <1137031253.9643.38.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Jan 2006, Ben Collins wrote:

> First, we need oldconfig because it allows us to look at the build log
> and see exactly what happened in the config stage. Silentoldconfig gives
> us no feedback for logs.

silentoldconfig gives you exactly the same information. Both conf and 
oldconfig will change invisible options without telling you, so it's not 
exact at all.
If you can't trust a silent oldconfig, a more verbose oldconfig can't tell 
you anything else, if it would it's a bug.

> 3) Obviously since current behavior of oldconfig was broken with a
> closed stdin, then it was never doing what anyone wanted in this usage
> case. Since no one else noticed it, that means that we are the only use
> case for this.

This is enough reason to simply hijack conf and use it for your own 
purpose without even asking the maintainer about the intended bahaviour?

> 5) My patch did not break anything, nor did it change anything that was
> already working.

It _was_ working like that, you're breaking it.

> 6) In response you make oldconfig work exactly opposite of
> silentoldconfig by using the default value for a config option when
> stdin is closed (basically acting like the user hit ENTER), and further
> break things for me in this usage case, with no purpose, and no reason
> for making your change the way you did. Since it was broken, you aren't
> helping anyone. We can't have the build system using default values. We
> need it to abort.

So simply use silentoldconfig.

bye, Roman
