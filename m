Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbULUTdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbULUTdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbULUTdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:33:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9880 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261495AbULUTcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:32:20 -0500
Message-ID: <41C87A40.40308@pobox.com>
Date: Tue, 21 Dec 2004 14:32:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Marek <linux@hazard.jcu.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9: VIA sATA cannot switch to 32bit I/O?
References: <20041221144119.GA21507@hazard.jcu.cz>
In-Reply-To: <20041221144119.GA21507@hazard.jcu.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Marek wrote:
> Hallo l-k,
> 
> I have problem with my Abit AV8 MB (s939 with VIA KT800Pro chipset and
> VIA sATA controller and 120GB Seagate Barracuda disk): I cannot switch
> 32bit access to disk to on?! I'm using libata driver...
> 
> When I use hdparm -c1 /dev/sda, I've got some error message (sorry, I
> haven't this message here, it's my home computer). Therefore disk is too
> slow to putting data for burning CD's and I need 'burnfree' feature...
> 
> Please, have anyone advice for me to speedup disk access, or is it
> possible?

This will not speed up disk access.  libata uses 16-bit I/O 
unconditionally for PIO data transfers...

  ...but you are using DMA for data transfers, which is light years 
faster than PIO anyway.

	Jeff



