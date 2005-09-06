Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVIFDDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVIFDDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 23:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVIFDDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 23:03:34 -0400
Received: from relay4.usu.ru ([194.226.235.39]:41950 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750872AbVIFDDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 23:03:34 -0400
Message-ID: <431D07D9.1070400@ums.usu.ru>
Date: Tue, 06 Sep 2005 09:07:05 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.13-mm1 fails to build
References: <431BFF11.5010306@ums.usu.ru> <1125923034.8714.16.camel@localhost.localdomain>
In-Reply-To: <1125923034.8714.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.31.1.0; VDF: 6.31.1.212; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2005-09-05 at 14:17 +0600, Alexander E. Patrakov wrote:
>  
>
>>Hello,
>>
>>I tried to build linux-2.6.13-mm1 with the attached configuration, and 
>>it failed with:
>>
>>drivers/usb/serial/whiteheat.c: In function `rx_data_softint':
>>drivers/usb/serial/whiteheat.c:1433: error: structure has no member 
>>named `flip'
>>    
>>
>
>No that one hadn't. I'll see what I can do. Do you have hardware to test
>changes ?
>  
>
No, I just forgot to disable this driver at home :)

A similar trouble in the proprietary LT WinModem driver was fixed by 
copying the receive_chars() function from 8250.c, but in whiteheat.c the 
code looks more complicated due to spinlocks and the fact that more than 
one character can be received.

-- 
Alexander E. Patrakov
