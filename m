Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271001AbRHXJ07>; Fri, 24 Aug 2001 05:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270102AbRHXJ0t>; Fri, 24 Aug 2001 05:26:49 -0400
Received: from ns.ithnet.com ([217.64.64.10]:7434 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271001AbRHXJ0g>;
	Fri, 24 Aug 2001 05:26:36 -0400
Date: Fri, 24 Aug 2001 11:25:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roger Larsson <roger.larsson@norran.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Upd: [PATCH NG] alloc_pages_limit & pages_min
Message-Id: <20010824112520.5f01626f.skraw@ithnet.com>
In-Reply-To: <200108231933.f7NJX8j21551@mailc.telia.com>
In-Reply-To: <Pine.LNX.4.33L.0108231600020.31410-100000@duckman.distro.conectiva>
	<200108231933.f7NJX8j21551@mailc.telia.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001 21:28:44 +0200
Roger Larsson <roger.larsson@norran.net> wrote:

> Riel convinced be to back off a part of the patch.
> Here comes an updated one.

Hello Roger,

this does not solve my problem with NFS-copies. Just for information. I tried and did not work.
Besides I expected the patch to make the free pages pool somehow bigger during file-copies, but ended up with this situation:

        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 918573056  3153920        0 12337152 816504832
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:          3080 kB
MemShared:           0 kB
Buffers:         12048 kB
Cached:         797368 kB
SwapCached:          0 kB
Active:         473628 kB
Inact_dirty:    331796 kB
Inact_clean:      3992 kB
Inact_target:     1940 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:          3080 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

The MemFree isn't really a lot compared to inact_dirty. knfsd fails at least.

Regards, Stephan

