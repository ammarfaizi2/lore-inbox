Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbTAXHlD>; Fri, 24 Jan 2003 02:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267588AbTAXHlD>; Fri, 24 Jan 2003 02:41:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30346 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267582AbTAXHlC>;
	Fri, 24 Jan 2003 02:41:02 -0500
Date: Fri, 24 Jan 2003 08:50:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Olien <dmo@osdl.org>, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, markw@osdl.org, cliffw@osdl.org,
       maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
Message-ID: <20030124075001.GE910@suse.de>
References: <20030123135448.A8801@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123135448.A8801@acpi.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23 2003, Dave Olien wrote:
> 
> Jens, Andrew
> 
> The group here doing dbt2 workload measurements have hit a couple of
> problems APPARENTLY in the block I/O scheduler when doing write-intensive
> raw disk I/O through a DAC960 extremeraid 2000 controller.
> This wasn't a problem in 2.5.49.  It has appeared since then.
> 
> I've filed a bug on the OSDL bugme database.  You can read it at:
> 
> 	http://bugme.osdl.org/show_bug.cgi?id=288
> 
> I've also put a more complete report in my web site:
> 
> 	http://www.osdl.org/archive/dmo/deadline_bugon.

A request got on the fifo, but not in the sort tree. This is most likely
an  alias. Ah yes I see it, it can happen when two requests are merged.
I'll be back with a fix for this soon.

-- 
Jens Axboe

