Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSIYIcc>; Wed, 25 Sep 2002 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbSIYIcc>; Wed, 25 Sep 2002 04:32:32 -0400
Received: from albireo.ucw.cz ([81.27.194.19]:24580 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S261268AbSIYIcc>;
	Wed, 25 Sep 2002 04:32:32 -0400
Date: Wed, 25 Sep 2002 10:37:46 +0200
From: Martin Mares <mj@ucw.cz>
To: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt Sharing
Message-ID: <20020925083746.GA845@ucw.cz>
References: <5F0021EEA434D511BE7300D0B7B6AB53050A4C9D@mail2.ggn.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB53050A4C9D@mail2.ggn.hcltech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> But what if two PCI Devices are sharing the same interrupt line?
> Then how does the handler handle this?
> Can you please explain this handling by the Kernel?

All drivers register their interrupt handlers by calling request_irq().
When a shared interrupt arrives, all handlers for this interrupt are
run and each of them polls the status register of the device it handles
to see whether this device needs servicing.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Why is it called "common sense" when nobody seems to have any?
