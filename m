Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVAXTCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVAXTCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVAXTAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:00:38 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:62155 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261569AbVAXTAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:00:20 -0500
Date: Mon, 24 Jan 2005 22:23:02 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124222302.6f962097@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050124184111.GA9335@middle.of.nowhere>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050124175449.GK3515@stusta.de>
	<20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
	<20050124184111.GA9335@middle.of.nowhere>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 19:41:11 +0100
Jurriaan <thunder7@xs4all.nl> wrote:

> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Mon, Jan 24, 2005 at 09:43:36PM +0300
> > On Mon, 24 Jan 2005 18:54:49 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > It seems noone who reviewed the SuperIO patches noticed that there are 
> > > now two modules "scx200" in the kernel...
> > 
> > They are almost mutually exlusive(SuperIO contains more advanced), 
> > so I do not see any problem here.
> > Only one of them can be loaded in a time.
> > 
> > So what does exactly bother you?
> > 
> lsmod in bugreports giving unspecific results, for example.

If you load scx200 from superio subsystem, then obviously you can not
use old i2c/acb modules which require old scx200.
And vice versa.

One needs to load exactly what he wants.

> Kind regards,
> Jurriaan
> -- 
> "So you believe."
> Jewel ATerafin shrugged. "I have more than belief, but I don't have a
> pressing need to convince you of anything."
> 	Michelle West - Sea of Sorrows.
> Debian (Unstable) GNU/Linux 2.6.10-mm1 2x6078 bogomips load 0.52


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
