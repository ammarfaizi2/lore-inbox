Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267124AbUBMQsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267125AbUBMQsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:48:54 -0500
Received: from gw-nl4.philips.com ([161.85.127.50]:43177 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP id S267124AbUBMQsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:48:21 -0500
Message-ID: <402D0083.7010606@basmevissen.nl>
Date: Fri, 13 Feb 2004 17:51:15 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shut up about the damn modules already...
References: <20040212031631.69CAD2C04B@lists.samba.org>
In-Reply-To: <20040212031631.69CAD2C04B@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> Please apply before 2.6.3.
> 
> In almost all distributions, the kernel asks for modules which don't
> exist, such as "net-pf-10" or whatever.  Changing "modprobe -q" to
> "succeed" in this case is hacky and breaks some setups, and also we
> want to know if it failed for the fallback code for old aliases in
> fs/char_dev.c, for example.
> 
> Just remove the debugging message which fill people's logs:

Yup, those messages are really annoying.

I'm wondering why it is that the kernel is asking for non-existing 
modules so often. Is it that userspace applications try to access all 
kinds of devices too often (autoprobing) or it this (wanted) kernel 
behaviour?

If it is the former, I think that applications should be fixed in the 
first place. Maybe userspace and kernel should share knowledge about 
what devices are there and supported by the kernel(modules).

In the meantime, your patch needs to go in though because fixing this in 
userspace is not something that will happen on short term.

Regards,

Bas.


