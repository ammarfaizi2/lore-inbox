Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbTAHTlQ>; Wed, 8 Jan 2003 14:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267884AbTAHTlP>; Wed, 8 Jan 2003 14:41:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51719 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267883AbTAHTlM>; Wed, 8 Jan 2003 14:41:12 -0500
Message-ID: <3E1C808D.8080406@zytor.com>
Date: Wed, 08 Jan 2003 11:48:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021218
X-Accept-Language: en, sv
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: tenth post about PCI code, need help
References: <Pine.LNX.3.95.1030108143728.31888A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030108143728.31888A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On 8 Jan 2003, H. Peter Anvin wrote:
> 
> 
>>Followup to:  <Pine.LNX.3.95.1030108132812.28791A-100000@chaos.analogic.com>
>>By author:    "Richard B. Johnson" <root@chaos.analogic.com>
>>In newsgroup: linux.dev.kernel
>>
>>>The problem is that he's discovered something that's not supposed
>>>to be in the code. Only 32-bit accesses are supposed to be made to
>>>the PCI controller ports. He has discovered that somebody has made
>>>some 8-bit accesses that will not become configuration 'transactions'
>>>because they are not 32 bits.
>>>
>>
>>Right.  That's what the code is checking for.
>>
>>	-hpa
> 
> Somebody is very lucky the designer of the bus interface state-machine
> let him get away with it. This is a borderline "insane instruction" that
> could, on some (future?) machine, require a power-off to recover. This is
> NotGood(tm). It's like testing a fuse by shorting out a circuit. If it
> works, the circuit no longer works. If I doesn't, the circuit no longer
> works. Some things should not be tested.
> 

If so, we will get an bug report rather than mysterious strange
behaviour.  This is a good thing.  (Amusingly enough, exactly this code
in the Linux kernel actually found a bug in one of the very early
versions of the Transmeta northbridge.  It was fixed in firmware.)

	-hpa


