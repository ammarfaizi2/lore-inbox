Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTJXKXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 06:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTJXKXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 06:23:46 -0400
Received: from mail-04.iinet.net.au ([203.59.3.36]:2523 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262123AbTJXKXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 06:23:44 -0400
Message-ID: <3F98FDDF.1040905@cyberone.com.au>
Date: Fri, 24 Oct 2003 20:24:31 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se> <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se>
In-Reply-To: <yw1xr813f1a3.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Måns Rullgård wrote:

>Pavel Machek <pavel@ucw.cz> writes:
>
>
>>>>>suspend, the extra buttons (I use them to fire up programs) stop
>>>>>working.  Normally, they will generate an ACPI event, that is
>>>>>processed by acpid etc.  After a suspend, each button will work once.
>>>>>If I then close and open the lid, they will work one more time, and so
>>>>>on.  Any way I can help?
>>>>>
>>>>Please specify the type of suspend. The situation I described
>>>>only occurs for S1 (or, echo -n standby, more specifically), and
>>>>only in certain kernel versions.
>>>>
>>>standby, at least.
>>>
>>>After echo -n mem > /sys/power/state, the display light won't turn on,
>>>so I don't know what's going on.  I've never managed to resume from a
>>>suspend to disk.  It just boots normally and makes a fuss about the
>>>filesystems.
>>>
>>Are you passing resume= option?
>>
>
>I've been trying the new suspend to disk implementation (pmdisk, I
>think) lately.  I get these lines in the kernel log when starting
>after a suspend:
>
>PM: Reading pmdisk image.
>PM: Resume from disk failed.
>ACPI: (supports S0 S1 S3 S4 S5)
>
>Last time I tried swsusp, I did pass the resume= option, but it didn't
>work.
>
>Could it be that some disk cache is never flushed properly?
>Occasionally, some random filesystem is reported as not being cleanly
>unmounted when booting normally, which seems to point in the same
>direction.
>

Try turning your disk cache off, or set it to write through caching
(even so I heard some IDE drives don't turn it off anyway!). See if
it helps.


