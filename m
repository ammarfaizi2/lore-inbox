Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUJCXV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUJCXV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUJCXV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:21:58 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:48027 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268234AbUJCXV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:21:57 -0400
Subject: Re: Merging DRM and fbdev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@linux.ie>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
References: <9e47339104100220553c57624a@mail.gmail.com>
	 <Pine.LNX.4.58.0410030824280.2325@skynet>
	 <9e4733910410030833e8a6683@mail.gmail.com>
	 <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096841964.16457.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 03 Oct 2004 23:19:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-03 at 16:50, Vladimir Dergachev wrote:
> In particular, I can contribute the code that does Framebuffer->System Ram
> transfers over PCI/AGP. It is currently GPL licensed, but there is no 
> problem if BSD folks want it too.

This will do *wonders* to X render performance if used properly on those
cards we can't do render in hardware.

> This is also potentially useful for any Mesa functions that want to 
> transfer data back from video RAM - using plain reads for this is really slow.

Agreed - and Mesa tends to skip even tricks like SSE2 that can quadruple
read performance.
