Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUIAOad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUIAOad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 10:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUIAOad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 10:30:33 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:43235 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266717AbUIAOac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 10:30:32 -0400
Message-ID: <9ac707cb0409010730f676abb@mail.gmail.com>
Date: Wed, 1 Sep 2004 10:30:31 -0400
From: Peter Jones <pmjones@gmail.com>
Reply-To: Peter Jones <pmjones@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CD-ripping using ioctl() does not work when DMA is disabled (ide-cd)
Cc: Johan Billing <billing@df.lth.se>
In-Reply-To: <41338487.2050007@df.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41338487.2050007@df.lth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 21:48:23 +0200, Johan Billing <billing@df.lth.se> wrote:
> So in conclusion, this seems to be a problem that only occurs when
> reading multiple frames using ioctl() with DMA off. I hope that this
> will help find and fix the problem.

The simple fix, of course, is to not use cooked ioctl mode :)

This seems like a good time to mention that I've got a version
modified to use SG_IO, which can be found at
http://people.redhat.com/pjones/cdparanoia/ .  It still needs plenty
of testing before I merge any of that code in the main tree, though.

(Sorry about the double-reply, Johan, but I didn't want to leave you
off of the copy to l-k, even after I messed up on the first one)
