Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWHCPX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWHCPX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWHCPX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:23:59 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:15814 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964777AbWHCPX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:23:58 -0400
Date: Thu, 3 Aug 2006 19:23:42 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Arnd Hannemann <arnd@arndnet.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060803152342.GC14774@2ka.mipt.ru>
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru> <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru> <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 19:23:43 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 05:08:51PM +0200, Krzysztof Oledzki (olel@ans.pl) wrote:
> >then skb_alloc adds a little
> >(sizeof(struct skb_shared_info)) at the end, and this ends up
> >in 32k request just for 9k jumbo frame.
> 
> Strange, why this skb_shared_info cannon be added before first alignment? 
> And what about smaller frames like 1500, does this driver behave similar 
> (first align then add)?

e1000 aligns it to 2k, which will be transformed into 4k allocation.

> Best regards,
> 
> 				Krzysztof Olędzki


-- 
	Evgeniy Polyakov
