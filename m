Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293633AbSCATRi>; Fri, 1 Mar 2002 14:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293645AbSCATRa>; Fri, 1 Mar 2002 14:17:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38665 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293633AbSCATRV>;
	Fri, 1 Mar 2002 14:17:21 -0500
Message-ID: <3C7FD3C2.9674ADD7@mandrakesoft.com>
Date: Fri, 01 Mar 2002 14:17:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches.
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> --- linux-2.4.16/drivers/net/eepro100.c Mon Nov 12 18:47:18 2001
> +++ linux/drivers/net/eepro100.c        Tue Dec 18 11:36:11 2001
> @@ -510,12 +510,12 @@
>   static const char i82557_config_cmd[CONFIG_DATA_SIZE] = {
>          22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=Use MII  0=Use AUI */
>          0, 0x2E, 0,  0x60, 0,
> -       0xf2, 0x48,   0, 0x40, 0xf2, 0x80,              /* 0x40=Force full-duplex */
> +       0xf2, 0x48,   0, 0x40, 0xfa, 0x80,              /* 0x40=Force full-duplex */
>          0x3f, 0x05, };
>   static const char i82558_config_cmd[CONFIG_DATA_SIZE] = {
>          22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=Use MII  0=Use AUI */
>          0, 0x2E, 0,  0x60, 0x08, 0x88,
> -       0x68, 0, 0x40, 0xf2, 0x84,              /* Disable FC */
> +       0x68, 0, 0x40, 0xfa, 0x84,              /* Disable FC */
>          0x31, 0x05, };

hmmm. hmmm. hmmm.

I am sorely tempted to drop this patch, simply because it's changing one
magic number to another.  One key question I have is, what the fsck does
this patch really do???  If it turns on VLAN [de-]tagging
unconditionally, for example, that's unacceptable.

Comments and insight requested, and appreciated.

	Jeff


-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
