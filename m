Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUH0TWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUH0TWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUH0TSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:18:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9098 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267505AbUH0TRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:17:04 -0400
Message-ID: <412F88A4.70408@pobox.com>
Date: Fri, 27 Aug 2004 15:16:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Peck <coderman@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: faster via/centaur hw rng throughput patch for 2.6.8.1
References: <4ef5fec604082711523b3935f9@mail.gmail.com>
In-Reply-To: <4ef5fec604082711523b3935f9@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peck wrote:
> - use of cpu_has_xstore replaced with model / stepping
>   checks to determine C5XL/C5P/C5J/* capability.  there
>   is a problem with first generation C5XL boards (with
>   stepping 0 IIRC) that do not report xstore but do
>   have a functional hardware rng device.  the stepping
>   check also distinguishes the single entropy C5XL from
>   the dual entropy C5P+.


Oh, and this change is going in the wrong direction.

You should instead modify arch/i386/kernel/cpu/centaur.c with code that 
does something like

if (!xstore feature bit reported)
	check stepping and see if it's there anyway

Regards,

	Jeff


