Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWCKQVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWCKQVb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 11:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWCKQVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 11:21:31 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:26763 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751142AbWCKQVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 11:21:30 -0500
Message-ID: <4412F908.6020407@drzeus.cx>
Date: Sat, 11 Mar 2006 17:21:28 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org, ambx1@neo.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx>	 <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx>	 <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx>	 <4412F53B.5010309@drzeus.cx> <1142093721.3055.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1142093721.3055.19.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2006-03-11 at 17:05 +0100, Pierre Ossman wrote:
>   
>> Here is a patch for doing multi line modalias for PNP devices. This will
>> break udev, so that needs to be updated first.
>>     
>
>
> how could this EVER be acceptable???
>
>   

Soon I would hope. The modalias attribute currently only supports one
alias (i.e. one line). This isn't enough for PNP, so if we want to
support that bus (which I assume we do) we need to extend the interface.
udev could be updated and be backwards compatible, the kernel can not
(excluding adding another interface to the same data). So this patch
should lag the update to udev a bit (i.e. I'm not suggesting it be
applied now).

Rgds
Pierre

