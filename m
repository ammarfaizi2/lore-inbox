Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264011AbUCZKyI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUCZKyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:54:08 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:59490 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264011AbUCZKyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:54:05 -0500
Date: Fri, 26 Mar 2004 04:49:47 -0600
From: Robin Holt <holt@sgi.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Large memory application exhuasts buffers during write.
Message-ID: <20040326104947.GD14360@lnx-holt>
References: <20040326012056.GB19152@lnx-holt> <200403261247.10807.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403261247.10807.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 12:47:10PM +0200, Denis Vlasenko wrote:
> On Friday 26 March 2004 03:20, Robin Holt wrote:
> > We have a large memory application which is being killed by the OOM
> > killer.
> >
> > This is a 2.4 based kernel with many of the redhat patches applied.
> > Before the application is started, there is approx 350GB of memory
> > free according to top.  When the app starts, it mallocs a 300GB
> > buffer, initializes it, does computations into it, and then starts
> > to write it to a disk file.
> >
> > What we see happen is the first approx 30GBs gets written and then
> > swap starts getting utilized.  Once swap has been heavily utilized,
> > the OOM killer kicks in and kills the job.
> 
> How many swap do you have? What do you see in top?

I am not sure how much swap is configured or available, but I
highly doubt that there is 350GB of swap.

Robin
