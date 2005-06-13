Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVFMURr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFMURr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVFMUPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:15:18 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:61967 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261255AbVFMUNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:13:07 -0400
Date: Mon, 13 Jun 2005 22:13:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Mark Bidewell <mark.bidewell@alumni.clemson.edu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.11.12 I2C error
Message-Id: <20050613221310.7612a565.khali@linux-fr.org>
In-Reply-To: <9a87484905061312004b2b91e8@mail.gmail.com>
References: <42ADD458.3090906@alumni.clemson.edu>
	<9a87484905061312004b2b91e8@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper, Mark,

> > When I attempt to compile 2.6.11.12 from a full download. I get the
> > following messages:
> > 
> > include/linux/i2c.h:58: error: array type has incomplete element type
> > include/linux/i2c.h:197: error: array type has incomplete element type
> > 
> > I think the problem has to do with the forward declartion used in
> > those lines.

No actually it is due to the use of array notation ([]) instead of
pointer (*).

> > I am using gcc 4.0 on FC4 final
>
> Try an older gcc or a recent gcc snapshot. gcc 4.0 has known issues
> when compiling the kernel.

FWIW, this specific problem is already fixed in 2.6.12-rc6.

Thanks,
-- 
Jean Delvare
