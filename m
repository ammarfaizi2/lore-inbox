Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWBMW7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWBMW7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWBMW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:59:49 -0500
Received: from webmail9.yandex.ru ([213.180.200.48]:5814 "EHLO
	webmail9.yandex.ru") by vger.kernel.org with ESMTP id S1030251AbWBMW7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:59:46 -0500
Date: Tue, 14 Feb 2006 01:59:27 +0300 (MSK)
From: =?KOI8-R?B?IvDP0tTPziD3ycvUz9Ig7NjXz9c=?= =?KOI8-R?B?yd4i?= 
	<porton@yandex.ru>
Message-Id: <43F10F4F.000002.27180@webmail9.yandex.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ]
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: MTD for buffered IO
In-Reply-To: <E1F8dq8-0000oW-N2@be1.lrz>
Reply-To: porton@yandex.ru
References: <5FIFF-2PL-39@gated-at.bofh.it> <E1F8dq8-0000oW-N2@be1.lrz>
X-Source-Ip: 195.222.130.77
X-Originating-Ip: 195.222.156.33
Content-Type: text/plain;
  charset="KOI8-R"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Victor Porton,,, <porton@ex-code.com> wrote:
> 
> > I suggest to add kernel configuration/option to allow to use
> > an MTD device as a continuation of I/O buffers (for HDD).
> 
> Why do you want to be limited to MTD devices?
> What about creating a device-mapper target using JBD instead?

Good idea, which probably already works with current Linux with ext3. But we should be not limited to JDB systems. Your idea works only with JDB, so your idea (despite of being a good idea) is a hack.

> > One way to implement it would be to add the option for a swap
> partition/file
> > to allow to use this swap partition/file as I/O buffer for other device.
> 
> -EBADIDEA. You'd certainly lose data on power failures.

How it is worse than to lose data on power failures with the standard Linux memory I/O cache?

Moreover so we can lose LESS, as Flash memory will preserve swap content unlike RAM.

> -- 
> Ich danke GMX dafØr, die Verwendung meiner Adressen mittels per SPF
> verbreiteten LØgen zu sabotieren.
> 

-- 
Victor Porton (porton@ex-code.com)
