Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265840AbSKFRFF>; Wed, 6 Nov 2002 12:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265841AbSKFRFE>; Wed, 6 Nov 2002 12:05:04 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:29887 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265840AbSKFRFE>;
	Wed, 6 Nov 2002 12:05:04 -0500
Date: Wed, 6 Nov 2002 17:10:42 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: vasya vasyaev <vasya197@yahoo.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine's high load when HIGHMEM is enabled
Message-ID: <20021106171042.GA11614@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, vasya vasyaev <vasya197@yahoo.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	linux-kernel@vger.kernel.org
References: <F2DBA543B89AD51184B600508B68D4000F2ED497@fmsmsx103.fm.intel.com> <20021106101445.42142.qmail@web20502.mail.yahoo.com> <3DC94885.AD5B8A3B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC94885.AD5B8A3B@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 08:51:17AM -0800, Andrew Morton wrote:
 > For some reason your mtrr table was not covering the last 32 megabytes
 > of memory.  Probably you could also have fixed this by altering the
 > mtrr settings.  See Documentation/mtrr.txt in the kernel source tree.

I've seen this happen on systems with onboard graphics cards
that share system RAM as video RAM. The end result is that Linux
sees an amount of mem that isn't a power of two.

In extreme cases, the BIOS has done really mad things like
instead of covering the 1GB with 1 MTRR, it splits it into
7 MTRRs covering 512MB,256MB,128MB,64MB,32MB,16MB,8MB.
Icky.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
