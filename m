Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUD2PdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUD2PdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbUD2PdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:33:06 -0400
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:57543 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262438AbUD2PdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:33:03 -0400
Subject: Re: [PATCH 2.6.6-rc3] as-io isolation ?
From: FabF <Fabian.Frederick@skynet.be>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <40904EAA.6010501@yahoo.com.au>
References: <1083183861.4618.13.camel@bluerhyme.real3>
	 <40904EAA.6010501@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1083253117.4624.3.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 17:38:37 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx012.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 02:39, Nick Piggin wrote:
> FabF wrote:
> > Hi,
> > 
> > 	Here's a patch _idea_ to isolate anticipatory I/O from normal I/O
> > scheduler process by adding a specific put io context method so that
> > ll_rw_blk stuff could be as-iosched transparent.I guess we could point
> > as iosched exit instead of exit_io_context as well ...
> 
> Hi,
> This makes ll_rw_blk.c aware of an AS specific function though.
> as-iosched.c is actually a CONFIG option under CONFIG_EMBEDDED.
> What is the actual problem?

AFAICS cfq and other elevators don't interact with ll_rw stuff (?)
but we could release something like the asio later so I was thinking
about somekind of abstraction within ll_rw.This abstraction would
require the patch ad hoc as well as a specific exit point.

FabF

> Nick
> 

