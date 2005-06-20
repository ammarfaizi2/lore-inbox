Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVFTVFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVFTVFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVFTU6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:58:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261756AbVFTUoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:44:19 -0400
Date: Mon, 20 Jun 2005 13:41:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: mchehab@brturbo.com.br, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: 2.6.12-mm1
Message-Id: <20050620134146.0e5de567.akpm@osdl.org>
In-Reply-To: <20050620202947.040be273.khali@linux-fr.org>
References: <20050619233029.45dd66b8.akpm@osdl.org>
	<20050620202947.040be273.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
> Hi Andrew, Mauro, all,
> 
> Two things I am worried about.
> 
> First point:
> 
> > -i2c-chips-need-hwmon.patch
> > -gregkh-i2c-hwmon-02-sparc64-fix.patch
> > (...)
> >  Merged
> 
> Hopefully not, as they were fixes for:
> 
> > -gregkh-i2c-hwmon-01.patch
> > -gregkh-i2c-hwmon-02.patch
> > -gregkh-i2c-hwmon-03.patch
> 
> which were dropped (and quite rightly so).

OK, I lose track of why patches became irrelevant.

> > +gregkh-i2c-i2c-max6875.patch
> > +gregkh-i2c-i2c-rename-i2c-sysfs.patch
> > +gregkh-i2c-i2c-pca9539.patch
> > +gregkh-i2c-i2c-ds1374-01.patch
> > +gregkh-i2c-i2c-ds1374-02.patch
> > +gregkh-i2c-i2c-ds1374-03.patch
> > +gregkh-i2c-i2c-w83781d-remove-non-i2c-chips.patch
> > +gregkh-i2c-w1-01.patch
> > +gregkh-i2c-w1-02.patch
> > +gregkh-i2c-w1-03.patch
> > +gregkh-i2c-w1-04.patch
> > +gregkh-i2c-w1-05.patch
> > +gregkh-i2c-w1-06.patch
> > +gregkh-i2c-w1-07.patch
> > 
> >  Updates to the driver core tree
> 
> All these are obviously i2c updates, not driver core updates.
> 
> Andrew, something's wrong in your log generator (if such a thing
> exists)?

It was after my bedtime.

> Second point:
> 
> > +gregkh-i2c-i2c-address_range_removal-v4l-fix.patch
> > +gregkh-i2c-i2c-address_range_removal-v4l-fix-fix.patch
> > 
> >  Fix v4l updates for changes in Greg's i2c tree
> 
> All these changes were already present and correct in
> i2c-address_range_removal.patch, which is in Greg's i2c tree for 2.5
> months. Then Mauro Carvalho Chehab reverted them with
> v4l-update-for-tuner-cards-and-some-chips.patch, breaking several v4l
> drivers. And then he provides a "fix" with
> gregkh-i2c-i2c-address_range_removal-v4l-fix.patch, which ironically
> reads:
> 
> > From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> > 
> > This patch is necessary to correct I2C detect after normal_i2c_range
> > removal in gregkh-i2c-i2c-address_range_removal.patch.
> 
> No, Mauro. This patch is necessary to fix something YOU just broke with
> your previous patch. So please learn how to make correct patches that
> don't randomly revert previous changes. This will make everyone's life
> easier, including Andrew's, Greg's and mine.

Yup.  This sort of thing often happens when teams run parallel CVS trees.

I don't think anything needs to be done by Mauro in this case.  Once Greg's
patches are merged up I'll fold the two fixes into the v4l patches then
send them off to Linus and everything will come out squeaky clean.
