Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWITXBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWITXBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWITXBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:01:54 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:36421 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932446AbWITXBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:01:52 -0400
In-Reply-To: <1158749069.7705.9.camel@localhost.localdomain>
Subject: Re: [PATCH] Linux Kernel Markers
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Jes Sorensen <jes@sgi.com>,
       karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ltt-dev@shafik.org,
       Martin Bligh <mbligh@google.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Ingo Molnar <mingo@elte.hu>, prasanna@in.ibm.com,
       systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>,
       William Cohen <wcohen@redhat.com>, Tom Zanussi <zanussi@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OFA620FD83.F72E84C5-ON802571EF.007DCA9D-802571EF.007E6808@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Thu, 21 Sep 2006 00:00:41 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 21/09/2006 00:03:00
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox <alan@lxorguk.ukuu.org.uk> wrote on 20/09/2006 11:44:29:

> Ar Maw, 2006-09-19 am 20:52 -0400, ysgrifennodd Karim Yaghmour:
> > a) the errata & a possible thread having an IP leading back within (not
> >    at the start of) the range to be replaced.
> > b) the errata & replacing single instruction with single instruction of
> >    same size.
>
> Intel don't distinguish. Richard's reply later in the thread answers a
> lot more including what Intels architecture team said about int3 being a
> specific safe case for soem reason
>
> > I was vaguely aware of the issue on x86. Do you know if this applies
the
> > same on other achitectures?
>
> I wouldn't know.

It can for another reason - score-boarding: that's where a byte being
stored assumes intermediate values due to the bits not being set
simultaneously. Generally this doesn't cause a problem because data across
processors is serialised for update by mutexes. However, when applied to
code all sorts of interesting instructions can execute before the bits
settle down. I haven't heard of this troubling Intel, but it does occur on
some current architectures.

Richard

