Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbTLLPLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbTLLPLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:11:22 -0500
Received: from main.gmane.org ([80.91.224.249]:34466 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265256AbTLLPLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:11:19 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Date: Fri, 12 Dec 2003 16:11:17 +0100
Message-ID: <yw1xy8tixe96.fsf@kth.se>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se>
 <Pine.LNX.4.53.0312121000150.10423@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:d9FJL8AVPU12VdMTm6Br7rU0eYY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On Fri, 12 Dec 2003, [iso-8859-1] Måns Rullgård wrote:
>
>> Dale Mellor <dale@dmellor.dabsol.co.uk> writes:
>>
>> > 1. Floppy motor spins when floppy module not installed.
>>
>> It's a known problem.  Some broken BIOSes don't turn off the motor
>> after probing for a disk.  One solution is to change the boot priority
>> in the BIOS settings so the hard disk is tried before floppy.  If you
>> ever need to boot from a floppy, you can change it back.
>
> It is not a broken BIOS! The BIOS timer that ticks 18.206 times
> per second has an ISR that, in addition to keeping time, turns
> OFF the FDC motor after two seconds of inactivity. This ISR is taken
> away by Linux. Therefore Linux must turn off that motor! It is a
> Linux bug, not a BIOS bug. Linux took control away from the BIOS
> during boot.

OK, but why doesn't it affect all machines?

-- 
Måns Rullgård
mru@kth.se

