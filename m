Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVFMQf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVFMQf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFMQf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:35:27 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:45574 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261611AbVFMQfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:35:16 -0400
Date: Mon, 13 Jun 2005 18:35:23 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com
Subject: Re: [PATCH] Adds support for TEA5767 chipset on V4L
Message-Id: <20050613183523.322529e0.khali@linux-fr.org>
In-Reply-To: <42ACAA3B.8050307@brturbo.com.br>
References: <42ACAA3B.8050307@brturbo.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

> PS 3: There were some I2C changes that affected V4L on 2.6.12-rc6-mm1.
> Now, it is necessary to use probe option in tuner to have its I2C
> addresses recognized by V4L. New patches will come to correct this
> behavior.

Which i2c patch please? The changes I made should not cause any trouble
to V4L drivers. If they do this is a bug, please report it as such.

Also, a comment on your patch (which I didn't actually review, as I do
not feel qualified to do so):

> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> +#include "tuner.h"
> +#include "i2c-compat.h"
> +#else
> +#include <media/tuner.h>
> +#endif

No such test please, it is useless. This is Linux 2.6.x, no need to
check this.

-- 
Jean Delvare
