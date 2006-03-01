Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWCANPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWCANPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWCANPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:15:55 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:22465 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932205AbWCANPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:15:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] proc: task_mmu bug fix.
Date: Wed, 1 Mar 2006 14:15:46 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, pj@sgi.com
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net> <20060228234628.55ee9f76.akpm@osdl.org> <m1oe0qnxdi.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1oe0qnxdi.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011415.46749.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 13:49, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >>
> >> This should fix the big bug that has been crashing kernels when
> >>  fuser is called.  At least it is the bug I observed here.  It seems
> >>  you need the right access pattern on /proc/<pid>/maps to trigger this.
> >
> > Thanks.  Do you think this is likely to fix the crashes reported by
> > Laurent, Jesper, Paul, Rafael and Martin?
> 
> So I haven't tracked down all of the bug reports yet.  But the
> few bits I have seen make it likely.  First the task_mmu change
> was one of the largest change in logic I had to make.  Second
> the ugly bug reports seem to be about an extra decrement.  Third
> it seems to be my task_ref work that is the most implicated.
> 
> I will certainly follow and see what I can do to confirm that I have
> gotten everything.

I can confirm it fixes the problem that I have reported.

Thanks a lot,
Rafael
