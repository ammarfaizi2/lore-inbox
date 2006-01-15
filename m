Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWAOJyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWAOJyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 04:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWAOJyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 04:54:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45573 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751887AbWAOJyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 04:54:15 -0500
Date: Sun, 15 Jan 2006 10:54:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6: xfs is rebuilt on every .config change
Message-ID: <20060115095410.GA8195@mars.ravnborg.org>
References: <200601151226.49461.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601151226.49461.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 12:26:46PM +0300, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This happened for a long time, actually in late 2.5.x (that I have started 
> with). Every time I make some changes to config - or simply do make oldconfig 
> - - xfs is rebuilt. This happens when there are *no* changes related to xfs 
> alltogether. E.g. I now applied 2.6.15.1 patch and xfs got rebuilt again.

The xfs source files do:
#include <version.h>
To gain access to actual kernel release.

So each time you do a change to the tree that causes version.h to be
updated the xfs source files will be recompiled.

Note that version.h includes "UTS_NAME" - unfortunately.
So you will see version.h being updated rather often if you have enabled
the "Automatically append version information to the version string" in
the "General Setup" menu.

	Sam
