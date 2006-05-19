Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWESSFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWESSFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWESSFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:05:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932373AbWESSFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:05:32 -0400
Date: Fri, 19 May 2006 11:08:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] ufs: directory and page cache: from blocks to pages
Message-Id: <20060519110821.7d033ee4.akpm@osdl.org>
In-Reply-To: <20060519171833.GA28572@rain.homenetwork>
References: <20060519171833.GA28572@rain.homenetwork>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Dushistov <dushistov@mail.ru> wrote:
>
> This patch changes function in fs/ufs/dir.c and fs/ufs/namei.c
> to work with pages instead of straight work with blocks.

Yeah, this is nice-looking stuff, thanks.

Beware that the code which you've borrowed from ext2 has had several really
subtle problems over the past few years.  Stress-testing of this new code
(especially on small-blocksize filesystems and under memory pressure) might
reveal defects.  Still, it could hardly be worse than the present situation.


Does anyone know of a good way of creating UFS filesytems under Linux?  I
had a go at porting BSD ufsutils a few years ago and nearly died.  There's
http://ufs-linux.sourceforge.net/, but that hasn't been touched in a couple
of years..

