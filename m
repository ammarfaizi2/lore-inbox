Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271823AbTGXXNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271815AbTGXXNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:13:17 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:36235
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S271819AbTGXXMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:12:49 -0400
Date: Thu, 24 Jul 2003 19:27:37 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: passing my own compiler options into linux kernel compiling
Message-ID: <20030724232737.GC28205@kurtwerks.com>
References: <200307240916.17530.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307240916.17530.cijoml@volny.cz>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Michal Semler:
> Hello,
> 
> I use gcc-3.3 and I would like compile my kernel with flags:
> 
> -O4 -march=pentium3 -mcpu=pentium3

Although it might be handled differently elsewhere, this snippet
from gcc/toplev.c suggests -O4 buys you nothing you don't get from
-O3:

  if (optimize >= 3)
    {
      flag_inline_functions = 1;
      flag_rename_registers = 1;
    }

Kurt
-- 
Substitute "damn" every time you're inclined to write "very"; your
editor will delete it and the writing will be just as it should be.
		-- Mark Twain
