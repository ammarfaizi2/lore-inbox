Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266788AbTGGCHq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbTGGCHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:07:46 -0400
Received: from host151.spe.iit.edu ([198.37.27.151]:26325 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S266788AbTGGCHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:07:42 -0400
Date: Sun, 6 Jul 2003 21:22:13 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduler merged
Message-ID: <20030707022212.GE27027@lostlogicx.com>
References: <20030705133334.4cc7e11b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030705133334.4cc7e11b.akpm@osdl.org>
X-Operating-System: Linux found.lostlogicx.com 2.4.20-pfeifer-r1_pre7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07/05/03 at 13:33:34 -0700, Andrew Morton wrote:
> - These changes have been well tested, but it is five months work and
>   over 100 patches.  There's probably a bug or two.  If you suspect that
>   something has gone wrong at the block layer (lots of tasks stuck in D
>   state) then please retest with `elevator=deadline'.
> 
> Thanks.

I am seeing these D tasks when running 2.5.74-mm2 under a heavy seeking
load (compiling application, untarring kernel, and filesharing
simultaneously) on a slow (laptop 4200RPM) hdd.  I find that after about
10 uptime when I start throwing on the seeking loads one or all of them
go to D state and any new disk IO is either blocked or very slow.

I have tested with elevator=deadline and have been unable to reproduce.

Any further testing or debugging you need me to do I can probably do
(but I'm not terribly knowledgable so I'll need step by step for said
testing).  Thanks!

Brandon Low
