Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264041AbTE0SCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTE0SAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:00:50 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:50186 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S264016AbTE0R7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:59:48 -0400
Date: Tue, 27 May 2003 20:12:06 +0200
From: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527181206.GA763@rz.uni-karlsruhe.de>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	manish <manish@storadinc.com>,
	Christian Klose <christian.klose@freenet.de>,
	William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <3ED372DB.1030907@gmx.net> <Pine.LNX.4.55L.0305271425500.30637@freak.distro.conectiva> <200305271936.34006.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 27, 2003 at 02:47:24PM -0300, Marcelo Tosatti wrote:
> On Tue, 27 May 2003, Marc-Christian Petersen wrote:
> > > A "pause" is perfectly fine (to some extent, of course), now a hang is
> > > not. Is this backtrace from a hanged, unusable kernel or ?
> > A pause is _not_ perfectly fine, even not to some extent. That pause we are
> > discussing about is a pause of the _whole_ machine, not just disk i/o pauses.
> > Mouse stops, keyboard stops, everything stops, who knows wtf.
> 
> Do you also notice them?

Since 2.4.19 I notice a lot of pauses with interactive work (desktop
usage). If i copy a big file over network or on local disk, some of my
desktop machines simply don't respond anymore to user requests (e.g. I
start copying a large file over nfs to local disk and start mozilla,
mozilla won't start until the copy is finished).
My current testcase is: dd if=/dev/zero of=blubber bs=4096 count=65000 and
moving the mouse during this operation. With 2.4.18 everything is ok, the
mouse runs smooth the whole time. 2.4.19 and later: I get mouse hangs, it
won't move for a second, sometimes longer. wolk reduces this problem, but
doesn't solve it.
On my servers (mostly IBM xseries 345 and 335) it's ok with a
vanilla-kernel, but there is no interactive work, mostly routing or
network monitoring.
I hope, I can run a vanilla 2.4 kernel again on my machines, at the moment
that isn't possible.

Bye,
Matthias
-- 
Matthias.Mueller@rz.uni-karlsruhe.de
Rechenzentrum Universitaet Karlsruhe
Abteilung Netze
