Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269254AbUIRLGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269254AbUIRLGe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 07:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269304AbUIRLGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 07:06:34 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:56963 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269254AbUIRLGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 07:06:32 -0400
Message-ID: <414C16AD.9020303@drzeus.cx>
Date: Sat, 18 Sep 2004 13:06:21 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MMC compatibility fix - OCR mask
References: <414C0730.3020503@drzeus.cx> <20040918114310.A13733@flint.arm.linux.org.uk>
In-Reply-To: <20040918114310.A13733@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sat, Sep 18, 2004 at 12:00:16PM +0200, Pierre Ossman wrote:
>  
>
>>This patch avoids using a emtpy OCR mask for the initial power up. Since 
>>some cards do not like a one bit-mask a routine has been added which 
>>grows the mask to three bits (one extra bit on each side) if necessary.
>>    
>>
>
>As I already replied on this topic, this will not work on hosts
>which support a wide range of supplies.  If you send an OP_COND
>command with bits set outside the MMC cards allowable range, they
>go gaga.
>
>  
>
Sorry, my bad. I was reviewing the previous discussion about this in an 
attempt to find a solution. Completely missed that case. Please 
disregard this patch then.

The problem still remains though. Do you know what the wide range 
controller you have send when used with the manufacturer's driver?

Rgds
Pierre

