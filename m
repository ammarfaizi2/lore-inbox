Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVCUAMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVCUAMd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVCUAMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:12:33 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:32487 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261380AbVCUAMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:12:31 -0500
Subject: Re: Suspend-to-disk woes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Russell Miller <rmiller@duskglow.com>, erik.andren@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050319212922.GA1835@elf.ucw.cz>
References: <423B01A3.8090501@gmail.com>
	 <20050319132612.GA1504@openzaurus.ucw.cz>
	 <200503191220.35207.rmiller@duskglow.com>
	 <20050319212922.GA1835@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 21 Mar 2005 11:14:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2005-03-20 at 08:29, Pavel Machek wrote:
> On So 19-03-05 12:20:35, Russell Miller wrote:
> > On Saturday 19 March 2005 05:26, Pavel Machek wrote:
> > 
> > > Checking that would be hard, but you might want to provide patch to check
> > > last-mounted dates of filesystems and panic if they changed.
> > > 				Pavel
> > 
> > Then how would you fix it?  There'd also have to be a way to reset it, 
> 
> boot with "noresume", then mkswap.

Yuck! Why panic when you know what is needed? A better solution is to
tell the user they've messed up and given them the option to (1) reboot
and try another kernel or (2) have swsusp restore the original swap
signature and continue booting. This is what suspend2 does (with a
timeout for the prompt). It's not that hard.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

