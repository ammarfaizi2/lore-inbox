Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSDXQos>; Wed, 24 Apr 2002 12:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDXQor>; Wed, 24 Apr 2002 12:44:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28292 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312357AbSDXQoq>;
	Wed, 24 Apr 2002 12:44:46 -0400
Date: Wed, 24 Apr 2002 09:35:15 -0700 (PDT)
Message-Id: <20020424.093515.82125943.davem@redhat.com>
To: jd@epcnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: AW: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <527944032.avixxmail@nexxnet.epcnet.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jd@epcnet.de
   Date: Wed, 24 Apr 2002 18:23:35 +0200
   
   Ok. But why isn't there a "tag" (capabilities?) on the drivers
   which let vconfig barf with a message like "underlying network
   driver or hardware doesn't support VLAN"?

There actually is a flag the driver can set fo this purpose.

Someone should walk over all the drivers that are known to not
work currently with VLAN and for them to set the
NETIF_F_VLAN_CHALLENGED flag.

Another idea, is to do the opposite, set that flag by default and
clear it in drivers that we know it works.


