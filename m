Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVLBCBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVLBCBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVLBCBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:01:09 -0500
Received: from mail.dvmed.net ([216.237.124.58]:26845 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964778AbVLBCBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:01:07 -0500
Message-ID: <438FAADC.6060907@pobox.com>
Date: Thu, 01 Dec 2005 21:01:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Ethan Chen <thanatoz@ucla.edu>, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>,
       Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com> <438D2DCC.4010805@pobox.com> <438D3AA8.9030504@gmail.com>
In-Reply-To: <438D3AA8.9030504@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > Ethan confirmed that it's 1095:3114.
	Arghhh.... Maybe we should keep > m15w quirk for 3114's for the time
	being? Better be slow than hang. > Whatever bug the m15w quirk was
	hiding. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Ethan confirmed that it's 1095:3114.  Arghhh....  Maybe we should keep 
> m15w quirk for 3114's for the time being?  Better be slow than hang. 
> Whatever bug the m15w quirk was hiding.

A generic 'slow_down_io' module option is reasonable.

It is not appropriate to apply mod15write quirk to hardware that isn't 
affected by the chip bug.

A better solution is to write a 311x-specific interrupt handler.

	Jeff


