Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVAKA15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVAKA15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVAKATh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:19:37 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:5575 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262653AbVAKAAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:00:55 -0500
Date: Mon, 10 Jan 2005 16:00:50 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Slade Maurer <smaurer@teja.com>
Cc: Dave <dave.jiang@gmail.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, linux@arm.linux.org.uk, drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
Message-ID: <20050111000050.GA7958@plexity.net>
Reply-To: dsaxena@plexity.net
References: <8746466a050110153479954fd2@mail.gmail.com> <41E3176F.6000809@teja.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E3176F.6000809@teja.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 10 2005, at 16:01, Slade Maurer was caught saying:
> Also, it would be nice to have PTEs to represent the upper 4GB such that 
> it can be mmapped to user space. PAE handled this in and it would be 
> great to have it in ARM MMU36 as well.

Not doable. I believe PAE allows for normal 4K pages to be used when
mapping > 32-bits. XSC3 and ARMv6 only allow for > 32 bit addresses 
when using 16MB pages (supersections), so we need to instead use
the hugetlb approach.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

If you complain once more, you'll meet an army of me. - Bjork
