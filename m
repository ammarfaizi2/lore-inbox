Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWHPWyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWHPWyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHPWyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:54:41 -0400
Received: from rtr.ca ([64.26.128.89]:29593 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932314AbWHPWyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:54:40 -0400
Message-ID: <44E3A22F.20400@rtr.ca>
Date: Wed, 16 Aug 2006 18:54:39 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: What determines which interrupts are shared under Linux?
References: <44E1D760.6070600@atipa.com>	 <1155654379.24077.286.camel@localhost.localdomain>	 <44E1E719.6020005@atipa.com> <1155657316.24077.293.camel@localhost.localdomain> <44E208AD.8060505@atipa.com>
In-Reply-To: <44E208AD.8060505@atipa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Heflin wrote:
>
> It looks like the older DMA recovery code never works on this chipset,
> once it goes into DMA recovery it never comes out of it.    I am looking
> at that to see if anything can be done about it.

You could try booting with ide2=serialize as a kernel parameter.
That should ensure the two channels are never in use simultaneously.
Trades off a bit of performance for a bit of reliability.

Cheers
