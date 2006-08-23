Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWHWEBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWHWEBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 00:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWHWEBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 00:01:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21450
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932346AbWHWEBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 00:01:37 -0400
Date: Tue, 22 Aug 2006 21:01:36 -0700 (PDT)
Message-Id: <20060822.210136.59470258.davem@davemloft.net>
To: ebrower@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: sym53c8xx PCI card broken in 2.6.18
From: David Miller <davem@davemloft.net>
In-Reply-To: <ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
References: <20060822.133901.110902970.davem@davemloft.net>
	<200608222339.43511.dj@david-web.co.uk>
	<ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric Brower" <ebrower@gmail.com>
Date: Tue, 22 Aug 2006 20:59:14 -0700

> The envctrl OOPS is definately my fault in the blind conversion of the
> driver to the OF interface-- of_find_propery() return values should be
> checked for NULL rather than relying upon a -1 value stored into lenp.
>  We can discuss this separately, since you are using an out-of-kernel
> driver.

Ok.

BTW, it is better to use "of_get_property()" if you are actually
interested in the value since it will return a void pointer to the
property value instead of a "struct property".  of_find_property() is
useful if you just want to check for existence or if you want to
modify the property value.
