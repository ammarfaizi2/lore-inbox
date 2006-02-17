Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWBQLxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWBQLxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWBQLxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:53:09 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:27049 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750909AbWBQLxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:53:08 -0500
Date: Fri, 17 Feb 2006 12:53:04 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: =?KOI8-R?B?IvDP0tTPziD3ycvUz9Ig7NjXz9c=?= =?KOI8-R?B?yd4i?= 
	<porton@yandex.ru>
cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: MTD for buffered IO
In-Reply-To: <43F10F4F.000002.27180@webmail9.yandex.ru>
Message-ID: <Pine.LNX.4.58.0602171250080.9291@be10.lrz>
References: <5FIFF-2PL-39@gated-at.bofh.it> <E1F8dq8-0000oW-N2@be1.lrz>
 <43F10F4F.000002.27180@webmail9.yandex.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, "?????? ?????? ???????" wrote:

> 
> 
> > Victor Porton,,, <porton@ex-code.com> wrote:
> > 
> > > I suggest to add kernel configuration/option to allow to use
> > > an MTD device as a continuation of I/O buffers (for HDD).
> > 
> > Why do you want to be limited to MTD devices?
> > What about creating a device-mapper target using JBD instead?
> 
> Good idea, which probably already works with current Linux with ext3. But we should be not limited to JDB systems. Your idea works only with JDB, so your idea (despite of being a good idea) is a hack.

NACK, my idea is "porting" the JBD function from ext3 to dm.

> > > One way to implement it would be to add the option for a swap
> > partition/file
> > > to allow to use this swap partition/file as I/O buffer for other device.
> > 
> > -EBADIDEA. You'd certainly lose data on power failures.
> 
> How it is worse than to lose data on power failures with the standard Linux memory I/O cache?

It will increase the cache and thereby the amount of in-flight data.
 
> Moreover so we can lose LESS, as Flash memory will preserve swap content unlike RAM.

I didn't asume that you suggest the cache to be preserved, since swap does 
not provide the facility. JBD obviously does have this feature, therefore 
my suggestion.
