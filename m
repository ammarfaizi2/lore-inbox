Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVFWPuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVFWPuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 11:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVFWPun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 11:50:43 -0400
Received: from crl-mail-dmz.crl.hpl.hp.com ([192.58.210.9]:49853 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S262326AbVFWPuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 11:50:37 -0400
Message-ID: <42BADA42.9090908@hp.com>
Date: Thu, 23 Jun 2005 11:50:26 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dpervushin@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
References: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru>
In-Reply-To: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmitry pervushin wrote:

>Hello guys,
>
>we finally decided to rework the SPI core and now it its ready for your comments.. 
>Here we have several boards equipped with SPI bus, and use this spi core with these boards; 
>Drivers for them are available by request (...and if community approve this patch)
>
>  
>
I'm glad to see that work is progressing on SPI core.  I've worked on 
drivers on both ARM linux and Blackfin uclinux that use SPI and would 
prefer that they not be platform specific.

What I've found in my Blackfin work is that I need asynchronous SPI 
support.  The driver starts an SPI transaction and receives a callback 
when the SPI transaction has completed.  The operations are similar to 
what you've suggested, except that the message structure includes a 
pointer to a callback and a void *data pointer. 

The driver I'm working on is for the Chipcon CC2420 802.15.4 radio, 
which uses SPI to access its registers and transmit and receive FIFOs.  
In my CC2420, it queues SPI requests and initiates the next one when an 
SPI transaction completes.

Jamey

