Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTDWXzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTDWXzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:55:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:62694 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264332AbTDWXzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:55:35 -0400
Date: Wed, 23 Apr 2003 16:57:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Pavel Machek <pavel@ucw.cz>, "Grover, Andrew" <andrew.grover@intel.com>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <1592050000.1051142225@flay>
In-Reply-To: <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
>> > Can't you just create a pre-reserved separate swsusp area on 
>> > disk the size 
>> > of RAM (maybe a partition rather than a file to make things 
>> > easier), and 
>> > then you know you're safe (basically what Marc was 
>> > suggesting, except pre-allocated)? Or does that make me the 
>> > prince of all evil? ;-)
>> > 
>> > However much swap space you allocate, it can always all be 
>> > used, so that seems futile ...
>> 
>> This is what Other OSes do, and I believe this is the correct path.
>> Using swap for swsusp is a clever hack but not a 100% solution.
> 
> Well, for normal use its clearly inferior -- suspend partition is unused
> when it could be used for speeding system up by swapping out unused
> stuff.
> 
> OtherOS approach is better because it can guarantee suspend-to-disk
> for critical situations like overheat or battery-critical.
> 
> But we can get best of both worlds if we OOM-kill during critical
> suspend. [If suspend partition was not used for swapping, machine
> would *already* OOM-killed someone, so we are only improving stuff].

OK ... but at least having the *option* to have a separate reserved
area would be nice, no? For most people, RAM is just a tiny amount
of their disk space ... and damn, does it make the code simpler ;-)

M.

