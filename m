Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274801AbRIUTs7>; Fri, 21 Sep 2001 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274800AbRIUTst>; Fri, 21 Sep 2001 15:48:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28670 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S274799AbRIUTsj>; Fri, 21 Sep 2001 15:48:39 -0400
Date: Fri, 21 Sep 2001 15:49:03 -0400
From: Greg Ward <gward@python.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20010921154903.A621@gerg.ca>
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz> <20010921150806.A2453@gerg.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921150806.A2453@gerg.ca>; from gward@python.net on Fri, Sep 21, 2001 at 03:08:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Vojtech Pavlik]
> Do you have the VIA IDE support enabled?

[my response]
> I have tried it both ways, but I think only with 2.4.2.  I've only tried
> one 2.4.9 build, and that was with CONFIG_BLK_DEV_VIA82CXXX=y.  I've
> just done another build with slightly different config settings
> (suggestion from Mark Hahn), but haven't tried it yet.  It still has
> both the VIA and Promise (CONFIG_BLK_DEV_PDC202XX=y) support enabled.
> 
> I'll report back when I've tried this kernel build.

Still no luck with this slightly tweaked kernel config.

Here are the relevant config variables ("grep '=y' .config", copy lines
from CONFIG_IDE to CONFIG_SCSI):

  CONFIG_IDE=y
  CONFIG_BLK_DEV_IDE=y
  CONFIG_BLK_DEV_IDEDISK=y
  CONFIG_IDEDISK_MULTI_MODE=y
  CONFIG_BLK_DEV_IDECD=y
  CONFIG_BLK_DEV_IDEPCI=y
  CONFIG_IDEPCI_SHARE_IRQ=y
  CONFIG_BLK_DEV_IDEDMA_PCI=y
  CONFIG_BLK_DEV_ADMA=y
  CONFIG_IDEDMA_PCI_AUTO=y
  CONFIG_BLK_DEV_IDEDMA=y
  CONFIG_BLK_DEV_PDC202XX=y
  CONFIG_PDC202XX_BURST=y
  CONFIG_PDC202XX_FORCE=y
  CONFIG_BLK_DEV_VIA82CXXX=y
  CONFIG_IDEDMA_AUTO=y
  CONFIG_BLK_DEV_IDE_MODES=y

Is there any point in upgrading to a kernel beyond 2.4.9?  Or has the
relevant code not been touched lately?

        Greg
-- 
Greg Ward - Python bigot                                gward@python.net
http://starship.python.net/~gward/
Do radioactive cats have 18 half-lives?
