Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWGKLMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWGKLMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWGKLMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:12:09 -0400
Received: from srvr22.engin.umich.edu ([141.213.75.21]:10647 "EHLO
	srvr22.engin.umich.edu") by vger.kernel.org with ESMTP
	id S1751029AbWGKLMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:12:08 -0400
From: Matt Reuther <mreuther@umich.edu>
Organization: The Knights Who Say... Ni!
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Depmod errors on 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1
Date: Tue, 11 Jul 2006 07:20:53 -0400
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200607100833.00461.mreuther@umich.edu> <200607102327.38426.mreuther@umich.edu> <44B34BBA.4010806@gmail.com>
In-Reply-To: <44B34BBA.4010806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607110720.54119.mreuther@umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 02:56 am, Antonino A. Daplas wrote:
> Matt Reuther wrote:
> > On Monday 10 July 2006 11:58 am, Antonino A. Daplas wrote:
> >> Matt Reuther wrote:
> > I ran 'make menuconfig' and I got the same warnings. Perhaps CONFIG_FB
> > needs to be part of the 'selects' line for any option that selects the
> > backlight support. I think the USB Apple Cinema display support, which I
> > set as modular, might have selected backlight. I don't need framebuffer
> > support, so I have that shut off. Here are the depmod warnings once
> > again:
>
> Yes, that's the culprit.  I've been thinking for some time to eliminate
> the framebuffer dependency from lcd/backlight.  Can you try the patch I
> sent in another thread?
>
> Tony

OK. I will give that a shot, probably this evening.

Shouldn't kconfig recursively figure out dependencies for stuff like this?

I turned on Apple Cinema support without turning on the framebuffer, but 
Cinema needed backlight, which needed framebuffer. I can see kconfig turning 
on backlight, but not checking to see what backlight needed.

There might be similar issues with snd-miro, which seems to want stuff in 
snd_cs4231, which I think I have shut off.

Thanks for your help. I try out your patch later on today, when I can get back 
to my computer.

Matt
