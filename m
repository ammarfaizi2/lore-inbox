Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWIIWPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWIIWPg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWIIWPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:15:36 -0400
Received: from moooo.ath.cx ([85.116.203.178]:62856 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964965AbWIIWPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:15:35 -0400
Date: Sun, 10 Sep 2006 00:15:32 +0200
From: Matthias Lederhofer <matled@gmx.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/PATCH] make deb-pkg: optionally use fakeroot
Message-ID: <20060909221532.GA4749@moooo.ath.cx>
References: <20060908185316.GA20352@moooo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908185316.GA20352@moooo.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Lederhofer <matled@gmx.net> wrote:
> Problem: deb-pkg needs root privileges or fakeroot but git-diff-index
> does not work correctly with fakeroot.  Perhaps this variable should
> have another name and be added to the other package targets too.

<gitster> So "fakeroot -u" (Use the real ownership of files previously
    unknown to fakeroot instead of pretending they are owned by
    root:root.) would be a good workaround.
<gitster> Eh, not a workaround but probably that is the right thing to do.

This solves the problem, just ignore the patch.
