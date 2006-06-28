Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWF1XqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWF1XqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWF1XqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:46:18 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:51815 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751787AbWF1XqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:46:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qKiuBHEUPxJ8yyGX9uGGzs/p2Dc5Xpe+zaXfJgCdLNCnq0rkW3STtr8SsQThiX+HD3FFw7ekMaNqou6Lot2cjSpf+KsLrlEQQK1jd+z3DSA8i6e5KgZJqJ1zAv650tX5SILnLO5Zn9n8k78MStyZTGyDI3PrqkweP9ahn3zezOg=
Message-ID: <44A314B5.4030301@gmail.com>
Date: Thu, 29 Jun 2006 07:45:57 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] move MAX_NR_CONSOLES from tty.h to vt.h
References: <9e4733910606271203w4ceb6216g92f5fefee654aaf3@mail.gmail.com>	 <44A30D9D.5060804@gmail.com> <9e4733910606281639u26fbf62apbb01067a0d99c072@mail.gmail.com>
In-Reply-To: <9e4733910606281639u26fbf62apbb01067a0d99c072@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > MAX_NR_CONSOLES is more of a function of the VT layer than the TTY
>> > one. Moving this to vt.h allows all of the framebuffer drivers to
>> > remove their dependency on tty.h. Note that console drivers in
>> > video/console still depend on tty.h but fbdev drivers should not
>> > depend on the tty layer.
>>
>> In fact, none of the VT console drivers should have any dependency
>> on tty.h, only vt.c should.
>>
>> I think, the only thing needed by fbcon (and all other drivers in
>> drivers/video/console) in tty.h is fg_console. We can move that
>> to vt_kern.h instead.
> 
> Do you want to take over this patch and merge it via your tree? Do you
> want to move fg_console or do you want me to?

You can leave it to me.

Tony
