Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUCMFt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 00:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUCMFt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 00:49:29 -0500
Received: from holomorphy.com ([207.189.100.168]:43016 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263056AbUCMFt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 00:49:27 -0500
Date: Fri, 12 Mar 2004 21:49:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@sgi.com>, lse-tech@lists.sourceforge.net,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040313054910.GA655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>, Ray Bryant <raybry@sgi.com>,
	lse-tech@lists.sourceforge.net,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	linux-kernel@vger.kernel.org
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313034840.GF4638@wotan.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 04:48:40AM +0100, Andi Kleen wrote:
> One drawback is that the out of memory handling is lot less nicer
> than it was before - when you run out of hugepages you get SIGBUS
> now instead of a ENOMEM from mmap. Maybe some prereservation would
> make sense, but that would be somewhat harder. Alternatively
> fall back to smaller pages if possible (I was told it isn't easily
> possible on IA64)

That's not entirely true. Whether it's feasible depends on how the
MMU is used. The HPW (Hardware Pagetable Walker) and short mode of the
VHPT insist upon pagesize being a per-region attribute, where regions
are something like 60-bit areas of virtualspace, which is likely what
they're referring to. The VHPT in long mode should be capable of
arbitrary virtual placement (modulo alignment of course).


-- wli
