Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268970AbUINRkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268970AbUINRkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269497AbUINRj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:39:56 -0400
Received: from host-81-191-110-70.bluecom.no ([81.191.110.70]:47500 "EHLO
	mail.blenning.no") by vger.kernel.org with ESMTP id S269515AbUINRiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:38:18 -0400
Subject: Re: /proc/config reducing kernel image size
From: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>
To: DervishD <lkml@dervishd.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040914172646.GA614@DervishD>
References: <1095179606.11939.22.camel@host-81-191-110-70.bluecom.no>
	 <20040914172646.GA614@DervishD>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095183412.1834.7.camel@host-81-191-110-70.bluecom.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 19:36:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 19:26, DervishD wrote:
>     Hi Tom :)
> 
>  * Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no> dixit:
> > There is no point in storing all the comments and unused options in the
> > kernel image. This typically reduces the config size to about 1/5th
> > before compressing, and to about 1/4th after compressing.
> 
>     I'm with you in that there is no point in storing the comments,
> but I disagree about the unused options. Storing the unused options
> as comments is more useful than it seems ;)

This is why I added a config option.

>     Look at this example. You want to know if you have 'CONFIG_PNP'
> enabled, so you do something like 'grep CONFIG_PMP /proc/config' (the
> typo PNP->PMP is intended here). Of course that commands doesn't
> print anything due to the typo. If you store the disabled options as
> comments and a grep fails, you probably mispelled the config option,
> or you're referring to a config option not present in your old
> kernel, but if you remove them and you mispell the config option
> there is no (automatic) way of knowing if you made a typo or if the
> option is disabled. Any automatic search can, potentially, give you a
> false negative.

A small util could easily be written to do the same job, just comparing
it to the default config. Although I agree it's much easier to do a
search like this when it is in it's original form.

>     I'm not really sure about it, but I think that the unset options
> are left as comments for the sake of automation. The space saving
> doesn't (IMHO) worth the pain.

I'm not sure either, but I don't know of any programs that uses this.
Putting this config file inside the same source tree as it was compiled
with, and then just starting and stopping menuconfig will restore it to
it's original form.

> > I've also added the configuration option of how you want to compress it.
> 
>     Compression is always welcome, I suppose ;) Thanks for the idea.

Sincerely
-- 
BFG
