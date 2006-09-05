Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWIEKlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWIEKlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWIEKlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:41:03 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:49383 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751309AbWIEKlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:41:01 -0400
Message-ID: <44FD5342.1040207@s5r6.in-berlin.de>
Date: Tue, 05 Sep 2006 12:36:50 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: bcollins@debian.org, scjody@modernduck.com,
       linux1394-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: set power state of firewire host during suspend
References: <20060905081426.GA4105@elf.ucw.cz>
In-Reply-To: <20060905081426.GA4105@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> --- a/drivers/ieee1394/ohci1394.c
> +++ b/drivers/ieee1394/ohci1394.c
> @@ -3565,6 +3565,7 @@ static int ohci1394_pci_suspend (struct 
>  	}
>  #endif
>  
> +	pci_set_power_state(pdev, pci_choose_state(pdev, state));
>  	return 0;
>  }
>  
> 

Does this work on PPC_PMAC? Note the platform code before #endif.
http://www.linux-m32r.org/lxr/http/source/drivers/ieee1394/ohci1394.c?v=2.6.18-rc5-mm1#L3554
-- 
Stefan Richter
-=====-=-==- =--= --=-=
http://arcgraph.de/sr/
