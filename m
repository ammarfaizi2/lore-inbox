Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274803AbRIUT53>; Fri, 21 Sep 2001 15:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274804AbRIUT5T>; Fri, 21 Sep 2001 15:57:19 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:23565 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274803AbRIUT5E>; Fri, 21 Sep 2001 15:57:04 -0400
Date: Fri, 21 Sep 2001 21:56:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg Ward <gward@python.net>
Cc: bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20010921215622.A1282@suse.cz>
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz> <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921154903.A621@gerg.ca>; from gward@python.net on Fri, Sep 21, 2001 at 03:49:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 03:49:03PM -0400, Greg Ward wrote:

> [Vojtech Pavlik]
> > Do you have the VIA IDE support enabled?
> 
> [my response]
> > I have tried it both ways, but I think only with 2.4.2.  I've only tried
> > one 2.4.9 build, and that was with CONFIG_BLK_DEV_VIA82CXXX=y.  I've
> > just done another build with slightly different config settings
> > (suggestion from Mark Hahn), but haven't tried it yet.  It still has
> > both the VIA and Promise (CONFIG_BLK_DEV_PDC202XX=y) support enabled.
> > 
> > I'll report back when I've tried this kernel build.
> 
> Still no luck with this slightly tweaked kernel config.
> 
> Here are the relevant config variables ("grep '=y' .config", copy lines
> from CONFIG_IDE to CONFIG_SCSI):
> 
>   CONFIG_IDE=y
>   CONFIG_BLK_DEV_IDE=y
>   CONFIG_BLK_DEV_IDEDISK=y
>   CONFIG_IDEDISK_MULTI_MODE=y
>   CONFIG_BLK_DEV_IDECD=y
>   CONFIG_BLK_DEV_IDEPCI=y
>   CONFIG_IDEPCI_SHARE_IRQ=y
>   CONFIG_BLK_DEV_IDEDMA_PCI=y
>   CONFIG_BLK_DEV_ADMA=y
>   CONFIG_IDEDMA_PCI_AUTO=y
>   CONFIG_BLK_DEV_IDEDMA=y
>   CONFIG_BLK_DEV_PDC202XX=y
>   CONFIG_PDC202XX_BURST=y
>   CONFIG_PDC202XX_FORCE=y
>   CONFIG_BLK_DEV_VIA82CXXX=y
>   CONFIG_IDEDMA_AUTO=y
>   CONFIG_BLK_DEV_IDE_MODES=y
> 
> Is there any point in upgrading to a kernel beyond 2.4.9?  Or has the
> relevant code not been touched lately?

There were updates in 2.4.9-pre2 in the VIA driver, so it might be worth
trying. Also disabling CONFIG_IDEDMA_AUTO may work, but you'll get slow
performance. Afterwards, though, you can do hdparm -i /dev/hd* and cat
/proc/ide/via, which will tell us interesting information, which may
lead us further to solving the problem. Btw, what clock and multiplier
your CPU is?

-- 
Vojtech Pavlik
SuSE Labs
