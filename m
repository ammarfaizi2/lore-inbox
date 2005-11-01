Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVKAFVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVKAFVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVKAFVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:21:32 -0500
Received: from 10.ctyme.com ([69.50.231.10]:22148 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S932371AbVKAFVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:21:31 -0500
Message-ID: <56702.69.50.231.10.1130822490.squirrel@mail.ctyme.com>
In-Reply-To: <20051030002737.GB3423@mea-ext.zmailer.org>
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
    <p73slum38rw.fsf@verdi.suse.de>
    <20051030002737.GB3423@mea-ext.zmailer.org>
Date: Mon, 31 Oct 2005 21:21:30 -0800 (PST)
Subject: Re: PCI-DMA: high address but no IOMMU - nForce4
From: "Marc Perkel" <marc@perkel.com>
To: "Matti Aarnio" <matti.aarnio@zmailer.org>
Cc: "Andi Kleen" <ak@suse.de>, "Michael Madore" <michael.madore@gmail.com>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20050812.1.fc4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Oct 28, 2005 at 12:16:51AM +0200, Andi Kleen wrote:
>
> I will attach my own;  A brand new Amd64 dual-core thing.
> Works fine with  mem=2500M,  but blows up with  mem=3G  or
> without any override and full 4G complement in use.
>
> This board (ASUS A8N-SLI) does use NVIDIA nForce4 chipset with
> bios-option to map (hoist) "excess memory" out from first 4G to
> higher physical addresses so that it can be accessed by the
> processor.
>
> This board has no AGP at all in it, but it does have lots
> of PCIE, and a bit of PCI-X thrown in for "legacy cards".
> Somehow that detail breaks things when the machine really
> should use bounce-buffering, or something similar -- I don't
> know if Nvidia  nForce4 chipset does have IOMMU, though...
>
> If Nvidia did omit such essential piece of hardware from
> a modern chipset, I do find it amazingly short-sighted...
> (Of course they don't yield documentation of the chips to
> public so that I can't quickly verify this detail...)


For what it's worth I have almost the exact same hardware and got the same
error. Athlon X2 4400 with the same ASUS board. Reverting to 2.6.13.2
kernel works.

