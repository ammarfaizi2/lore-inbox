Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUACSQX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUACSQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:16:23 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:40339
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263632AbUACSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:16:22 -0500
Message-ID: <3FF706F1.1030508@tmr.com>
Date: Sat, 03 Jan 2004 13:16:17 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
CC: Pavel Machek <pavel@ucw.cz>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
References: <20031212221045.GB314@elf.ucw.cz> <1071269429.4182.6.camel@idefix.homelinux.org>
In-Reply-To: <1071269429.4182.6.camel@idefix.homelinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Valin wrote:

> Actually, the way I rewrote it in the patch is immune to that kind of
> problem:
> 
> seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
>            HZ*(c->loops_per_jiffy>>3)/62500,
>            (HZ*(c->loops_per_jiffy>>3)/625)%100);
> 
> It will work correctly for any HZ up to ~34000 bogomips (using 32-bit
> arithmetic).

I think it's likely any CPU with 34000 bogomips will have more than 32 
bit ;-)

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
