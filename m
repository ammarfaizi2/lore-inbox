Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269454AbUIRLbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269454AbUIRLbb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 07:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269432AbUIRLa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 07:30:56 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:64643 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269366AbUIRLav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 07:30:51 -0400
Message-ID: <414C1C60.6010607@drzeus.cx>
Date: Sat, 18 Sep 2004 13:30:40 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MMC compatibility fix - OCR mask
References: <414C0730.3020503@drzeus.cx> <20040918114310.A13733@flint.arm.linux.org.uk> <414C16AD.9020303@drzeus.cx> <20040918122130.A17085@flint.arm.linux.org.uk>
In-Reply-To: <20040918122130.A17085@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sat, Sep 18, 2004 at 01:06:21PM +0200, Pierre Ossman wrote:
>  
>
>>The problem still remains though. Do you know what the wide range 
>>controller you have send when used with the manufacturer's driver?
>>    
>>
>
>There isn't a manufacturers driver for it.
>
>  
>
Since I'm a bit keen on actually being able to read the cards I already 
own I have another suggestion. Start out using a zero OCR. If no card 
responds using this we try again using the bit mask created in this 
patch. That would get compliant cards using the first go and the rest 
using the second. If someone tries to combine faulty cards with good 
ones on the same bus the faulty ones will of course not work but at 
least people have the chance of getting them to work when inserted by 
themselves.

Does this sound like a solution that would work? I'd be happy to write 
the code and test it with the cards I have at my disposal.

Rgds
Pierre

