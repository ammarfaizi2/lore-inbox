Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWBCMrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWBCMrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWBCMrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:47:12 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:7310 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750736AbWBCMrL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:47:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iSmn6UyzD0zsg6gJTnA/AXHg4hI2pm2J1//0kfE695SeKO9aUCrKSYUfz1D8/ABiz2Y4LuRId7hqCqXwK54giR4E/Y+mMPgyHJfMRdMnRTwQJatZ5A4YwwmkvhWnjfWkOdmVPlP6nWi9O8cYUuWof4ilHE9itjicor3ZKOghfo0=
Message-ID: <84144f020602030447m20c69ddeg5b2499287b2ae1f4@mail.gmail.com>
Date: Fri, 3 Feb 2006 14:47:09 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.15.2 / uml] Compile error
In-Reply-To: <20060203123708.GF6460@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060203123708.GF6460@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> When I try to compile 2.6.15.2 with ARCH=um and I did before
> "make clean" and "make ARCH=um menuconfig", it aborts due to
> this error:
>
> include/linux/jiffies.h:39:7: warning: "CONFIG_HZ" is not defined
> include/linux/jiffies.h:42:3: error: #error You lose.
>
> This repeats many many times.

You forgot to do make mrproper. The include/asm symlink is pointing to
the wrong architecture.

                                      Pekka
