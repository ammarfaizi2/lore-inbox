Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbTHYKni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbTHYKnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:43:37 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:29118
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261682AbTHYKnH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:43:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Date: Mon, 25 Aug 2003 20:50:04 +1000
User-Agent: KMail/1.5.3
References: <200308231555.24530.kernel@kolivas.org> <200308252016.13315.kernel@kolivas.org> <yw1x65kmc9f2.fsf@users.sourceforge.net>
In-Reply-To: <yw1x65kmc9f2.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308252050.04147.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003 20:34, Måns Rullgård wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> >> > XEmacs still spins after running a background job like make or grep.
> >> > It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
> >> > as often, or as long time as with O16.3, but it's there and it's
> >> > irritating.
> >>
> >> another example is RXVT (an X terminal emulator). Starts spinnig after
> >> it's child has exited. Not always, but annoyingly often. System is
> >> almost locked while it spins (calling select).
> >
> > What does vanilla kernel do with these apps running? Both immediately
> > after the apps have started up and some time (>1 min) after they've been
> > running?
>
> Vanilla test1 has the spin effect.  Test2 doesn't.  I haven't tried
> vanilla test3 or test4.  As I've said, the O16.2-O16.3 patch
> introduced the problem.  With that patch reversed, everything is
> fine.  What problem does that patch fix?

It's a generic fix for priority inversion but it induces badness in smp, and 
latency in task preemption on up so it's not suitable.

Con

