Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264663AbSJTW4t>; Sun, 20 Oct 2002 18:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264675AbSJTW4p>; Sun, 20 Oct 2002 18:56:45 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:18694 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264663AbSJTWzO>;
	Sun, 20 Oct 2002 18:55:14 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200210202301.g9KN1B7371667@saturn.cs.uml.edu>
Subject: Re: [ANNOUNCE] procps 3.0.4
To: riel@conectiva.com.br (Rik van Riel)
Date: Sun, 20 Oct 2002 19:01:11 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), jgarzik@pobox.com (Jeff Garzik),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0210202032590.22993-100000@imladris.surriel.com> from "Rik van Riel" at Oct 20, 2002 08:35:07 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Sat, 19 Oct 2002, Albert D. Cahalan wrote:

>>> Can you be more specific?  What bugs do you see?
>>
>> There isn't error checking in the five_cpu_numbers function
>> to detect bad data. Not that bad data should ever happen; there
>> is a bug in the WOLK kernel.
>
> Guess why the iowait stats are initialised to 0 ? ;)
>
> We know that user, system, nice and idle are present
> in every kernel and we bail out with an error if we
> get less than 4 values for the CPU stats.

The problem is not at all related to the IO-wait addition,
and no you don't bail out with an error... procps 3 does
bail out, elsewhere, causing the mistaken belief that procps 2
runs correctly on a WOLK kernel. That's wrong; no procps runs
correctly on a WOLK kernel.

I mentioned the issue merely to avoid bogus bug reports.
I don't want WOLK kernel users claiming that procps 2 works
and procps 3 not; the truth is that neither one can work
on a WOLK kernel.

>> I could make vmstat way faster if the kernel would provide the
>> number of tasks that are running, swapped out, blocked, etc.
>
> I sent in a patch for that. I'll resend when Linus returns
> from holidays.

Great.

jim.houston@attbi.com seems to have most of a patch for
the %CPU problem. (tracking the data, but not reporting it)

What about /proc/*/tty, an adopted-child flag, something for
the kapmd-idle problem, /proc/*/threads/* files, etc. ?
