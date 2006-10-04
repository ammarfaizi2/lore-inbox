Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWJDVZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWJDVZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWJDVZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:25:49 -0400
Received: from twin.jikos.cz ([213.151.79.26]:47574 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751143AbWJDVZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:25:48 -0400
Date: Wed, 4 Oct 2006 23:25:39 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: 2.6.18-git21, possible recursive locking in kseriod ends up in
 DWARF2 unwinder stuck
In-Reply-To: <5a4c581d0610041417y113bb92cs10971308180980e5@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610042317590.12556@twin.jikos.cz>
References: <5a4c581d0610041417y113bb92cs10971308180980e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006, Alessandro Suardi wrote:

> Non-fatal (box is still alive and apparently well) on boot,
> FC5-uptodate on a Dell Latitude C640. From the dmesg ring:

> [    8.680000] =============================================
> [    8.680000] [ INFO: possible recursive locking detected ]
> [    8.680000] 2.6.18-git21 #1
> [    8.680000] ---------------------------------------------
> [    8.680000] kseriod/163 is trying to acquire lock:
> [    8.680000]  (&ps2dev->cmd_mutex/1){--..}, at: [<c03198c3>]
> ps2_command+0x89/0x358

Me and Peter Zijlstra have already submitted patches to fix this - read 
the thread at 
http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-09/msg07416.html

I don't know the reason why these have not yet been merged into the input 
tree. Dmitry?

Thanks,

-- 
Jiri Kosina
