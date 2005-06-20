Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVFTSaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVFTSaC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFTS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:29:40 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:36366 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261427AbVFTS3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:29:24 -0400
Date: Mon, 20 Jun 2005 20:29:47 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.12-mm1
Message-Id: <20050620202947.040be273.khali@linux-fr.org>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
References: <20050619233029.45dd66b8.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Mauro, all,

Two things I am worried about.

First point:

> -i2c-chips-need-hwmon.patch
> -gregkh-i2c-hwmon-02-sparc64-fix.patch
> (...)
>  Merged

Hopefully not, as they were fixes for:

> -gregkh-i2c-hwmon-01.patch
> -gregkh-i2c-hwmon-02.patch
> -gregkh-i2c-hwmon-03.patch

which were dropped (and quite rightly so).

> +gregkh-i2c-i2c-max6875.patch
> +gregkh-i2c-i2c-rename-i2c-sysfs.patch
> +gregkh-i2c-i2c-pca9539.patch
> +gregkh-i2c-i2c-ds1374-01.patch
> +gregkh-i2c-i2c-ds1374-02.patch
> +gregkh-i2c-i2c-ds1374-03.patch
> +gregkh-i2c-i2c-w83781d-remove-non-i2c-chips.patch
> +gregkh-i2c-w1-01.patch
> +gregkh-i2c-w1-02.patch
> +gregkh-i2c-w1-03.patch
> +gregkh-i2c-w1-04.patch
> +gregkh-i2c-w1-05.patch
> +gregkh-i2c-w1-06.patch
> +gregkh-i2c-w1-07.patch
> 
>  Updates to the driver core tree

All these are obviously i2c updates, not driver core updates.

Andrew, something's wrong in your log generator (if such a thing
exists)?

Second point:

> +gregkh-i2c-i2c-address_range_removal-v4l-fix.patch
> +gregkh-i2c-i2c-address_range_removal-v4l-fix-fix.patch
> 
>  Fix v4l updates for changes in Greg's i2c tree

All these changes were already present and correct in
i2c-address_range_removal.patch, which is in Greg's i2c tree for 2.5
months. Then Mauro Carvalho Chehab reverted them with
v4l-update-for-tuner-cards-and-some-chips.patch, breaking several v4l
drivers. And then he provides a "fix" with
gregkh-i2c-i2c-address_range_removal-v4l-fix.patch, which ironically
reads:

> From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> 
> This patch is necessary to correct I2C detect after normal_i2c_range
> removal in gregkh-i2c-i2c-address_range_removal.patch.

No, Mauro. This patch is necessary to fix something YOU just broke with
your previous patch. So please learn how to make correct patches that
don't randomly revert previous changes. This will make everyone's life
easier, including Andrew's, Greg's and mine.

Thanks,
-- 
Jean Delvare
