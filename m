Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVBUQxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVBUQxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVBUQxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:53:05 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:59750 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262033AbVBUQxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:53:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=M+998Z/UPabpTKi6zios4PrAEnZ+7TFog7yXTDqmiOQBZyxyamD8HWQrr5MGK8LMwfBu2XGBAZwMbrskrtiDNmBe8n34i/pY8yb/nqBV09gto90MiQ9RLM2DsNwpGBSe60oaG/dEBpEtF5+Fj2E3RrAWHBZqdxeRxWMotEYJRBU=
Message-ID: <9e47339105022108527e3c679d@mail.gmail.com>
Date: Mon, 21 Feb 2005 11:52:27 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
Cc: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
In-Reply-To: <42199DD9.10807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105022023242e2fd9ce@mail.gmail.com>
	 <42199DD9.10807@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 03:37:45 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> You either need to execute the video BIOS to initialize the hardware
> registers, or initialize the hardware registers themselves.

That is what the user mode reset program does.

The problem is, how do I get it to run before calling the device's
probe function? Most of the framebuffer drivers assume that the
hardware has already been reset in their probe code.


> 
>         Jeff
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
