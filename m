Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbTFYRNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbTFYRNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:13:36 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:8975 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264763AbTFYRNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:13:20 -0400
Message-ID: <3EF9D6BA.2020104@ii.net>
Date: Thu, 26 Jun 2003 01:07:06 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird modem behaviour in 2.5.73-mm1
References: <200306242102.49356.kde@myrealbox.com> <200306250327.h5P3RwH8001577@turing-police.cc.vt.edu> <200306250418.h5P4IWdA001565@turing-police.cc.vt.edu>            <20030625091013.573f2e7b.shemminger@osdl.org> <200306251654.h5PGsUdA022467@turing-police.cc.vt.edu>
In-Reply-To: <200306251654.h5PGsUdA022467@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Wed, 25 Jun 2003 09:10:13 PDT, Stephen Hemminger said:
>
>  
>
>>How far along did pppd get before it hung up?  Was the ppp0 netdevice still
>>around (ifconfig -a)?  I'll try a dedicated serial line and see if I can reproduce
>>    
>>
>
>For me, it didn't even finish negotiating the connection:
>  
>
Same here.

>Jun 24 22:37:48 turing-police pppd[1144]: Using interface ppp0
>Jun 24 22:37:48 turing-police pppd[1144]: Connect: ppp0 <--> /dev/ttyS14
>Jun 24 22:37:49 turing-police pppd[1144]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x9ed88e38> <pcomp> <accomp>]
>Jun 24 22:37:49 turing-police pppd[1144]: Modem hangup
>Jun 24 22:37:49 turing-police pppd[1144]: Connection terminated.
>

Same message too.  I tried connecting several times with the same 
results (thought it might
have been the provider).

>I'm assuming the netdevice was there when it said 'Using interface'.  It was
>certainly gone by the time I was able to do ifconfig or 'ip link show' or
>anything like that.  ismail reports "several  minutes" - I'm wondering it the
>bug is in pskb_may_pull()  being handed an oodd packet-of-death that I receive
>during startup but ismail gets later on.  There's comments in the patch about
>making sure the decompressor is linear, but in my case the LCP stuff isn't even
>negotiating compression.  Uninitialized variable?
>
>  
>


