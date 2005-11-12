Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVKLPba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKLPba (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 10:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVKLPba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 10:31:30 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:40721 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932265AbVKLPb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 10:31:29 -0500
Date: Sat, 12 Nov 2005 16:31:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Nick Warne <nick@linicks.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext3: Fix warning without quota support (was: Linux
 2.6.14)
Message-Id: <20051112163153.6b54ee83.khali@linux-fr.org>
In-Reply-To: <200511121412.35029.nick@linicks.net>
References: <200511121412.35029.nick@linicks.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

> > Fix the following warning when ext3 fs is compiled without quota
> > support:
> >
> > fs/ext3/super.c: In function `ext3_show_options':
> > fs/ext3/super.c:516: warning: unused variable `sbi'
> 
> I have added this small fix to my 2.6.14.2 build.  A quick question.

Let is be noted that this warning was fixed in a completely different
way in Linus' tree already. My patch is not meant for -stable either,
as it doesn't fix any real problem.

> What does GCC do here - does it just drop and ignore the unused variable?

Without optimizations, gcc 3.3.6 keeps the variable although it won't
ever be used. With -O1 and above (including -Os) it drops the unused
variable.

-- 
Jean Delvare
