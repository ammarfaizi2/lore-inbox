Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbTCJKLi>; Mon, 10 Mar 2003 05:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbTCJKLh>; Mon, 10 Mar 2003 05:11:37 -0500
Received: from holomorphy.com ([66.224.33.161]:59572 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261246AbTCJKLh>;
	Mon, 10 Mar 2003 05:11:37 -0500
Date: Mon, 10 Mar 2003 02:21:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Message-ID: <20030310102100.GD20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <5.2.0.9.2.20030310075720.00c832f8@pop.gmx.net> <5.2.0.9.2.20030310075720.00c832f8@pop.gmx.net> <5.2.0.9.2.20030310105217.00cd25b0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20030310105217.00cd25b0@pop.gmx.net>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:12 PM 3/10/2003 +1100, Con Kolivas wrote:
>> Contest uses a modified process load from irman so it exhibits similar
>> behaviour. Not sure what +12 actually tells me though :-(

On Mon, Mar 10, 2003 at 11:05:25AM +0100, Mike Galbraith wrote:
> Aha!  No wonder your symptoms look so similar.  +12 is just a magic number 
> that works... found by trusty old trial and error method.  What I wanted to 
> see was if your hang would also go away with the same magic number, or if 
> renicing with any value helped you at all.

At 08:12 PM 3/10/2003 +1100, Con Kolivas wrote:
>> My simplistic understanding is that the pipe task in process_load gets
>> constantly elevated as "interactive" by the new scheduler, and nothing else
>> ever happens.

On Mon, Mar 10, 2003 at 11:05:25AM +0100, Mike Galbraith wrote:
> Appears so.  I can make it "work" by doing a dinky (butt ugly:) tweak in 
> activate_task().

IMHO directed yields should attempt to prevent priority inversion but
not elevate priorities otherwise. I'd bug mingo about it.

-- wli
