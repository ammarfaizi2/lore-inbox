Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWEHXWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWEHXWD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 19:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWEHXWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 19:22:03 -0400
Received: from pv105234.reshsg.uci.edu ([128.195.105.234]:52358 "HELO
	pv105234.reshsg.uci.edu") by vger.kernel.org with SMTP
	id S1750848AbWEHXWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 19:22:00 -0400
Message-ID: <20060508232159.13550.qmail@pv105234.reshsg.uci.edu>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
            <445F64E2.3000902@dgreaves.com>
            <Pine.LNX.4.61.0605082214581.20743@yvahk01.tjqt.qr>
            <200605082246.50332@zodiac.zodiac.dnsalias.org>
In-Reply-To: <200605082246.50332@zodiac.zodiac.dnsalias.org>
From: Joe Feise <jfeise@feise.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Andrew Morton <akpm@osdl.org>, "Vladimir V. Saveliev" <vs@namesys.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: reiser4 bug [was Re: 2.6.17-rc3-mm1]
Date: Mon, 08 May 2006 16:21:59 -0700
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try the patch from here: 
http://marc.theaimsgroup.com/?l=reiserfs&m=114709188305181&w=2
That helped me get past the bootup phase (currently 8 hours uptime). 

 -Joe 

Alexander Gran writes: 

> Hi all, 
> 
> 2.6.17-rc3-mm1 doesn't get up running  here, it bugs around while init runs:
> I cannot login afterwards, and syslog did not get the bug too. So here are 
> some poor screenshots from my Treo650 (digicam is broken, sorry..;)
> EIP is in clear_inode.
> Trace:
> reiser4_delete_inode+0x6c/0xd0
> d_delete+0xf0/0x10f
> reiser4_delete_inode+0x0/0xd0
> generic_delete_inode+0x6b/0xfb
> input+0x5c/0x68
> do_unlikat+0xd7/0x12c
> sysenter_past_esp+0x54/0x75
> __hidp_send_ctrl_message+0xb4/0xfa
> details:
> http://zodiac.dnsalias.org/images/1.jpg
> http://zodiac.dnsalias.org/images/2.jpg
> http://zodiac.dnsalias.org/images/3.jpg
> http://zodiac.dnsalias.org/images/4.jpg
> Kernel config:
> http://zodiac.dnsalias.org/images/config
> System is my T40p, as usual. running an up2date debian unstable. 
> 
> regards
> Alex
