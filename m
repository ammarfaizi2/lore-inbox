Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270164AbTGPGOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTGPGOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:14:40 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:61902 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S270164AbTGPGOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:14:38 -0400
Date: Wed, 16 Jul 2003 16:29:22 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: i2c+sensors still whacky (hi Greg :)
Message-ID: <20030716062922.GA1000@zip.com.au>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716061009.GA5037@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 11:10:09PM -0700, Greg KH wrote:
> On Wed, Jul 16, 2003 at 04:04:43PM +1000, CaT wrote:
> > On Tue, Jul 15, 2003 at 09:11:27AM -0700, Greg KH wrote:
> > Did I do the right thing?
> 
> Looks good, but are you _really_ building all of those drivers into your
> kernel?  Make them modules, that way booting will not require a small

No. Just i2c-dev, i2c-core, i2c-sensor, i2c-piix4 and adm1021. Sorry
for not weeding out the useless stuff above. I was still waking up. :)

> nap :)

:)

> Then load only the i2c bus driver that you have.  See if that causes the
> system to slow down, or cause any kernel log messages?

i2c alone does not.

> Only then try loading a i2c client driver, for your hardware.

I can go through this again. Do you want me to insert any further
debugging stuff?

> Exactly what i2c hardware do you have anyway?

PIIX4 and ADM1021.

.config has the following:

CONFIG_SENSORS_ADM1021=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_SENSOR=y

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
