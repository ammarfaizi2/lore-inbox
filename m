Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbTIOINO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 04:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTIOINO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 04:13:14 -0400
Received: from rth.ninka.net ([216.101.162.244]:65422 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261290AbTIOINN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 04:13:13 -0400
Date: Mon, 15 Sep 2003 01:11:59 -0700
From: "David S. Miller" <davem@redhat.com>
To: =?ISO-8859-1?B?RGFuaets?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
Message-Id: <20030915011159.250f3346.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0309141117030.15181-100000@deadlock.et.tudelft.nl>
References: <Pine.GSO.4.44.0309141155480.22863-100000@math.ut.ee>
	<Pine.LNX.4.44.0309141117030.15181-100000@deadlock.et.tudelft.nl>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003 11:35:46 +0200 (CEST)
Daniël Mantione <daniel@deadlock.et.tudelft.nl> wrote:

> Ok. The sparc code has not been modified; something weird is going on. (By
> the way, the Sparc code could use some design improvement, as a special
> exception, the Sparc does backcalculation and it is hacky implemented).

Any time someone messes with the clock timing code, they always
break Sparc.

We have to make assumptions about several things, one of which
is the clock crystal used because the Sun firmware provides
no way to just guess this so we just have to know what it is.

Second, as you mention we reverse calculate the clocks to turn the
video mode the firmware brought the card up in into the parameters the
driver wants.

Please, can we revert your changes if we can't fix Sparc quickly?
This is a pretty serious regression you've added and I have this
feeling it's going to stay broke for some time as you go back and
forth with us trying to resolve this.
