Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269502AbUICA7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269502AbUICA7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUICA71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:59:27 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:3043 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S269503AbUICA6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:58:36 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] RE: [PATCH] Early USB handoff
Date: Thu, 2 Sep 2004 16:44:51 -0700
User-Agent: KMail/1.6.2
Cc: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Pete Zaitcev" <zaitcev@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <5F106036E3D97448B673ED7AA8B2B6B3016ADED2@scl-exch2k.phoenix.com>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B3016ADED2@scl-exch2k.phoenix.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021644.51961.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 1:26 pm, Aleksey Gorelov wrote:

>   While still in real mode, BIOS takes care of interrupts from 
> devices. But once OS takes control over and goes to protected 
> mode, there is no easy way for BIOS to detect that and disable HC.

I find myself a bit unsettled at the notion of not really being
able to blame this behavior on BIOS bugs.  What's the world
coming to any more?!


> So, one should either avoid 'sharing' it with other devices (at
> IRQ routing stage), or reprogram HC in native OS mode first (at 
> least disable interrupts).

That sounds like it could explain lots of the init/irq problems we've
had on various systems.  Makes me a lot more interested in seeing
this fix go in ... :)

For backwards compatibility, the early reset should not be the
default.  There aren't many systems where it's a problem.

- Dave
