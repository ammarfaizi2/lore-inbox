Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWJEXdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWJEXdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWJEXdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:33:05 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:35771 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751457AbWJEXdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:33:02 -0400
Subject: Re: 2.6.18-mm2 boot failure on x86-64 II
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: mel gorman <mel@csn.ul.ie>, Vivek goyal <vgoyal@in.ibm.com>,
       Steve Fox <drfickle@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <200610060114.03466.ak@suse.de>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <Pine.LNX.4.64.0610052128570.29014@skynet.skynet.ie>
	 <200610052251.31571.ak@suse.de>  <200610060114.03466.ak@suse.de>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 05 Oct 2006 16:32:58 -0700
Message-Id: <1160091179.5664.17.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 01:14 +0200, Andi Kleen wrote:
> On Thursday 05 October 2006 22:51, Andi Kleen wrote:
> > 
> > > hmm, rather than bugging you with patches now, I'll see what I can find 
> > > with the x86_64 machines I have access to and see can I reproduce it.
> > 
> > I started the bisect, should finish soon.
> 
> It ended at 
> 
> diff-tree d5cdb67236dba94496de052c9f9f431e1fc658f4 (from 0dad3510ee82bcf8a380b81
> a2184a664a911ef9c)
> Author: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
> Date:   Tue Sep 12 10:19:00 2006 -0700
> 
>     acpiphp: disable bridges
>     
>     Currently acpiphp calls pci_enable_device() against all
>     hot-added bridges, but acpiphp does not call pci_disable_device()
>     against them in hot-remove. So ioapic hot-remove would fail.
>     This patch fixes this issue.
> 
> Not sure that is it really, it is possible i made a mistake during bisect
> (the symptoms changed from bad page to just networking doesn't work
> somewhere at 4cfee88ad30acc47f02b8b7ba3db8556262dce1e) 
> 
> I don't have time to rerun unfortunately
> for some time. Anyone else looking would be useful.

As of yet I haven't been able to recreate the hang.  I am running
similar HW to Steve. 

Thanks,
  Keith 

