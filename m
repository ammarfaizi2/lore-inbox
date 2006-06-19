Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWFSIdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWFSIdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWFSIdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:33:17 -0400
Received: from 189.Red-80-39-87.staticIP.rima-tde.net ([80.39.87.189]:20866
	"EHLO iquis.com") by vger.kernel.org with ESMTP id S932326AbWFSIdQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:33:16 -0400
Message-ID: <449660E1.30505@iquis.com>
Date: Mon, 19 Jun 2006 10:31:29 +0200
From: juampe <juampe@iquis.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: juampe <juampe@iquis.com>
CC: Duncan Sands <baldrick@free.fr>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] USBATM: shutdown open connections when disconnected
References: <OF39174CF7.B508FCBD-ONC125718F.00407FFC-C125718F.00413F4F@telefonica.es> <44965CC3.1060203@iquis.com>
In-Reply-To: <44965CC3.1060203@iquis.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

juampe wrote:
>> This patch causes vcc_release_async to be applied to any *open
>> ** v*cc's when the modem is *disconnected*. 
>>     
>
>
>   
>> Unfortunately this patch may create problems
>> for those rare users like me who use routed IP or some other
>> non-ppp connection method that goes via the ATM ARP daemon: the
>> daemon is buggy, and with this patch will crash when the modem
>> is *disconnected*.  Users with a buggy atmarpd can simply restart
>> it after disconnecting the modem.
>>     
>
> First i must thanks all effort in usbatm development.
> IMHO New fatures to a driver that works well and can block the use, 
> especially if it can disable internet access and the problem is know,
> MUST be disabled by default or provide a mechanism to disable it.
>
> I'm a rare user with routed IP and this patch blocks the normal use of internet
> I dont understand how this patch can be accepted for a stable release without 
> any kind of disable mechanism.
>
> Yeah, i know that atmarp is buggy, but before speedtouch driver and atm works well during months.
>
> Best Regards.
> Juampe.
>
>
>   
I really sorry, this is a patch to 2.6.16 and this kernel version works
well the speedtouch driver.
I have problems with 2.6.17 and the speedtocuh driver block the
conection at some point that  i can't locate.

wave:~# atmdiag
Itf       TX_okay   TX_err    RX_okay   RX_err    RX_drop
  0 AAL0         0         0         0         0         0
    AAL5    266537         0    198023         1         0

RX cells don't increment, AFAIK the driver don't manage incoming ATM cells

How i can dig more into this issue in order to extract  relevant
information for a bug report?.

Best Regards
Juampe.

