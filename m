Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129567AbQKNBOH>; Mon, 13 Nov 2000 20:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQKNBN5>; Mon, 13 Nov 2000 20:13:57 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60420 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129567AbQKNBNj>;
	Mon, 13 Nov 2000 20:13:39 -0500
Message-ID: <3A108A97.579DD607@mandrakesoft.com>
Date: Mon, 13 Nov 2000 19:43:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tulip oops
In-Reply-To: <Pine.LNX.4.21.0011140111480.20014-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 
> This patch makes tulip/eeprom.c more robust.
> 
> /Tobias
> 
> --- eeprom.c.orig       Mon Jun 19 22:42:39 2000
> +++ eeprom.c    Tue Nov 14 01:19:19 2000
> @@ -237,6 +237,7 @@
>                         printk(KERN_INFO "%s:  Index #%d - Media %s (#%d) described "
>                                    "by a %s (%d) block.\n",
>                                    dev->name, i, medianame[leaf->media], leaf->media,
> +                                  leaf->type >= ARRAY_SIZE(block_name) ? "UNKNOWN" :
>                                    block_name[leaf->type], leaf->type);
>                 }
>                 if (new_advertise)

Someone else already spotted that.

The patch is applied to the HEAD (a.k.a. devel a.k.a. unstable) branch
of the tulip CVS repository at:  http://sourceforge.net/projects/tulip/

It will be merged to the stable branch and 2.4.0-test11-preXX after some
testing of this and some other changes...

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
