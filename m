Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267767AbTAXPoI>; Fri, 24 Jan 2003 10:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267765AbTAXPoI>; Fri, 24 Jan 2003 10:44:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267761AbTAXPoG>;
	Fri, 24 Jan 2003 10:44:06 -0500
Date: Fri, 24 Jan 2003 07:53:11 -0800
From: Dave Olien <dmo@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, markw@osdl.org,
       cliffw@osdl.org, maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
Message-ID: <20030124075311.B10818@acpi.pdx.osdl.net>
References: <20030123135448.A8801@acpi.pdx.osdl.net> <20030124075001.GE910@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124075001.GE910@suse.de>; from axboe@suse.de on Fri, Jan 24, 2003 at 08:50:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



OK, I was able to reproduce at least the problem with I/O apparently
never completing on my smaller test machine.  I've been assuming this
was related to whatever was causing the BUG_ON().  But in case it
isn't, I'm going to continue to look into what's going on on the running
system and I'll let you know what I find.

In the mean time, once you've generated a patch, I'll give it a try
as soon as I get it.  I'll also pass it on to the dbt2 workload guys.

On Fri, Jan 24, 2003 at 08:50:01AM +0100, Jens Axboe wrote:
> 
> A request got on the fifo, but not in the sort tree. This is most likely
> an  alias. Ah yes I see it, it can happen when two requests are merged.
> I'll be back with a fix for this soon.
> 
> -- 
> Jens Axboe
> 
