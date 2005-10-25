Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVJYVOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVJYVOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVJYVOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:14:00 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:44420 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932384AbVJYVOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:14:00 -0400
Date: Wed, 26 Oct 2005 01:13:30 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Darren Salt <linux@youmustbejoking.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Call for PIIX4 chipset testers
Message-ID: <20051026011330.A7390@jurassic.park.msu.ru>
References: <4DBF8B37C1%linux@youmustbejoking.demon.co.uk> <Pine.LNX.4.64.0510251338420.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.64.0510251338420.10477@g5.osdl.org>; from torvalds@osdl.org on Tue, Oct 25, 2005 at 01:45:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 01:45:10PM -0700, Linus Torvalds wrote:
> So the 0xf9-0xfc thing is strictly not right, and I'll modify my code a 
> bit (probably to mark 0xf8-0xfb instead, which will be what we'd want to 
> do for anything in the non-legacy region).

Perhaps
	base &= ~(size - 1);
will be OK?

WRT 0x15e8 thing - include/sound/ad1848.h says:

/* IBM Thinkpad specific stuff */
#define AD1848_THINKPAD_CTL_PORT1		0x15e8
#define AD1848_THINKPAD_CTL_PORT2		0x15e9
#define AD1848_THINKPAD_CS4248_ENABLE_BIT	0x02

Ivan.
