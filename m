Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261620AbTDBVsQ>; Wed, 2 Apr 2003 16:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263168AbTDBVsQ>; Wed, 2 Apr 2003 16:48:16 -0500
Received: from 66-133-183-62.br1.fod.ia.frontiernet.net ([66.133.183.62]:60358
	"EHLO www.duskglow.com") by vger.kernel.org with ESMTP
	id <S261620AbTDBVsP>; Wed, 2 Apr 2003 16:48:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Russell Miller <rmiller@duskglow.com>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: subsystem crashes reboot system?
Date: Wed, 2 Apr 2003 15:51:04 -0600
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200304021149.36511.rmiller@duskglow.com> <20030402135104.4b1acadf.akpm@digeo.com>
In-Reply-To: <20030402135104.4b1acadf.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304021551.04659.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance of making the dying thread sleep just long enough for syslogd to 
write it out to the file, then panic?  Since it's an assertion, we have a 
little more leeway then in a page fault OOPS, for example.

--Russell

On Wed April 2 2003 3:51 pm, Andrew Morton wrote:
> Russell Miller <rmiller@duskglow.com> wrote:
> > Since this was an assertion that failed, one would think that bringing
> > the system down automatically in an orderly - then, if that fails,
> > disorderly - fashion would be possible.
>
> The way to handle this is to make arch/i386/kernel/traps.c:die() optionally
> call panic() rather than do_exit().
>
> It makes sense.  It does mean that we now have zero chance of the
> diagnostic info making it to the system logs.

