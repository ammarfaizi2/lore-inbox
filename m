Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269142AbUJKSBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269142AbUJKSBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269160AbUJKSBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:01:43 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:4038 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269142AbUJKSBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:01:42 -0400
Message-ID: <416ACA91.6040405@drzeus.cx>
Date: Mon, 11 Oct 2004 20:01:53 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: MMC performance
References: <416A68E5.6080608@drzeus.cx>	 <20041011131919.B19175@flint.arm.linux.org.uk> <1097500722.31259.17.camel@localhost.localdomain> <416AA670.6040109@drzeus.cx>
In-Reply-To: <416AA670.6040109@drzeus.cx>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Alan Cox wrote:
> 
>> Only on retries. You can try and blast the lot out the first time then
>> on retries you write sector by sector.
>>
>>  
>>
> Something like this? Gives more than double throughput here.
> 
> 

*sigh*

I'm starting to think there is a special place in hell reserved for the 
folks at SimpleTech. This card has been giving me all kinds of trouble 
and this patch adds another one. It seems the card completely screws up 
multiple block writes. As little as two blocks at a time causes corrupt 
data on the card.

I've been digging through the specs I have to find some way of detecting 
cards like these but I haven't had any success. Hopefully there aren't 
too many of these out there. If the choice comes down to high speed or 
supporting non-compliant cards, then my vote is for speed.

--
Pierre
