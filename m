Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbRHYLzu>; Sat, 25 Aug 2001 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268916AbRHYLzk>; Sat, 25 Aug 2001 07:55:40 -0400
Received: from ns.ithnet.com ([217.64.64.10]:46346 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S268901AbRHYLza>;
	Sat, 25 Aug 2001 07:55:30 -0400
Date: Sat, 25 Aug 2001 13:55:08 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roger Larsson <roger.larsson@norran.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] simpler __alloc_pages{_limit}
Message-Id: <20010825135508.5afe1988.skraw@ithnet.com>
In-Reply-To: <200108250055.f7P0tGh28170@mailg.telia.com>
In-Reply-To: <200108242253.f7OMrbQ20401@mailf.telia.com>
	<200108250055.f7P0tGh28170@mailg.telia.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001 02:48:28 +0200
Roger Larsson <roger.larsson@norran.net> wrote:

> Hi again,
> 
> [two typos corrected from the version at linux-mm]
> [...]
> Doing this - the code started to collaps...
> __alloc_pages_limit could suddenly handle all special cases!
> (with small functional differences)
> 
> Comments?

Hi Roger,

I tested your page against straight 2.4.9 (where it applied mostly, the rest I did manually) and experience the following:
1) system gets slow, even in times where plenty of free memory is available. There must be some overhead inside.
2) It does not really work around the basic problem of too many cached pages in case of heavy filesystem action, I do get the already known "kernel: __alloc_pages: 2-order allocation failed." by simply copying files a lot.
3) Even in high load situations the CPU load seems to get worse, I made it up to 7 with normal file copying on a SMP 1GHz 1GB RAM machine.

Hm, I guess that doesn't really work as you expected.

Regards,
Stephan


