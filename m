Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTKJLtC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTKJLtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:49:02 -0500
Received: from [212.86.245.254] ([212.86.245.254]:43392 "EHLO umka.bear.com.ua")
	by vger.kernel.org with ESMTP id S263178AbTKJLtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:49:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Alex Lyashkov <shadow@itt.net.ru>
Organization: Home
To: Jan Kara <jack@suse.cz>
Subject: Re: [BUG] journal handler reference count breaked and fs deadlocked
Date: Mon, 10 Nov 2003 13:48:47 +0200
User-Agent: KMail/1.4.1
References: <200311092334.01957.shadow@itt.net.ru> <20031110111325.GC11335@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20031110111325.GC11335@atrey.karlin.mff.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311101348.49623.shadow@itt.net.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 November 2003 13:13, Jan Kara wrote:
>   Hi,
>
>   thanks for tracking. Are you able to reproduce the problem also on
> recent vanilla kernels (ie. 2.4.22)? Can you try the vanilla kernel with
> the attached patch (it should fix one of possible deadlocks).
>
Hi Jan

I can`t do it with vanila kernel, because my kernel not be exactly rh kernel.

It kernel from my fork vserver project who adapted to RH kernel tree.
i do stress testing and see this problems.
I see you only rename function, set NO_ATIME to diskquota..
and change at one point
-		commit_dqblk(dquot);
+		dquot->dq_sb->dq_op->write_dquot(dquot);
it`s rignt ?
i probe to adapted it fix to my kernel..

-- 
With best regards,
Alex
