Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbRAaHKy>; Wed, 31 Jan 2001 02:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRAaHKo>; Wed, 31 Jan 2001 02:10:44 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:22533 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130378AbRAaHKh>;
	Wed, 31 Jan 2001 02:10:37 -0500
Message-ID: <3A77BAE7.3CC016AE@megapath.net>
Date: Tue, 30 Jan 2001 23:12:39 -0800
From: Miles Lane <miles@megapath.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, Ruurd Reitsma <R.A.Reitsma@wbmt.tudelft.nl>,
        Norberto Pellicci <pellicci@home.com>
Subject: Re: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
In-Reply-To: <4987.980895146@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Keith,

I don't get any errors if I add these lines to my .config
file:

	CONFIG_SOUND_OSS=m
	CONFIG_SOUND_ACI_MIXER=m

Ruurd, are you maintaining this driver?
If not, is anyone else willing to hack the config scripts
to enforce this dependency?  This is not my area of
competency.

Thanks,
	Miles

Keith Owens wrote:
> 
> On Tue, 30 Jan 2001 13:08:12 -0800,
> Miles Lane <miles@megapath.net> wrote:
> >depmod: *** Unresolved symbols in
> >/lib/modules/2.4.1/kernel/drivers/media/radio/radio-miropcm20.o
> >depmod:        aci_write_cmd
> >depmod:        aci_indexed_cmd
> >depmod:        aci_write_cmd_d
> 
> Those symbols are defined in drivers/sound/aci.c but are not exported
> for other modules to use.  The aci and miropcm20 code needs to be
> changed to support use as modules.  Also the config.in files need
> fixing for these files, it is possible to select combinations of aci
> and miropcm20 that will fail to link (miropcm20 built in, aci not
> selected or selected as a module) or fail to load (miropcm20 selected
> as a module, aci not selected).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
