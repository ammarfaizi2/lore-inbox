Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266441AbUFUUDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbUFUUDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUFUUDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:03:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64473 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266441AbUFUUDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:03:45 -0400
Date: Mon, 21 Jun 2004 16:56:50 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Ramy M. Hassan" <ramy@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd problem
Message-ID: <20040621195650.GA13944@logos.cnet>
References: <20040612153247.13279.qmail@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040612153247.13279.qmail@gawab.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2004 at 03:32:47PM +0000, Ramy M. Hassan wrote:
> 
> kswapd and kupdated are causing our production server to
> completely freezeup for few seconds every now and then.
> The server is running kernel 2.4.26SMP on a Dual Xeon 2.20GHz
> with 4GB RAM, 900GB FC RAID Qlogic HBA using driver qla2300.o
> and reiserfs.
> The RAID filesystem contains millions of files in thousands of
> directories.
> The system is under fair load. Normally the load avarage is
> about 3 and everything works properly, but suddenly the system
> stops responding except to ping, and stay freezed for about 20
> seconds, during that time I can not even type anything, then the
> system becomes responsive again and I see the load avarge over
> 250 and starts to decrease till it is back to 3 , then few
> minutes later that same thing is repeated.
> I noticed that at the time of the freezups both kswapd and
> kupdated are the most active processes each consuming over 30%
> of the CPU ( kswapd is usually more than kupdated )

Hi Ramy,

Can you get us some more data when this happens?

What are the size's of the page lists (/proc/meminfo) when the freeze happens, 
can you capture that?

Also leave vmstat running in the background.

If you are willing to debug I'm sure we will be able to find the 
reason for the problem.


