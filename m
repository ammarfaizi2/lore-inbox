Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270749AbTHQSg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270766AbTHQSg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:36:29 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:8979 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270749AbTHQSg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:36:28 -0400
To: Raistlin <raistlin83@libero.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat lost file problem
References: <1061139456.808.5.camel@debian>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 18 Aug 2003 03:36:13 +0900
In-Reply-To: <1061139456.808.5.camel@debian>
Message-ID: <87zni8xhb6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raistlin <raistlin83@libero.it> writes:

> Kernel Version:
> Linux debian 2.4.21 #6 SMP Wed Aug 6 11:55:01 CEST 2003 i686 GNU/Linux
> mv command Version:
> mv (coreutils) 5.0.90
> 
> 
> I've discovered that if you try to change the name of a file in a vfat
> partition only changing upper or lower case the file immediatly
> disappears.

Looks like 5.0.90 does it. If src and dst are same inode, just unlink
src. Probably it assume hard link.

Could you please report this to coreutils maintainer?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
