Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWCTNY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWCTNY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWCTNY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:24:27 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61142 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932298AbWCTNY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:24:26 -0500
Subject: Re: kernel cache mem bug(?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kernel@ministry.se
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GHP.4.44.0603200654330.18694-100000@celeborn.ministry.se>
References: <Pine.GHP.4.44.0603200654330.18694-100000@celeborn.ministry.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Mar 2006 13:31:18 +0000
Message-Id: <1142861478.20050.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-20 at 09:09 +0100, kernel@ministry.se wrote:
> The RAM is 100% OK, both according to the initial BIOS memory check and
> memtest86 running for more than four (4) hours straight.
> 
> One more thing that we just noticed: it seems the cache corruption (or
> whatever it is)  only occurs when X is running.

X is special in a couple of ways - it accesses hardware directly and it
uses AGP. See if setting the NoAccel X option makes any difference to
the failures - it'll make your desktop slower but should help validate X
is the problem. If that does help then try disabling DRI (3D) support if
your box has it, and see what that does. If it works with noaccel and
fails with DRI then finally try with no AGP support built into your
kernel.  That should identify the problem as X, DRI, AGP or other.

Alan

