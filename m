Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbVKCVlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbVKCVlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbVKCVlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:41:31 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52635
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030505AbVKCVla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:41:30 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: initramfs for /dev/console with udev?
Date: Thu, 3 Nov 2005 15:41:13 -0600
User-Agent: KMail/1.8
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20051102222030.GP23316@pengutronix.de> <200511031313.47820.rob@landley.net> <52mzkl4i8y.fsf@cisco.com>
In-Reply-To: <52mzkl4i8y.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031541.14197.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 13:57, Roland Dreier wrote:
>  > On Thursday 03 November 2005 12:51, Robert Schwebel wrote:
>  > > [...] klibc didn't compile for ARCH=um.
>  >
>  > I repeat my question: what is it that didn't compile, klibc or the
>  > kernel?
>
> come on, dude -- how much clearer can he be?

And confirming:

cd ~
tar xvjf linux-2.6.14.tar.bz2
cd linux-2.6.14
make allyesconfig
cd ~
tar xvzf klibc-1.1.tar.gz
cd klibc-1.1
ln -s ~/linux-2.6.14/include/asm-i386 include/asm
ln -s ~/linux-2.6.14/include/asm-generic/ include/asm-generic
ln -s ~/linux-2.6.14/include/linux include/linux
make  

Does indeed build klibc.

I get the strong feeling klibc-1.1 should be called klibc-2.6.14, but oh 
well...

Rob
