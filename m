Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUIGRJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUIGRJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268175AbUIGRFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:05:37 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:12561 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S268342AbUIGQ6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:58:08 -0400
Date: Tue, 7 Sep 2004 16:57:55 +0000
To: Michal Ludvig <michal@logix.cz>
Cc: Andreas Happe <andreashappe@flatline.ath.cx>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040907165755.GA32032@old-fsckful.ath.cx>
References: <20040831175449.GA2946@final-judgement.ath.cx> <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com> <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz> <20040907143509.GA30920@old-fsckful.ath.cx> <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz>
User-Agent: Mutt/1.5.6+20040523i
From: crow@old-fsckful.ath.cx (Andreas Happe)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:49:14PM +0200, Michal Ludvig wrote:
> On Tue, 7 Sep 2004, Andreas Happe wrote:
> 
> > On Mon, Sep 06, 2004 at 08:49:30PM +0200, Michal Ludvig wrote:
> > > On Wed, 1 Sep 2004, Andreas Happe wrote:
> > BTW: the latest incarnation of the patch uses /sys/class/crypto/<cipher-name>.
> 
> Where can I get the updated version?

It's on my home computer (and I'm on vacation quite now ;). will do some additional
testing on friday and will post the patch around the weekend.

It uses class_device (see include/linux/device.h) instead of kobjects.

> This is a compile time thing, e.g. something like:
> 	.cia_min_keysize = 1,
> 	.cia_max_keysize = 128
> for variable keysizes, and
> 	.cia_keysizes = { 128, 192, 256, -1 }
> for discrete keysizes.
> typeof(cia_keysizes) would be "int[]".

can do, but see james morris other patch.

> > Isn't this against the "one value per file" - sysfs rule.
> 
> I didn't know about such a rule.

yup, is rather strict.

> Attached is my patch introducing preferences for current cryptoapi. How
> can this be done with the kobject model?

will look into it after I'm home from vacation.

	--AndreaS
