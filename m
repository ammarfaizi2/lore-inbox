Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTEIInq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTEIInq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:43:46 -0400
Received: from pat.uio.no ([129.240.130.16]:34432 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262382AbTEIIno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:43:44 -0400
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: alan@lxorguk.ukuu.org.uk
CC: terje.eggestad@scali.com, hch@infradead.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, D.A.Fedorov@inp.nsk.su
In-reply-to: <1052405926.10037.55.camel@dhcp22.swansea.linux.org.uk> (message
	from Alan Cox on 08 May 2003 15:58:48 +0100)
Subject: Re: The disappearing sys_call_table export.
MIME-Version: 1.0
Message-Id: <E19E3fm-0000Mt-00@aqualene.uio.no>
Date: Fri, 9 May 2003 10:56:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Alan Cox]
> On Iau, 2003-05-08 at 13:25, Terje Malmedal wrote:
>> How about a
>> 
>> EXPORT_SYMBOL_GPL_AND_DONT_EVEN_THINK_ABOUT_SENDING_A_BUG_REPORT(sys_call_table);

> Its in read only space nowdays anyway

>> A server for an online internet game had several months of uptime and
>> I needed to rotate the log-files so I made a module which trapped
>> sys_write and closed and reopened the file with a new name before
>> continuing[1]. 

> man ptrace

Did not work on multi-threaded programs at the time(at least strace
didn't), nowadays I'd use gdb as I explained in the original mail.

The point is that I used to get a convenient mechanism for working
around or fixing bugs in the kernel and applications without any
downtime. This is are very useful capability to have even if it is
only needed rarely.

Is there any reasonable way to be able to do modify a running kernel
like this? I assume I can't count on the method from Phrack working
forever...

-- 
 - Terje
malmedal@usit.uio.no
