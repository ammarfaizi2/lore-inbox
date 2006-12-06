Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760678AbWLFO7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760678AbWLFO7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760680AbWLFO7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:59:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:38465 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681AbWLFO7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:59:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rJlx87vtK2ZxgJ4otsVJl8jBdt5c0jEqnDRQXELXuU5nfz4uOdK16AyEh4vAA8oHcxS9gwPL8635OFKxjv8v8EFUkkUfka4bSZJgQuxe+OqTIRGaVW1OrfL+9b+e2HZdHhnxDGXtHVFwahZr+1wAS+wXv3knPV1eD0K6smkF1CE=
Message-ID: <d120d5000612060659s575f4f0ao8eda18d5aa208d1d@mail.gmail.com>
Date: Wed, 6 Dec 2006 09:59:14 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Alan J. Wylie" <alan@wylie.me.uk>
Subject: Re: can't boot : Spurious ACK with kernel 2.6.19
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17782.30913.566538.135240@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061205225316.GA2948@mail.prager.ws>
	 <17782.30913.566538.135240@wylie.me.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Alan J. Wylie <alan@wylie.me.uk> wrote:
>
> On Wed, 06 Dec 2006 00:00:13 +0100, Bernd Prager <bernd@prager.ws> said:
>
> > I'm trying to upgrade to kernel 1.6.19.  The boot process immediatly
> > locks in a loop with the message: "atkbd.c: Spurious ACK on
> > isa0060/serio0. Some program might be trying access hardware
> > directly."
>
> The above message is a result of the keyboard LEDs being flashed after
> a failed boot.
>
> See my posting
> http://lkml.org/lkml/2006/12/5/239
> with a patch to suppress these repeated messages, so you can see what
> the real problem is.
>

You actually don't need a patch - just boot with i8042.panicblink=0.
This issue (messages) is properly fixed in input tree.

-- 
Dmitry
