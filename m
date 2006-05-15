Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWEOOd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWEOOd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWEOOd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:33:26 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:6598 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964946AbWEOOd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:33:26 -0400
Message-ID: <446890F0.3020408@ru.mvista.com>
Date: Mon, 15 May 2006 18:32:16 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
 interfaces
References: <20051112165548.GB28987@flint.arm.linux.org.uk> <1131818615.18258.6.camel@localhost.localdomain>
In-Reply-To: <1131818615.18258.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
 > On Sad, 2005-11-12 at 16:55 +0000, Russell King wrote:
 >
 >>We must _never_ _ever_ on pain of death enable IDE DMA on SL82C105
 >>chipsets where the southbridge revision is <= 5, otherwise data
 >>corruption will occur.

 > If you are fixing this driver also set ->serialize = 1; before someone
 > with dual channel device gets burned.

    Heh, this driver also tries to cache the single PCI register per-channel 
like hpt366.c... This buglet concerns using fast PIO timings and is probably 
harmless though but needs to be fixed -- I'll send a patch soon...
    I wonder what is otherwise wrong with using 2 channels concurrently?

MBR, Sergei
