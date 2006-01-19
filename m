Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWASJgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWASJgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWASJgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:36:35 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:55181 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751386AbWASJge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:36:34 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Out of Memory: Killed process 16498 (java).
Date: Thu, 19 Jan 2006 20:36:20 +1100
User-Agent: KMail/1.9
Cc: "Andy Chittenden" <AChittenden@bluearc.com>, linux-kernel@vger.kernel.org
References: <89E85E0168AD994693B574C80EDB9C2703555F85@uk-email.terastack.bluearc.com> <20060119005600.4e465e9d.akpm@osdl.org>
In-Reply-To: <20060119005600.4e465e9d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601192036.20355.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 January 2006 19:56, Andrew Morton wrote:
> "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> > Why does running the following command cause processes to be killed:
> >
> > 	dd if=/dev/zero of=/u/u1/andyc/tmpfile bs=1M count=8k
> >
> > And I noticed one of my windows disappeared. Further investigation
> > showed that was my terminator window (java based app: see
> > http://software.jessies.org/terminator/). I found this in my syslog:
> >
> > Jan 17 11:12:58 boco kernel: Out of Memory: Killed process 16498 (java).
> >
> > My hardware: amd64 based machine (ASUS A8V Deluxe motherboard) with 4Gb
> > of memory.
> > My kernel: debian package linux-image-2.6.15-1-amd64-k8 package
> > installed. IE its running 2.6.15 compiled for amd64.
> >
> > This is repeatable. The above dd command also causes the machine to
> > become very unresponsive (eg windows don't focus).
>
> What type of filesytem is being written to?
>
> Has someone tuned /proc/sys/vm/swappiness, or something else under
> /proc/sys/vm?
>
> It'd be useful to see the dmesg output from that oom event.

Are you using scsi? Someone just posted what looks to be a scsi slab leak (Re: 
scsi cmd slab leak? (Was Re: [ck] Anyone been having OOM killer problems 
lately?) that causes oom kills. Check your slabinfo for a large 
scsi_cmd_cache.

Cheers,
Con
