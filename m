Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272582AbTHIRnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272623AbTHIRnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:43:31 -0400
Received: from zork.zork.net ([64.81.246.102]:12929 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S272582AbTHIRn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:43:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: NULL.  Again.  (was Re: [PATCH] 2.4.22pre10: {,un}likely_p())
References: <1060087479.796.50.camel@cube>
	<20030809002117.GB26375@mail.jlokier.co.uk>
	<20030809081346.GC29616@alpha.home.local>
	<20030809015142.56190015.davem@redhat.com>
	<1060425774.4933.73.camel@dhcp22.swansea.linux.org.uk>
	<20030809162332.GB29647@mail.jlokier.co.uk>
	<20030809173001.GG24349@perlsupport.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 09 Aug 2003 18:43:26 +0100
In-Reply-To: <20030809173001.GG24349@perlsupport.com> (Chip Salzenberg's
 message of "Sat, 9 Aug 2003 13:30:01 -0400")
Message-ID: <6ufzkad8w1.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg <chip@pobox.com> writes:

> According to Jamie Lokier:
>> Not just K&R.  These are different because of varargs:
>> 	printf ("%p", NULL);
>> 	printf ("%p", 0);
>
> *SIGH*  I thought incorrect folk wisdom about NULL and zero and pointer
> conversions had long since died out.  More fool I.  Please, *please*,
> _no_one_else_ argue about NULL/zero/false etc. until after reading this:
>
>   ===[[  http://www.eskimo.com/~scs/C-faq/s5.html  ]]===
>
> I thank you, and linux users everywhere thank you.

I had thought that the need for writing NULL where a pointer is
expected in varags functions was because the machine may have
different sizes for pointers and int.  In the case of the second
printf call above, if pointers are 64-bit and integers are 32-bit,
printf will read eight bytes from the stack, and only four will have
been occupied by the integer 0.

