Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUITLvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUITLvp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUITLvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:51:45 -0400
Received: from [195.23.16.24] ([195.23.16.24]:48266 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266304AbUITLv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:51:28 -0400
Message-ID: <414EC43B.8040507@grupopie.com>
Date: Mon, 20 Sep 2004 12:51:23 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Cc: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>	<20040920094602.GA24466@suse.de> <jeoek1xn9p.fsf@sykes.suse.de>	<20040920105409.GH5482@DervishD> <jek6upxj1a.fsf@sykes.suse.de>
In-Reply-To: <jek6upxj1a.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.11; VDF: 6.27.0.67; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> DervishD <lkml@dervishd.net> writes:
> 
> 
>>    Hi Andreas :)
>>
>> * Andreas Schwab <schwab@suse.de> dixit:
>>
>>>>- fix all broken apps that still rely on mtab. like GNU df(1)
>>>
>>>df does not rely on /etc/mtab.  It relies on getmntent.
>>
>>    Then my GNU df has any problem :???
> 
> 
> No, if any then getmntent.

I don't get this. From "man getmntent" it seems that getmntent is just a 
parser for /etc/mtab, and that you must call "setmntent" with the 
filename you want to parse.

So if you do "setmntent("/etc/mtab",...)" you're explicitly saying that 
you want getmntent to use /etc/mtab. This is just a open/read in disguise.

Am I missing something?

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
