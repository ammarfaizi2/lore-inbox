Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312718AbSDXWbI>; Wed, 24 Apr 2002 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312772AbSDXWbH>; Wed, 24 Apr 2002 18:31:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20104 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312718AbSDXWbH>;
	Wed, 24 Apr 2002 18:31:07 -0400
Date: Wed, 24 Apr 2002 15:21:37 -0700 (PDT)
Message-Id: <20020424.152137.50299257.davem@redhat.com>
To: jd@epcnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <781920085.avixxmail@nexxnet.epcnet.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jd@epcnet.de
   Date: Thu, 25 Apr 2002 00:28:05 +0200

   Ok. I think NETIF_F_VLAN_CHALLENGED should be set if the device or
   driver can handle VLAN.

No, "challenged" means "cannot handle".  Do not invert the meaning,
the macro says what the meaning is.

To get the behavior you want, we set the flat by default and drivers
for devices which are deemed "VLAN capable" can set the bit
themselves.
