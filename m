Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWIBKjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWIBKjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 06:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWIBKjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 06:39:09 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:64104 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750813AbWIBKjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 06:39:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=LZ80Gy5TBbrLNFPfHGgHCU1m/+OyLXW46EG21ayyjLdE04GZIPNeqNtp8BqgqToh/68tfsFxwowbgpzxe56fnOIjrvkRTVNjeBbgShU9bI5JbWTubqMVCtjz0kopKi1zz7np114LlNGEf1tGzy5YFFjJCsPURIhYRS7R1dHrLeg=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] mcs7830: fix reception of 1514 byte frames
Date: Sat, 2 Sep 2006 03:33:01 -0700
User-Agent: KMail/1.7.1
Cc: Arnd Bergmann <arnd@arndb.de>, David Hollis <dhollis@davehollis.com>,
       support@moschip.com, dbrownell@users.sourceforge.net,
       linux-kernel@vger.kernel.org, Michael Helmling <supermihi@web.de>
References: <200608071500.55903.arnd.bergmann@de.ibm.com> <200608272241.05026.arnd@arndb.de> <200608272241.54161.arnd@arndb.de>
In-Reply-To: <200608272241.54161.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609020333.02285.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 1:41 pm, Arnd Bergmann wrote:
> The mcs7830 chip always appends a byte with status information
> to an rx frame, so the URB needs to reserve an extra byte.

Shouldn't you add VLAN_HLEN too, in case 802.1q is in use?

I'm not entirely sure how that's expected to work myself...
