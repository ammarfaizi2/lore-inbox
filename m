Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVJaQNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVJaQNQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJaQNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:13:16 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:21648 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932392AbVJaQNP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:13:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n5Og7TgXFn287vDMIlBSSo7fW7kvfMWfRuR+RNoFJjFYkVLdv50gJ1qk6DdcN7IQ44NjfGz8/AIw1Uhi/jFYfBPhgNc38wH8ahgzTvvAqWoHT6r3sZF4yr8GbiNMsdg9mk1ipjUXD2IMoXTCXfxNuAQX/37NQFAi4aGl15c1LDc=
Message-ID: <2c0942db0510310813p452b20b1q927e20376cd80ae0@mail.gmail.com>
Date: Mon, 31 Oct 2005 08:13:12 -0800
From: Ray Lee <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: patrizio.bassi@gmail.com
Subject: Re: [BUG 2579] linux 2.6.* sound problems
Cc: "Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <436638A8.3000604@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436638A8.3000604@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
> starting from 2.6.0 (2 years ago) i have the following bug.

Well, the problem probably started before then.

> link: http://bugzilla.kernel.org/show_bug.cgi?id=2579

> Please fix that...2 years' bug!

Speaking as a programmer, that's not a lot to go off of to find the
bug. I think everyone would agree it's a bug, but we'll need more help
from you.

> fast summary:
> when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
> file) i hear noises, related to disk activity. more hd is used, more chicks
> and ZZZZ noises happen.

Does hdparm -i (or -I) show differences between the 2.4 kernels and
2.6? 2.6 has new IDE drivers, and so perhaps your system isn't using
the best driver any more.

You may also want to compare lspci -vv of your IDE controller and
sound card between 2.4 and 2.6, and see if there are any differences.

No guarantees, but this is where you'd start.

> Ready to test any patch/solution.

Try that. If nothing obvious appears in the examination, you may want
to try the 2.6.14-rt1 patchset from Ingo Molnar. It's designed to
reduce latency in the kernel, but also has a latency tracer that may
be particularly useful for your problem. (Assuming it's a latency
issue, and not a hardware misconfiguration due to 2.6 doing something
wrong.)

Ray
