Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTAXSzu>; Fri, 24 Jan 2003 13:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTAXSzt>; Fri, 24 Jan 2003 13:55:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:18133 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261907AbTAXSzt>;
	Fri, 24 Jan 2003 13:55:49 -0500
Date: Fri, 24 Jan 2003 11:05:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm5
Message-Id: <20030124110520.63e69314.akpm@digeo.com>
In-Reply-To: <20030124161729.GA15945@ncsu.edu>
References: <20030123195044.47c51d39.akpm@digeo.com>
	<20030124161729.GA15945@ncsu.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 19:04:55.0240 (UTC) FILETIME=[7B394480:01C2C3DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
>
> On Thu, Jan 23, 2003 at 07:50:44PM -0800, Andrew Morton wrote:
> >   So what anticipatory scheduling does is very simple: if an application
> >   has performed a read, do *nothing at all* for a few milliseconds.  Just
> >   return to userspace (or to the filesystem) in the expectation that the
> >   application or filesystem will quickly submit another read which is
> >   closeby.
> 
> Does this affect the faulting in of executable pages as well?
> 

Yes.  It should in theory decrease average major fault latency when there's
I/O load.  That is unproven.


