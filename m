Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbTCYHKL>; Tue, 25 Mar 2003 02:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbTCYHKL>; Tue, 25 Mar 2003 02:10:11 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:33970 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S261584AbTCYHKJ>; Tue, 25 Mar 2003 02:10:09 -0500
Date: Tue, 25 Mar 2003 18:22:30 +1100
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325072230.GA496@zip.com.au>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030325012252.7aafee8c.us15@os.inf.tu-dresden.de> <20030325003048.GC10505@kroah.com> <20030325041802.GA535@zip.com.au> <20030325043454.GJ11874@kroah.com> <20030325055613.GB464@zip.com.au> <20030325065125.GA12590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325065125.GA12590@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 10:51:25PM -0800, Greg KH wrote:
> On Tue, Mar 25, 2003 at 04:56:13PM +1100, CaT wrote:
> > > You will need the last one, I've attached it here.  Let me know if it
> > > fixes this or not.
> > 
> > I grabbed the entire patchset you posted for 2.5.66 and applied. Booted
> > without oops. Me happy. :)
> 
> Nice, thanks for testing, I really appreciate it.

No worries. Glad to help. :)

One point of note though. Should this be happening?

i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-piix4 version 2.7.0 (20021208)
piix4 smbus 00:07.3: Found Intel Corp. 82371AB/EB/MB PIIX4  device
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
i2c i2c-0: Error: no response!
registering i2c_dev_0
i2c i2c-0: Error: no response!

I only have the following compiled in:

# I2C support
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y
CONFIG_I2C_PIIX4=y
CONFIG_SENSORS_ADM1021=y

I trimmed things down to this through testing (I compiled in many
options and then left only the ones that appeared in
/proc/sys/dev/sensors)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
