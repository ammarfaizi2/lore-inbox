Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbTHYKe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbTHYKe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:34:27 -0400
Received: from vaxjo.synopsys.com ([198.182.60.75]:57057 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S261674AbTHYKe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:34:26 -0400
Date: Mon, 25 Aug 2003 12:34:20 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Message-ID: <20030825103420.GL16080@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net> <20030825094240.GJ16080@Synopsys.COM> <yw1xad9yca8j.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xad9yca8j.fsf@users.sourceforge.net>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård, Mon, Aug 25, 2003 12:17:16 +0200:
> Alex Riesen <alexander.riesen@synopsys.COM> writes:
> 
> >> XEmacs still spins after running a background job like make or grep.
> >> It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
> >> as often, or as long time as with O16.3, but it's there and it's
> >> irritating.
> >
> > another example is RXVT (an X terminal emulator). Starts spinnig after
> > it's child has exited. Not always, but annoyingly often. System is
> > almost locked while it spins (calling select).
> 
> It sounds like the same bug.  IMHO, it's rather bad, since a
> non-privileged process can make the system unusable for a non-zero
> amount of time.

the source of RXVT looks more like the bug: it does not check for
errors, even though it is a bit tricky to get portably.
It is still a problem, though: "_almost_ locked" does not make it nice.

> How should I do to capture some information about this thing?

Use "top" and look at the dynamic priority.


