Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbUCEOPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUCEOPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:15:36 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:32252 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262600AbUCEOPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:15:21 -0500
Date: Fri, 05 Mar 2004 22:14:46 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Daniel Fenert" <daniel@fenert.net>
Subject: Re: Is there some bug in ext3 in 2.4.25?
Cc: linux-kernel@vger.kernel.org, sct@redhat.com,
       "Michelle Konzack" <linux4michelle@freenet.de>
References: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4d66wct4evsfm@smtp.pacific.net.th>
In-Reply-To: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004 11:06:02 -0300 (BRT), Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

>
> Hi,
>
> This sounds like memory corruption (which could be caused by a misbehaving
> driver or by flaky hardware) because transaction->t_ilist is not used at
> all by the kernel code. Did this box run stable with other kernels?
>
> I found a similar report from Michelle (CCed), which can be found at:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107529754608448&w=2
>
> Searching a bit more, I found another message from Michelle with
> topic "[SOLVED] Kernel-Bug (at checkpoint.c 587)"
> http://lists.debian.org/debian-user-german/2004/debian-user-german-200401/msg04404.html
>
> Unfortunately the said message is in German, which I can't understand.
> Michelle, can you clarify it for me?

> Hallo Leute,

> Auch wenn ich von der kernel-list@vger.kernel.org keine Antworterhalten habe, handelt es sich definitiv um einen echten Kernel-
> Bug in 2.4.22 der in 2.4.24 offensichtlich nicht mehr vorhandenlist.

Although I have nt received a reply from LKML, it is definitively
a real kernel bug in 2.4.22 which has been fixed in 2.4.24.

Ein weiterer Fehler trat mehrfach in 'exit.c' auf, der ebenfals
nach der Installation von Linux 2.4.24 verschwunden war.

Further bug occuring several times in 'exit.c' has also vanished
after installation of 2.4.24.

>
> Stephen, Andrew, any idea how can transaction->t_ilist become not NULL?
>
>
> On Thu, 4 Mar 2004, Daniel Fenert wrote:
>
>> Message from syslogd@lazy at Thu Mar  4 08:31:58 2004 ...
>> lazy kernel: Assertion failure in __journal_drop_transaction() at
>> checkpoint.c:587: "transaction->t_ilist == NULL"
>>
>> Networking still works, I've tried to login, but no luck here.
>> I've got one ssh console opened, and tried to reboot, but nothing happend, it
>> looks like it lost connection with hda :(
>> Where should I look for reason?
>> Machine as faaar away, and it's second or third time it hangs mysteriously,
>> the only difference is that this time I've got some console output.
>>
>
>> From daniel@fenert.net Fri Mar  5 10:48:26 2004
> Date: Thu, 4 Mar 2004 08:03:29 +0100
> From: Daniel Fenert <daniel@fenert.net>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Is there some bug in ext3 in 2.4.25?
>
>> Message from syslogd@lazy at Thu Mar  4 08:31:58 2004 ...
>> lazy kernel: Assertion failure in __journal_drop_transaction() at
>> checkpoint.c:587: "transaction->t_ilist == NULL"
>
> One more thing - it has happened when /var got full.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


