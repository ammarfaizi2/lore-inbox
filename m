Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVEEQrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVEEQrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVEEQrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:47:12 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:28072 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262158AbVEEQqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:46:42 -0400
Message-ID: <427A4DD9.4050108@tiscali.de>
Date: Thu, 05 May 2005 18:46:17 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Damir Perisa <damir.perisa@solnet.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to handle ... warning: `something' is deprecated ...
References: <200505051739.42521.damir.perisa@solnet.ch>
In-Reply-To: <200505051739.42521.damir.perisa@solnet.ch>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damir Perisa wrote:
> hi all,
> 
> i was wondering what i should do with warnings that come up. especially i 
> wonder about depreached code. should it be posted to the ML? do the 
> people maintaining the drivers/code know about them? what is the general 
> procedure? (i know warnings are not errors ;-)
> 
The Linux Kernel is just a bad patchwork -- there's no general procedure.
> examples (kernel26mm 2.6.12-rc3-mm3):
> 
>   CC      drivers/char/agp/efficeon-agp.o
> drivers/char/agp/efficeon-agp.c: In function `efficeon_create_gatt_table':
> drivers/char/agp/efficeon-agp.c:222: warning: passing arg 1 of 
> `virt_to_phys' makes pointer from integer without a cast
> 
This is architectur specific.
>   CC [M]  drivers/char/specialix.o
> drivers/char/specialix.c: In function `sx_check_io_range':
> drivers/char/specialix.c:343: warning: `check_region' is deprecated 
> (declared at include/linux/ioport.h:124)
> 
>   CC [M]  drivers/ide/ide-tape.o
> drivers/ide/ide-tape.c: In function `idetape_copy_stage_from_user':
> drivers/ide/ide-tape.c:2659: warning: ignoring return value of 
> `copy_from_user', declared with attribute warn_unused_result
> drivers/ide/ide-tape.c: In function `idetape_copy_stage_to_user':
> drivers/ide/ide-tape.c:2686: warning: ignoring return value of 
> `copy_to_user', declared with attribute warn_unused_result
> 
>   CC [M]  drivers/isdn/capi/capidrv.o
> drivers/isdn/capi/capidrv.c:2108:3: warning: #warning FIXME: maybe a race 
> condition the card should be removed here from global list /kkeil
> 
Well, this is just an information about a possible race condition.
>   CC [M]  drivers/isdn/hisax/config.o
> drivers/isdn/hisax/config.c: In function `HiSax_readstatus':
> drivers/isdn/hisax/config.c:636: warning: ignoring return value of 
> `copy_to_user', declared with attribute warn_unused_result
> drivers/isdn/hisax/config.c:647: warning: ignoring return value of 
> `copy_to_user', declared with attribute warn_unused_result
> 
>   CC      drivers/mca/mca-legacy.o
> In file included from drivers/mca/mca-legacy.c:31:
> include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please 
> move your driver to the new sysfs api"
> In file included from drivers/mca/mca-legacy.c:31:
> include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please 
> move your driver to the new sysfs api"
> 
>   CC [M]  drivers/net/irda/nsc-ircc.o
> drivers/net/irda/nsc-ircc.c: In function `nsc_ircc_cleanup':
> drivers/net/irda/nsc-ircc.c:229: warning: `pm_unregister_all' is 
> deprecated (declared at include/linux/pm.h:117)
> drivers/net/irda/nsc-ircc.c: In function `nsc_ircc_open':
> drivers/net/irda/nsc-ircc.c:366: warning: `pm_register' is deprecated 
> (declared at include/linux/pm.h:107)
> 
>   CC [M]  drivers/net/irda/smsc-ircc2.o
> drivers/net/irda/smsc-ircc2.c: In function `smsc_ircc_open':
> drivers/net/irda/smsc-ircc2.c:465: warning: `pm_register' is deprecated 
> (declared at include/linux/pm.h:107)
> drivers/net/irda/smsc-ircc2.c: In function `smsc_ircc_close':
> drivers/net/irda/smsc-ircc2.c:1696: warning: `pm_unregister' is deprecated 
> (declared at include/linux/pm.h:112)
> 
>   CC [M]  drivers/net/irda/ali-ircc.o
> drivers/net/irda/ali-ircc.c: In function `ali_ircc_cleanup':
> drivers/net/irda/ali-ircc.c:231: warning: `pm_unregister_all' is 
> deprecated (declared at include/linux/pm.h:117)
> drivers/net/irda/ali-ircc.c: In function `ali_ircc_open':
> drivers/net/irda/ali-ircc.c:360: warning: `pm_register' is deprecated 
> (declared at include/linux/pm.h:107)
> 
>   CC [M]  drivers/net/tulip/dmfe.o
> drivers/net/tulip/dmfe.c: In function `dmfe_parse_srom':
> drivers/net/tulip/dmfe.c:1805: warning: passing arg 1 of `__le16_to_cpup' 
> from incompatible pointer type
> drivers/net/tulip/dmfe.c:1817: warning: passing arg 1 of `__le32_to_cpup' 
> from incompatible pointer type
> drivers/net/tulip/dmfe.c:1817: warning: passing arg 1 of `__le32_to_cpup' 
> from incompatible pointer type
> 
See above.
>     CC [M]  drivers/net/ne2.o
> In file included from drivers/net/ne2.c:73:
> include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please 
> move your driver to the new sysfs api"
> 
> thank you in advance,
> 
> Damir Perisa
> 
Well I think this deprecation warnings should be fixed as fast as possible, because you can remove the old code and a you have uniform code -- not a mix of old and new code.

Matthias-Christian Ott
