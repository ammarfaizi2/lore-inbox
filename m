Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVC3R4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVC3R4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVC3R4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:56:55 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:30740 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262363AbVC3R4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:56:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:organization:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AZU5n0N8iwk1Tb6ro2f+On/ezOIEguhfYYO9gUHfgqbkOcI7QI0PuQf3k4Ynp/4pKxHCHJMaO1cQgjJJ8VmCufAvRu5wKV8rK7UEU6DtsQD7xlylHga/HbG1nv6WvOSPsWVt/VL7fplQNc4ytrFypgbBdKHRyQp5KsJBZGUEpvc=
From: Vicente Feito <vicente.feito@gmail.com>
To: linux-os@analogic.com
Subject: Re: How to debug kernel before there is no printk mechanism?
Date: Wed, 30 Mar 2005 14:54:41 +0000
User-Agent: KMail/1.7.1
Cc: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <424AD247.4080409@globaledgesoft.com> <Pine.LNX.4.61.0503301134240.28049@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503301134240.28049@chaos.analogic.com>
Organization: none
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301454.41322.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Video memory is at b800:0000, for humans 0x0000b800, not at 0x000b8000


On Wednesday 30 March 2005 04:47 pm, linux-os wrote:
> On Wed, 30 Mar 2005, krishna wrote:
> > Hi all,
> >
> > How can one debug kernel before there is no printk mechanism in kernel.
> >
> > Regards,
> > Krishna Chaitanya
>
> Write directly to screen memory at 0x000b8000, or write to the
> RS-232C UART while polling the TX buf empty bit, or just write
> bits that mean something to you out the printer port.
>
> Screen - memory is 16-bit words with the high-word being
> an attibute byte. FYI 0x07 is a good B&W byte. You can
> initialize a pointer to it as:
>
> unsigned short *screen = 0xc00b8000; Since low memory
> is always mapped, the above cheat will work. The 0xc0000000
> is PAGE_OFFSET.
>
> An early '486 was brought up into a 32-bit protected-mode
> (non linux) operating system using these debugging methods.
> The first time I got to see some symbol written to the
> screen in protected-mode marked the start of a week-end-
> long party. Have fun!
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by Dictator Bush.
>                   98.36% of all statistics are fiction.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
