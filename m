Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUCWVoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbUCWVoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:44:34 -0500
Received: from ns.suse.de ([195.135.220.2]:24744 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262849AbUCWVoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:44:25 -0500
Subject: Re: [2.6.3] kernel BUG at fs/buffer.c:2660
From: Chris Mason <mason@suse.com>
To: Andrey A Belashkov <virus@center.hqhost.net>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@suse.de, com@hqhost.net
In-Reply-To: <20040323130843.GC15619@madman.hqhost.net>
References: <20040323130843.GC15619@madman.hqhost.net>
Content-Type: text/plain
Message-Id: <1080078391.11058.689.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 16:46:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-23 at 08:08, Andrey A Belashkov wrote:
> Hello Kernel Hackers.
> 
> On my wireless router i got strange bug. All what i can do after this,
> it`s type "dmesg". Then all user space processes are halts, but host 
> pings and proper work as router. This machine acts only as router. 
> Vanilla 2.6.3 kernel, just changed EXTRAVERSION for internal usage.
> 

This looks like a race between the journal writeback code and a
previously logged buffer being freed.  It's fixed in my logging
patchset, which I'm trying to get into the mainline kernels.

-chris


