Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUEAGwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUEAGwT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 02:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUEAGwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 02:52:19 -0400
Received: from imap.gmx.net ([213.165.64.20]:60328 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261918AbUEAGwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 02:52:17 -0400
X-Authenticated: #4512188
Message-ID: <409348D7.4000708@gmx.de>
Date: Sat, 01 May 2004 08:51:03 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       a.verweij@student.tudelft.nl, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <200404131117.31306.ross@datscreative.com.au>	 <200404131703.09572.ross@datscreative.com.au>	 <1081893978.2251.653.camel@dhcppc4>	 <200404160110.37573.ross@datscreative.com.au>	 <1082060255.24425.180.camel@dhcppc4>	 <1082063090.4814.20.camel@amilo.bradney.info>	 <1082578957.16334.13.camel@dhcppc4>  <4086E76E.3010608@gmx.de> <1082587298.16336.138.camel@dhcppc4>
In-Reply-To: <1082587298.16336.138.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

don't you want to change your wip.patch in such a way, that it always 
activates on nforce2? Allen told that "The 8254 PIT is hardwared to IRQ0 
on all nForce chipsets, it can't be routed.", which I guess is what you 
needed to know. If this statement doesn't apply to the timer fix, here 
dmidecode change of newest bios for Abit NF7-S v2: Just need to
change

MATCH(DMI_BIOS_DATE, "03/24/2004")

to

MATCH(DMI_BIOS_DATE, "04/22/2004")

Prakash



> +	{ ignore_timer_override, "Abit NF7-S v2", {
> +			MATCH(DMI_BOARD_VENDOR, "http://www.abit.com.tw/"),
> +			MATCH(DMI_BOARD_NAME, "NF7-S/NF7,NF7-V (nVidia-nForce2)"),
> +			MATCH(DMI_BIOS_VERSION, "6.00 PG"),
> +			MATCH(DMI_BIOS_DATE, "03/24/2004") }},
> +
