Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEPmf>; Fri, 5 Jan 2001 10:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRAEPm0>; Fri, 5 Jan 2001 10:42:26 -0500
Received: from mail.zmailer.org ([194.252.70.162]:29452 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129183AbRAEPmM>;
	Fri, 5 Jan 2001 10:42:12 -0500
Date: Fri, 5 Jan 2001 17:42:05 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Nicolas Parpandet <nparpand@perinfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel network problem ?
Message-ID: <20010105174205.Q12545@mea-ext.zmailer.org>
In-Reply-To: <000d01c07724$8fa531f0$8900030a@nicolasp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01c07724$8fa531f0$8900030a@nicolasp>; from nparpand@perinfo.com on Fri, Jan 05, 2001 at 03:34:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 03:34:07PM +0100, Nicolas Parpandet wrote:
> Hi all,
> 
> I'm testing 2.4 series for few weeks,
> even the last prerelease
> 
> I've seen stranges things  :
> 
> I cannot access to some ips adresses ! :
> in http or in smtp using "konqueror", "netscape",
> "mail",  "telnet 25".


	Turn off the TCP_ECN option from your configuration,
	or do:
		echo 0 > /proc/sys/net/ipv4/tcp_ecn 
	(as root)

	For foreseeable future, the world will be full of firewalls
	doing wrong thing when they see TCP ECN bits in TCP header's
	formerly "reserved, set to zero" bits.

> Nicolas.

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
