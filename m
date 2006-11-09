Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161830AbWKIUOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161830AbWKIUOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161831AbWKIUOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:14:36 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:693 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161830AbWKIUOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:14:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fRqZXQeMmWHfi7BzcXD6K9vwFFwNhbvS9HUcC+iyH5Bj1tIC/+iC6yo7wLlbGIT+SpFd6pubjgDvertNhnNJWZb5AZ8MIWEOinhg/5240AORJwm3NksXUshGP/WVKtGABrC1lkNnsZdXt06zMZUrB0NI/EjMg1itlFb+av/bCkM=
Message-ID: <806dafc20611091213x2a82c5ccs814ceabbf11e2363@mail.gmail.com>
Date: Thu, 9 Nov 2006 15:13:19 -0500
From: "Monty Montgomery" <monty@xiph.org>
To: "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Cc: "Tejun Heo" <htejun@gmail.com>, "Brice Goglin" <Brice.Goglin@ens-lyon.org>,
       "Jens Axboe" <jens.axboe@oracle.com>,
       "Gregor Jasny" <gjasny@googlemail.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, "Douglas Gilbert" <dougg@torque.net>
In-Reply-To: <455337B8.5000902@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
	 <20061030114503.GW4563@kernel.dk>
	 <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com>
	 <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org>
	 <45533468.1060400@gmail.com> <455337B8.5000902@pobox.com>
X-Google-Sender-Auth: 02743234e9729aa3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Jeff Garzik <jgarzik@pobox.com> wrote:

> Mapping 'bidirectional' is a bit difficult.

SGIO_TO_FROM_DEVICE is *not* bdirectional!

>From the header that defines it:

#define SG_DXFER_TO_FROM_DEV -4 /* treated like SG_DXFER_FROM_DEV with the
                                   additional property than during indirect
                                   IO the user buffer is copied into the
                                   kernel buffers before the transfer */

That's pretty darned clear.  TO_FROM_DEVICE is a straight-up read.
Why the continuing confusion of what this mode is for?

> Given that there are stupid apps/libs out there in the field with this
> behavior, even if the apps are fixed I think we are stuck with the
> stupidities.

*ahem*

Monty
