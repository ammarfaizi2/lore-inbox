Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbTCGHsS>; Fri, 7 Mar 2003 02:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbTCGHsR>; Fri, 7 Mar 2003 02:48:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:60293 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261403AbTCGHsR>;
	Fri, 7 Mar 2003 02:48:17 -0500
Date: Thu, 6 Mar 2003 23:58:45 -0800
From: Andrew Morton <akpm@digeo.com>
To: Miles Bader <miles@gnu.org>
Cc: miles@lsi.nec.co.jp, zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
Message-Id: <20030306235845.661fc4ab.akpm@digeo.com>
In-Reply-To: <buoisuv1uyh.fsf@mcspd15.ucom.lsi.nec.co.jp>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
	<20030306222328.14b5929c.akpm@digeo.com>
	<Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
	<20030306233517.68c922f9.akpm@digeo.com>
	<buoisuv1uyh.fsf@mcspd15.ucom.lsi.nec.co.jp>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 07:58:41.0288 (UTC) FILETIME=[5E3DC080:01C2E47F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader <miles@lsi.nec.co.jp> wrote:
>
> Andrew Morton <akpm@digeo.com> writes:
> > All the arch/*/kernel/irq.c implementations are distressingly similar. 
> > Andrey Panin did a bunch of work a while back to start consolidating the
> > common code but it didn't quite get finished off.
> 
> Do you remember what was unfinished about it?  I tried his patch, and it
> seemed to work fine; there were certainly still a few things left unmerged,
> but it was a _huge_ improvement over the current state.

Well I thought that many architectures were missing.  But upon a re-read, I
see that he allowed architectures to be cut over to GENERIC_IRQ one at a
time.  Seems fine.

Although at some point we really do need to stop cleaning stuff up, defer such
things into 2.7 and concentrate upon 2.5 bugs.
