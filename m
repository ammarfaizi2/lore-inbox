Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289877AbSAXTuI>; Thu, 24 Jan 2002 14:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289872AbSAXTt7>; Thu, 24 Jan 2002 14:49:59 -0500
Received: from ns.ithnet.com ([217.64.64.10]:58386 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289677AbSAXTtk>;
	Thu, 24 Jan 2002 14:49:40 -0500
Date: Thu, 24 Jan 2002 20:49:38 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS and RAID5
Message-Id: <20020124204938.39fa1960.skraw@ithnet.com>
In-Reply-To: <15440.23830.178152.579775@abasin.nj.nec.com>
In-Reply-To: <15440.22127.875361.718680@abasin.nj.nec.com>
	<20020124200645.53dca41c.skraw@ithnet.com>
	<15440.23830.178152.579775@abasin.nj.nec.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 14:14:30 -0500 (EST)
Sven Heinicke <sven@research.nj.nec.com> wrote:

> Software RAID .. Yes
> 
> System got two:
> 
> vendor_id	: GenuineIntel
> model name	: Pentium III (Coppermine)
> cpu MHz		: 868.671
> cache size	: 256 KB
> 
> It's an ASLab system with 4 Ultra100 Cards each with 4 80G maxtor
> drives.  So with the video and network card the PCI slots are full.
> The raid tools are raidtools-0.90-9mdk as shipped with Mandrake 7.2.

Ok. If I get that right your report means that SW RAID5 is just broken,
because if it wasn't reiserfs must have staid alive, but it just hung.
I guess any other fs would have hung, too.
And afterwards you simply fell into the obvious problem, that reiserfs
must heavily rely on the underlying "hw" and gets completely confused
if the lower layer is trashed for whatever reason.

Is anybody out there that ever survived a hd crash in SW RAID5 config?
(Meaning _without_ need to reboot)

(I only try to figure out what is going on, because I am heavily 
interested in building RAID5 configs myself, and you would not want to
touch components (SW or HW) in this case that you cannot not trust)

Regards,
Stephan
