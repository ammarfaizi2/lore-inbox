Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTEUJbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTEUJbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:31:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34574 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261688AbTEUJbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:31:01 -0400
Date: Wed, 21 May 2003 10:43:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vladimir Serov <vserov@infratel.com>, trond.myklebust@fys.uio.no,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, nico@cam.org
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
Message-ID: <20030521104355.C17709@flint.arm.linux.org.uk>
Mail-Followup-To: Vladimir Serov <vserov@infratel.com>,
	trond.myklebust@fys.uio.no,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, nico@cam.org
References: <3E7ADBFD.4060202@infratel.com> <shsof45nf58.fsf@charged.uio.no> <3E7B0051.8060603@infratel.com> <15995.578.341176.325238@charged.uio.no> <3E7B10DF.5070005@infratel.com> <15995.5996.446164.746224@charged.uio.no> <3E7B1DF9.2090401@infratel.com> <15995.10797.983569.410234@charged.uio.no> <3EC8DA1B.50304@infratel.com> <20030521102923.B17709@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030521102923.B17709@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, May 21, 2003 at 10:29:23AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 10:29:23AM +0100, Russell King wrote:
> On Mon, May 19, 2003 at 05:20:27PM +0400, Vladimir Serov wrote:
> > My current kernel is 2.4.21-pre6 based with patches from 2.4.19-rmk7 
> > applied (well partially, except ide and pci cause i don't have them, 
> > board is mostly brutus). I'm using HARD mounted nfs
> > volume now !!! The tail of dmesg is following.
> 
> Looking back on stuff which happened a long time ago, there's a
> possibility that there's an ordering issue with set_current_state.
> 
> Please note that this is affects _all_ 2.4 architectures.
> 
> I think this was discussed about 6 months ago, so I'm surprised this
> hasn't made it into the 2.4.2x kernel (or no one else has seen the
> problem.)

Yes, it was first discovered 7 months ago, but it seems Marcelo didn't
merge the fix:

> Date: Fri, 18 Oct 2002 23:00:58 -0400 (EDT)
> From: Nicolas Pitre <nico@cam.org>
> To: Marcelo Tosatti <marcelo@conectiva.com.br>
> Subject: [PATCH] set_task_state() UP memory barriers

Nicolas included a more complete fix which updates all 2.4 architectures.
Nico - could you re-send your fix please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

