Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTHYLXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbTHYLXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:23:45 -0400
Received: from main.gmane.org ([80.91.224.249]:57744 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261664AbTHYLXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:23:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH]O18.1int
Date: Mon, 25 Aug 2003 13:23:42 +0200
Message-ID: <yw1xwud2asld.fsf@users.sourceforge.net>
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net>
 <20030825094240.GJ16080@Synopsys.COM>
 <yw1xad9yca8j.fsf@users.sourceforge.net>
 <20030825103420.GL16080@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:3fS3EbA5hfIYq44prM+Nl0ABW9U=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <alexander.riesen@synopsys.COM> writes:

>> >> XEmacs still spins after running a background job like make or grep.
>> >> It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
>> >> as often, or as long time as with O16.3, but it's there and it's
>> >> irritating.
>> >
>> > another example is RXVT (an X terminal emulator). Starts spinnig after
>> > it's child has exited. Not always, but annoyingly often. System is
>> > almost locked while it spins (calling select).
>> 
>> It sounds like the same bug.  IMHO, it's rather bad, since a
>> non-privileged process can make the system unusable for a non-zero
>> amount of time.
>
> the source of RXVT looks more like the bug: it does not check for
> errors, even though it is a bit tricky to get portably.

A program should never be able to grab more than it's share of the CPU
time, no matter how buggy it is.

>> How should I do to capture some information about this thing?
>
> Use "top" and look at the dynamic priority.

I'll try, but it could be tricky, since it doesn't usually last very
long.

-- 
Måns Rullgård
mru@users.sf.net

