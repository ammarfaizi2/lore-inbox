Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTJXJLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTJXJLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:11:40 -0400
Received: from main.gmane.org ([80.91.224.249]:31882 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262108AbTJXJLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:11:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Fri, 24 Oct 2003 11:11:32 +0200
Message-ID: <yw1xr813f1a3.fsf@kth.se>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
 <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se>
 <20031023082534.GD643@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:hVAOfFjS6jI+Z+mr9zPRbCxQaaM=
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> >> suspend, the extra buttons (I use them to fire up programs) stop
>> >> working.  Normally, they will generate an ACPI event, that is
>> >> processed by acpid etc.  After a suspend, each button will work once.
>> >> If I then close and open the lid, they will work one more time, and so
>> >> on.  Any way I can help?
>> >
>> > Please specify the type of suspend. The situation I described
>> > only occurs for S1 (or, echo -n standby, more specifically), and
>> > only in certain kernel versions.
>> 
>> standby, at least.
>> 
>> After echo -n mem > /sys/power/state, the display light won't turn on,
>> so I don't know what's going on.  I've never managed to resume from a
>> suspend to disk.  It just boots normally and makes a fuss about the
>> filesystems.
>
> Are you passing resume= option?

I've been trying the new suspend to disk implementation (pmdisk, I
think) lately.  I get these lines in the kernel log when starting
after a suspend:

PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)

Last time I tried swsusp, I did pass the resume= option, but it didn't
work.

Could it be that some disk cache is never flushed properly?
Occasionally, some random filesystem is reported as not being cleanly
unmounted when booting normally, which seems to point in the same
direction.

-- 
Måns Rullgård
mru@kth.se

