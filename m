Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263572AbUJ3BiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbUJ3BiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUJ2Th5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:37:57 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12168 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261300AbUJ2SuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:50:21 -0400
References: <1099044244.9566.0.camel@localhost>
            <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: davem@davemloft.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: net: generic netdev_ioaddr
Date: Fri, 29 Oct 2004 21:50:20 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.418290EC.00002E85@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Al Viro writes:
> NAK.  ->base_addr casting is a Bad Idea(tm) and natsemi "solution" isn't
> (thanks for spotting that crap in natsemi, though; will fix...) 
> 
> Note that there is no such thing as "generic IO base address" - it _is_
> private and in the best case current ->base_addr is a scratch register
> probably used for something vaguely connected with some IO, but it's
> really up to driver...

Yup, I thought about that after I sent the patch. However, as it stands now, 
many network drivers use netdev->base_addr for just that.  Perhaps it should 
be nuked completely instead? 

            Pekka 

