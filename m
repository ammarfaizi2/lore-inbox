Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132594AbRDCF5q>; Tue, 3 Apr 2001 01:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132599AbRDCF5h>; Tue, 3 Apr 2001 01:57:37 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:22795 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S132594AbRDCF5Z>; Tue, 3 Apr 2001 01:57:25 -0400
Date: Mon, 2 Apr 2001 23:56:41 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
Message-ID: <20010402235641.A813@mail.harddata.com>
In-Reply-To: <3AC91800.22D66B24@mandrakesoft.com> <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com>; from dlang@diginsite.com on Mon, Apr 02, 2001 at 05:39:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001 at 05:39:19PM -0700, David Lang wrote:
> 
> if the distro/sysadmin _always_ installs the kernel the 'right way' then
> the difference isn't nessasarily that large, but if you want reliability
> on any system it may be worth loosing a page or so of memory (hasn't
> someone said that the data can be compressed to <1K?)

After throwing away in a Makefile rule all "is not set" lines, as they
are trivially recoverable with 'make oldconfig', what is left for an
avarege kernel compresses to something like 500 bytes.  Quite a bit
of space left on this one page if you need more extensive .config.
'zcat /proc/config.gz' works just fine.

As most kernels around are NOT installed "the right way" I found that in
practice separating configuration information from a kernel image is not
even close to be semi-reliable on a longer run.  Those who say
"installation script", and similar things, assume that people compile
kernels for themselves.  This is undoubtely true for folks on this list;
this does not start to approximate the situation in general and, it
seems, that we really want it that way. :-)

BTW - /sbin/installkernel, as seen in practice, is not even correct for
a general case with x86; not to mention other architectures.  Writing
something like /var/log/config from "init data" during a bootup could be
another solution which does not take any kernel memory and still keeps
all this information attached to a kernel image itself.  OTOH we have
all these tons of strings which show in /proc/pci output and somehow
these do not cause such huge opposition.  Yes, I know that 'lspci' was
supposed to replace that; but it did not.

  Michal
