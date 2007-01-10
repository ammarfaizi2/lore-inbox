Return-Path: <linux-kernel-owner+w=401wt.eu-S932508AbXAJIxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbXAJIxt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 03:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbXAJIxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 03:53:49 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:2791 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932508AbXAJIxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 03:53:48 -0500
Date: Wed, 10 Jan 2007 09:53:50 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
Message-Id: <20070110095350.8669dbba.khali@linux-fr.org>
In-Reply-To: <20070109152534.ebfa5aa8.akpm@osdl.org>
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109170550.AFEF460C343@tzec.mtu.ru>
	<20070109214421.281ff564.khali@linux-fr.org>
	<20070109133121.194f3261.akpm@osdl.org>
	<Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
	<20070109152534.ebfa5aa8.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

On Tue, 9 Jan 2007 15:25:34 -0800, Andrew Morton wrote:
> On Tue, 9 Jan 2007 15:21:51 -0800, Linus Torvalds wrote:
> > Actually, how about just removing the incrementing version count entirely?
>
> I use it pretty commonly to answer the question "did I remember to install
> that new kernel I just built before I rebooted"?  By comparing `uname -a'
> with $TOPDIR/.version.

This will no longer work with the current state of things, as
$TOPDIR/.version keeps increasing.

> > (...) We have more useful _real_ versioning these days, with git commit
> > ID's etc.

These are completely different types of IDs. The .version number is a
local build ID and changes when one applies a local patch, or simply
changes a config option, and recompiles his/her kernel. The git ID of
course doesn't.

>From the other comments in this thread, it looks like the build ID is
something many people are interested in, so we can't just drop it.

-- 
Jean Delvare
