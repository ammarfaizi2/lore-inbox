Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUJWIiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUJWIiP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 04:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUJWIiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 04:38:15 -0400
Received: from mail1.kontent.de ([81.88.34.36]:58764 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267189AbUJWIiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 04:38:05 -0400
Subject: Re: BT878 drivers, where did you go?
From: Markus Trippelsdorf <markus@trippelsdorf.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098465019.5700.11.camel@localhost.localdomain>
References: <1098465019.5700.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 23 Oct 2004 10:38:10 +0200
Message-Id: <1098520691.32575.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 11:10 -0600, Bob Gill wrote:
> Hi.  I recently built 2.6.9-bk7.  Everything works as 2.6.9 except for
> my TV tuner card (which needs a bt878 driver).  The problem is that
> there is no bt878 driver.  There was one in 2.6.9-bk3 which worked (3
> days ago!!!).  Where did the driver go?  There doesn't seem to be '878
> support in "make menuconfig" either.  Was support for bt878 tv tuner
> cards dropped from the kernel?
> 

I had the same problem. It is caused by a new dependency on FW_LOADER,
which was not there before.
Just edit drivers/media/video/Kconfig and replace FW_LOADER with SOUND
in the VIDEO_BT848 dependency line.

HTH, Markus 

