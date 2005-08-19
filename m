Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVHSFy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVHSFy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 01:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVHSFyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 01:54:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:12507 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932561AbVHSFyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 01:54:54 -0400
Message-ID: <43057421.5090306@pobox.com>
Date: Fri, 19 Aug 2005 01:54:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com> <430570B5.60109@gmail.com>
In-Reply-To: <430570B5.60109@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  Heh... Maybe I'm just reluctant to let go of my patches.  Anyways, I'll 
> now stand down and see how things go and try to help.


Note that my email simply describes a long term target.  For the short 
term, and perhaps medium term, libata will continue to use 
->eh_strategy_handler().

Given Mark's messages, my own knowledge, and other reports, there 
continues to be room for improvement in the current EH code.

In general, we need to distinguish between PCI bus errors, SATA bus 
errors, and ATA device errors, and handle each error class 
appropriately.  In the SCSI layer, ->eh_strategy_handler() or no, this 
will likely consist of taking the SCSI device offline and dealing with 
the error(s).

	Jeff


