Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSJUJS6>; Mon, 21 Oct 2002 05:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSJUJS6>; Mon, 21 Oct 2002 05:18:58 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:16105 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261287AbSJUJS5>; Mon, 21 Oct 2002 05:18:57 -0400
Message-ID: <3DB3C6A7.5040007@oracle.com>
Date: Mon, 21 Oct 2002 11:19:35 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020918
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.5.42: IrDA issues
References: <7034136.1034515639605.JavaMail.nobody@web11.us.oracle.com> <20021014173421.GC10672@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Sun, Oct 13, 2002 at 05:27:19AM -0800, ALESSANDRO.SUARDI wrote:
> 
>>I have a PPP over IrDA connection to my Nokia phone; under 2.4.20-preX I have no
>> problem keeping the link up, while in 2.5.4x it fails in a very short time like this:
>>
>>Oct 13 01:13:13 dolphin kernel: IrLAP, no activity on link!
>>Oct 13 01:13:11 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
>>Oct 13 01:13:11 dolphin kernel: irda0: transmit timed out
>>Oct 13 01:13:13 dolphin kernel: IrLAP, no activity on link!
>>Oct 13 01:13:13 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
>>Oct 13 01:13:13 dolphin kernel: irda0: transmit timed out
>>Oct 13 01:13:13 dolphin pppd[5378]: Modem hangup
>>Oct 13 01:13:13 dolphin pppd[5378]: Connection terminated.
>>Oct 13 01:13:13 dolphin pppd[5378]: Connect time 1.8 minutes.
>>Oct 13 01:13:13 dolphin pppd[5378]: Sent 19541 bytes, received 35933 bytes.
>>Oct 13 01:13:13 dolphin pppd[5378]: Exit.
>>
>>I also get the transmit timed out spam (why one with WATCHDOG and one without ?)
>> in 2.4.20-pre but the IrLAP line isn't there. And the GPRS link stays up...
>>
>>
>>Thanks in advance for any insight,
>>
>>--alessandro
> 
> 
> 	Please do yourself a favor and give me a proper bug report,
> including hardware, driver and irdadump.
> 

Will provide irdadump stuff soon[-ish], I'm wading through a backlog
  of, uhm, too much email. The short-form report really meant "is this
  a known issue ?"...

Anyway - the box is a Dell Latitude CPx750J with this:

[root@dolphin root]# findchip -v
Found SMC FDC37N958FR Controller at 0x3f0, DevID=0x01, Rev. 1
     SIR Base 0x3e8, FIR Base 0x290
     IRQ = 4, DMA = 3
     Enabled: yes, Suspended: no
     UART compatible: yes
     Half duplex delay = 3 us

So clearly I'm using smc-ircc.o.

(Of course I'll try and reproduce in 2.5.44 tonight or tomorrow).


Thanks,

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

