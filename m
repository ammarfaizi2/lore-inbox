Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTE0RPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbTE0RPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:15:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14474 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263969AbTE0RPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:15:45 -0400
Date: Tue, 27 May 2003 14:27:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: manish <manish@storadinc.com>, linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
In-Reply-To: <3ED372DB.1030907@gmx.net>
Message-ID: <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva>
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva>
 <3ED372DB.1030907@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Carl-Daniel Hailfinger wrote:

> Christian,
>
> this looks supiciously like the problem you are experiencing since
> 2.4.19-pre. Maybe we can fix this for good.
>
> Marcelo Tosatti wrote:
> >
> > On Mon, 26 May 2003, manish wrote:
> >
> >
> >>Hello !
> >>
> >>I am running the 2.4.20 kernel on a system with 3.5 GB RAM and dual CPU.
> >>I am running bonnie accross four drives in parallel:
> >>
> >>bonnie -s 1000 -d /<dir-name>
> >>
> >>bdflush settings on this system:
> >>
> >>[root@dyn-10-123-130-235 vm]# cat bdflush
> >>2       50      32      100     50      300     1       0       0
> >>
> >>All the bonnie process and any other process (like df, ps -ef etc.) are
> >>hung in __lock_page. Breaking into kdb, I observe the following for one
>
> Following is SysRq-T output for stuck processes during such a pause from
> Christian Klose. Only processes in D state are listed for brevity.
> Especially the last two call traces are interesting.

A "pause" is perfectly fine (to some extent, of course), now a hang is
not. Is this backtrace from a hanged, unusable kernel or ?
