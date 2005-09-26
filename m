Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbVIZRHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbVIZRHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbVIZRHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:07:34 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:57725 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751673AbVIZRHd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:07:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VKKQNK/pFUC42/Twuo30KSIUhJr/1CpWIz++z49YSWGbtjBlnUbqTBRq406bs7aZg5n4gxEv6YAuTyI/fY7RTbjzpnooOFXonHfv6Vz52eZQwG2jMft/NjgVRNbeTWBj1s36kSpDUU7opi1hzDsF3YnyVgNvIH/KpDwUWUMrpl0=
Message-ID: <c775eb9b050926100723a3a0bf@mail.gmail.com>
Date: Mon, 26 Sep 2005 13:07:30 -0400
From: Bharath Ramesh <krosswindz@gmail.com>
Reply-To: Bharath Ramesh <krosswindz@gmail.com>
To: Keenan Pepper <keenanpepper@gmail.com>
Subject: Re: ipw2200 only works as a module?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4338122C.9000901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4338122C.9000901@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is booting it tries to locate the ipw-2.2 firmware
which cannot be found as the filesystems are yet to be mounted. The
firmware normally resides in the /lib directory. Its always advisable
to use drivers which require firmware loading as modules so that when
you try loading the module you have your file system already mounted.

On 9/26/05, Keenan Pepper <keenanpepper@gmail.com> wrote:
> With CONFIG_IPW2200=y I get:
>
> ipw2200: ipw-2.2-boot.fw load failed: Reason -2
> ipw2200: Unable to load firmware: 0xFFFFFFFE
>
> but with CONFIG_IPW2200=m it works fine. If it doesn't work when built into the
> kernel, why even give people the option?
>
> BTW, a better error message than "Reason -2" would be nice. =)
>
> Keenan Pepper
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
