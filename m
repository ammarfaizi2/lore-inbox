Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVKQN5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVKQN5q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVKQN5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:57:46 -0500
Received: from 90.Red-213-97-199.staticIP.rima-tde.net ([213.97.199.90]:30299
	"HELO fargo") by vger.kernel.org with SMTP id S1750827AbVKQN5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:57:46 -0500
Date: Thu, 17 Nov 2005 14:57:31 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: /net/sched/Kconfig broken
Message-ID: <20051117135731.GA11238@fargo>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20051116194414.GA14953@fargo> <20051116.115141.33136176.davem@davemloft.net> <20051116201020.GA15113@fargo> <20051116231650.GR5735@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051116231650.GR5735@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Nov 17 at 12:16:50, Adrian Bunk wrote:
> > Sorry for not giving more details. I'm using make menuconfig
> > in a 2.6.14 kernel After selecting CONFIG_NET_SCHED and CONFIG_NET_CLS_BASIC
> > i don't see new options, the last option visible is NET_CLS_ROUTE4.
> 
> And if you select NET_CLS_ROUTE4, this should automatically select 
> NET_CLS_ROUTE.
> 
> Are you saying that after enabling NET_CLS_ROUTE4, the option 
> NET_CLS_ROUTE is not set in your .config?

No, the option is set. But the changes are not visible in make menuconfig, that
is, i cannot select options that depend on NET_CLS_ROUTE.

I found out that if i select NET_CLS_ROUTE4, save my changes and exit
menuconfig, execute again make menuconfig and go to QoS options, then the new
available options are visible. So menuconfig has some problem refreshing
contents :?

thanks,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
