Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266161AbUGZXLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUGZXLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUGZXLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:11:49 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:55786 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266161AbUGZXC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:02:57 -0400
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <20040725173652.274dcac6.akpm@osdl.org> <cone.1090802581.972906.20693.502@pc.kolivas.org> <20040726202946.GD26075@ca-server1.us.oracle.com> <20040726134258.37531648.akpm@osdl.org>
Message-ID: <cone.1090882721.156452.20693.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Date: Tue, 27 Jul 2004 08:58:41 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Joel Becker <Joel.Becker@oracle.com> wrote:
>>
>> On Mon, Jul 26, 2004 at 10:43:01AM +1000, Con Kolivas wrote:
>> > Low memory boxes and ones that are heavily laden with applications find 
>> > that ends up making things slow down trying to keep all applications in 
>> > physical ram.
>> 
>> 	Lowish memory boxes with plain desktop loads find that the default
>> of '60' is a terrible one (I'm speaking of 1GHz-ish machines with 256MB
>> (like mine) or 512MB (like a guy next to me)).  Every person I know who
>> installs 2.6 complains about how it feels slow and choppy.  I tell them
>> "The first thing I do after installing 2.6 is set swappiness to '20'."
>> Sure enough, they set swappiness to 20 and their box starts behaving
>> like a properly tuned one.
>> 	I don't know what workload the default of '60' is for, but for
>> the (128MB < x < 1GB) of RAM case, it sucks (and I've seen the same
>> behavior on a 300MHz 196MB box).
>> 
> 
> Yes, I think 60% is about right for a 512-768M box.  Too high for the
> smaller machines, too low for the larger ones.

Sigh.. 

I have a 1Gb desktop machine that refuses to keep my applications in ram 
overnight if I have a swappiness higher than the default so I think lots of 
desktop users with more ram will be unhappy with higher settings.

> More intelligent selection of the initial value is needed.

Perhaps, but I really doubt desktop users running mainline would be happy 
about it going significantly higher. 

Cheers,
Con

