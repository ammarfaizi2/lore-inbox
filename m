Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbULUAZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbULUAZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbULUAZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:25:06 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:43188 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261718AbULUAYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:24:51 -0500
Date: Tue, 21 Dec 2004 01:22:18 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Mark Broadbent <markb@wetlettuce.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041221002218.GA1487@electric-eye.fr.zoreil.com>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com> <20041216211024.GK2767@waste.org> <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com> <20041217215752.GP2767@waste.org> <20041217233524.GA11202@electric-eye.fr.zoreil.com> <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com> <20041220211419.GC5974@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220211419.GC5974@waste.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> :
> On Mon, Dec 20, 2004 at 09:42:08AM -0000, Mark Broadbent wrote:
> > 
> > Exactly the same happens, I still get a 'NMI Watchdog detected LOCKUP'
> > with the r8169 device using the above patch on top of 2.6.10-rc3-bk10.
> 
> Ok, that suggests a problem localized to netpoll itself. Do you have
> spinlock debugging turned on by any chance? 

Any chance of:
1 dev_queue_xmit
2 dev->xmit_lock taken
3 interruption
4 printk
5 netconsole write
6 dev->xmit_lock again
7 lockup

?

This is probably the silly question of the day.

--
Ueimor
