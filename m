Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVHNUNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVHNUNb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 16:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVHNUNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 16:13:31 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:50089 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932223AbVHNUNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 16:13:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:message-id:date:organization:content-type:mime-version:content-transfer-encoding:in-reply-to:user-agent:from;
        b=M9mVAVdSxUwDPvuqIJ1+oVlzl65N9zLerlBCjZVaRoz/tRg2RZ+kyqkJhKlJtGLzGh/AuD9AofVVGgg1xVY/3Ylo26Ye2RNyoewhQIFm2ApT1WQ4OkIyq+YfPHDlyIRSxKHuP0mi7WBwDUSvfr1ZhES4EcHplPLiswVU1OHAKRs=
To: "Roger Luethi" <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine NIC, Via SATA or reiserfs broken, how to tell??
References: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com> <20050814121255.GA2695@k3.hellgate.ch>
Message-ID: <op.svik4dzgyuqkyt@magpie.mire.mine.nu>
Date: Mon, 15 Aug 2005 06:13:15 +1000
Organization: http://www.squishybuglet.mine.nu/
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20050814121255.GA2695@k3.hellgate.ch>
User-Agent: Opera M2/8.02 (Win32, build 7680)
From: Grant Coady <grant.coady@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 22:12:55 +1000, Roger Luethi <rl@hellgate.ch> wrote:

>> @@ -31,7 +31,7 @@
>>  #define APC_BPORT_REG  0x30
>>
>>  #define APC_REGMASK            0x01
>> -define APC_BPMASK              0x03
>> +#define APC_BPMASK             0x03
>
> Color me skeptical. I've seen some weird bit flips and data corruption;
> "paramters" to "paramEters" I could buy. But data corruption that
> _inserts_ a hash mark a the beginning of a line of a header file? What
> are the odds?

A bitflip in the compressed image could expand the wrong token
resulting in dataloss just as easily as flip character case.

Since reporting this error I've eliminated filesystem and NIC
by substitution, fault occurs on ext2 and Intel pro/100.
>
>> Today disabled onboard via-rhine and used Intel pro/100 + e100 driver,
>> several source trees unpacked identically, running 2.6.12.4 or 2.4.31-hf3
>
> While that seems to point to the Rhine as the possible cause, I can't
> see how any driver could possibly be involved in this.

Neither can I, now testing outside of linux, eliminate OS as factor,
or, is it hardware or software?  I dunno...

Grant.
