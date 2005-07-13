Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVGMKd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVGMKd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVGMKd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:33:29 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:19840 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262573AbVGMKd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:33:28 -0400
Date: Wed, 13 Jul 2005 12:36:07 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, michael@mihu.de, kraxel@suse.de
Message-ID: <20050713103607.GE31464@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
	michael@mihu.de, kraxel@suse.de
References: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de> <20050710193529.21.pUfAyp2837.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050710193529.21.pUfAyp2837.2247.olh@nectarine.suse.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.214.7
Subject: Re: [linux-dvb-maintainer] [PATCH 21/82] remove linux/version.h from drivers/media/
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 07:35:29PM +0000, Olaf Hering wrote:
> 
> changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
> 
> remove code for obsolete kernels, drivers/media/video/bttvp.h has:
> #define BTTV_VERSION_CODE KERNEL_VERSION(0,9,15)
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
> drivers/media/common/saa7146_fops.c     |    1 -
> drivers/media/common/saa7146_i2c.c      |    5 -----
> drivers/media/dvb/cinergyT2/cinergyT2.c |    1 -
> drivers/media/dvb/dvb-core/dvb_net.c    |    5 -----
> drivers/media/dvb/frontends/dib3000mb.c |    1 -
> drivers/media/dvb/frontends/dib3000mc.c |    1 -
> include/media/saa7146.h                 |   10 ----------

I am puzzled because the saa7146 driver in DVB CVS has different
KERNEL_VERSION #ifdefs. I am currently trying to find out if
they can be removed all together from CVS.

In any event the patch does the right thing and should be applied.

> drivers/media/video/arv.c               |    1 -
> drivers/media/video/bttv-cards.c        |   15 ---------------
> drivers/media/video/zr36016.c           |    1 -
> drivers/media/video/zr36050.c           |    1 -
> drivers/media/video/zr36060.c           |    1 -
> include/media/ir-common.h               |    1 -

These files are in video4linux CVS. I forwarded the patch to
the vide4linux list.

Thanks,
Johannes
