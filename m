Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbTCFXH6>; Thu, 6 Mar 2003 18:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261211AbTCFXH6>; Thu, 6 Mar 2003 18:07:58 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:36101
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261206AbTCFXH5>; Thu, 6 Mar 2003 18:07:57 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Robert Love <rml@tech9.net>
To: jvlists@ntlworld.com
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <g3of4owfex.fsf@bart.isltd.insignia.com>
References: <Pine.LNX.4.44.0303060842270.7206-100000@home.transmeta.com>
	 <Pine.LNX.4.44.0303061801250.13726-100000@localhost.localdomain>
	 <g3of4owfex.fsf@bart.isltd.insignia.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046992723.715.81.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 06 Mar 2003 18:18:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 12:52, jvlists@ntlworld.com wrote:

> P.S. IMVHO the xine problem is completely different as has nothing to
> with interactivity but with the fact that it is soft
> real-time. i.e. you need to distingish xine from say a gimp filter or
> a 3D renderer with incremental live updates of the scene it is
> creating.

Xine is the same as X or vi or xmms, for this problem.

They are all, in fact, soft real-time issues where the latency limit we
want is whatever is the threshold of human perception.  This limit may
be more or less for DVD playback vs. typing vs. music playback... but
ultimately there is some latency threshold you want maintained.  If Xine
is starved too long, your video skips.  If vi is starved too long, you
can perceive a lag in your keystrokes showing up.  It is all the same.

Maybe we do not care about the latency of the gimp filter.  Those are
indeed different.  But the interactivity of other things - say, gimp's
menus in response to you clicking them - are all the same sort of thing.

	Robert Love

