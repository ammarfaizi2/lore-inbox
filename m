Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272437AbTGZHzx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 03:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272438AbTGZHzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 03:55:53 -0400
Received: from mail.zmailer.org ([62.240.94.4]:2948 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S272437AbTGZHzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 03:55:52 -0400
Date: Sat, 26 Jul 2003 11:11:01 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] TCP and UDP implementations
Message-ID: <20030726081101.GD6898@mea-ext.zmailer.org>
References: <200307260316.02149.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307260316.02149.jeffpc@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 03:15:53AM -0400, Jeff Sipek wrote:
> Hello all,
> I noticed that there are two implementations of TCP and UDP in the kernel - 
> one for IPv4 and the other for IPv6. Correct me if I am wrong, but wouldn't 
> it be better to just have one implementation for both versions of IP? I know 
> this for sure:

The way how things are in 2.4 (I haven't looked too deeply into 2.5/2.6),
IPv6 TCP and UDP do NEED IPv4 TCP code to make most of TCP logic.
With UDP the amount of logic in kernel side is a lot simpler, and
I do think the code was in essense duplicated.

> 1) it would decrease the size of the kernel (this wouldn't be too dramatic, 
> but still)
> 
> 2) it would make maintaining of the code half the work

Because of the degree of present sharing: no.

> AFAIK there are small differences in TCP and UDP between IPv4 and IPv6,
> but they could be resolved using simple "work arounds."

IPv6's TCP is (was) just that kind of "work around" to handle differences
in IP addresses.

> Thanks,
> Jeff.

/Matti Aarnio
