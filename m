Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTKFRx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTKFRxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:53:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27016 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263800AbTKFRxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:53:07 -0500
Date: Thu, 6 Nov 2003 17:53:06 +0000
From: Matthew Wilcox <willy@debian.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031106175306.GG26869@parcelfarce.linux.theplanet.co.uk>
References: <B179AE41C1147041AA1121F44614F0B060ED69@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B179AE41C1147041AA1121F44614F0B060ED69@AVEXCH02.qlogic.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 09:02:28AM -0800, Andrew Vasquez wrote:
> Hmm, looking through your email from July 18th, I note three main
> objections that have not been addressed:
> 
> 	o Build process -- (three module interface for the ISPs), I
> 	  personally like the idea of a shared library module used
> 	  between the different ISP drivers.  Many others have voiced
> 	  their frustrations with the single driver-binary for each
> 	  ISP type that the directive from management is to have a
> 	  single binary for all *future* products including the 
> 	  ISP23xx (ISP2300/ISP2310/ISP2312/ISP2322) chips.
> 
> 	  That unfortunately leaves ISP2100 and ISP2200 on the
> 	  periphery of development efforts.

I wouldn't see a problem with having a structure like this:

ql2100.c
ql2200.c
ql23xx.c
qllib.c

and linking in whichever files are selected.  But you definitely only want
to build qllib.c once.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
