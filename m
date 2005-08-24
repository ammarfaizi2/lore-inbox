Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVHXWUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVHXWUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVHXWUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:20:13 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:23566 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932326AbVHXWUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:20:12 -0400
Date: Thu, 25 Aug 2005 00:19:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6] I2C: Drop I2C_DEVNAME and i2c_clientname
Message-Id: <20050825001958.63b2525c.khali@linux-fr.org>
In-Reply-To: <1124741348.4516.51.camel@localhost>
References: <20050815195704.7b61206e.khali@linux-fr.org>
	<1124741348.4516.51.camel@localhost>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

> > I2C_DEVNAME and i2c_clientname were introduced in 2.5.68 [1] to help
> > media/video driver authors who wanted their code to be compatible
> > with both Linux 2.4 and 2.6. The cause of the incompatibility has
> > gone since [2], so I think we can get rid of them, as they tend to
> > make the code harder to read and longer to preprocess/compile for no
> > more benefit.
> > 
> > I'd hope nobody seriously attempts to keep media/video driver
> > compatible across Linux trees anymore, BTW.
>
> That's not true. We keep V4L tree compatible with older kernel
> releases. Each change like this does generate a lot of work at V4L
> side to provide #ifdefs to check for linux version and provide a
> compatible way to compile with older versions.

I'm sorry but we will not stop updating the various Linux 2.6 subsystems
to keep them compatible with 2.4 - else one would wonder why there is a
2.6 kernel tree at all. As time goes, the differences bwteen 2.4 and 2.6
will only increase. You seem to be trying to keep common driver code
across incompatible trees. I'm not surprised that it is a lot of work.
That's your choice, live with it.

> I don't see any sense on applying this patch, since it will not reduce
> code size or increase execution time.

Code size and execution time are not the only factors to take into
account. Code readability and compilation time are two other ones that I
mentioned already.

Anyway, it doesn't look like you actually read what I wrote in the first
place. My comment about common driver code was really only by the way.
The reason why I have been proposing this patch is that I2C_DEVNAME and
i2c_clientname were only needed between Linux 2.5.68 and 2.6.0-test3,
which are unsupported by now, as they were development releases. As far
as i2c_client.name is concerned, 2.4 and 2.6.0+ trees are compatible.

Thanks,
-- 
Jean Delvare
