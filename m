Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269860AbUH0A65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269860AbUH0A65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269831AbUH0A4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:56:17 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:17318 "HELO
	mother.localdomain") by vger.kernel.org with SMTP id S269782AbUHZXxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:53:19 -0400
Date: Fri, 27 Aug 2004 01:53:18 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
Message-ID: <20040826235318.GB8550@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040826014745.225d7a2c.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:47:45AM -0700, Andrew Morton wrote:
> - nicksched is still here.  There has been very little feedback, except that
>   it seems to slow some workloads on NUMA.

 I've today returned from -mm series to 2.6.9-rc1 and noticed some
changes. Usual workload of my celeron 366 consist of bunch of
transparent Eterms, firefox, xmms playing and some background daemons
(like spamassassin).

 Xmms is known for unpleasant behaviour - it sleeps a lot, slowing down
entire system. This isn't noticable in top, which show ~10% CPU
dedicated to xmms, but it very easy to feel.

 Nick scheduler in contrast to stock scheduler from -linus make
interativity a lot better. When switching workspaces, windows redraw
almost instantly (max 2 seconds), whereas in -linus I often have to wait
up to 8-10 seconds to work.

 when running -mm, playing xmms don't slow thinhs much. Kernel compile
is almost as fast, as when xmms is shut. In -linus in turn, playing xmms
can slow down compile twice.

 Firefox loading 3-4 pages in tabs in -linus makes all desktop lagging.
Scheduler from -mm makes load caused by firefox unnoticabled in other
apps.

 That are my observations. It's nothing scientific and there are no
solind numbers from benchmarks to support them.

-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.

