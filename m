Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263333AbVGORvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbVGORvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbVGORu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:50:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:42722 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263333AbVGORu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:50:58 -0400
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Joel Becker <jlbec@evilplan.org>
Cc: Tejun Heo <htejun@gmail.com>, Daniel McNeil <daniel@osdl.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050715165616.GH16877@parcelfarce.linux.theplanet.co.uk>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>
	 <42D70318.1000304@gmail.com> <42D74724.8000703@us.ibm.com>
	 <20050715165616.GH16877@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 10:50:46 -0700
Message-Id: <1121449846.6755.91.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 17:56 +0100, Joel Becker wrote:
> On Thu, Jul 14, 2005 at 10:18:28PM -0700, Badari Pulavarty wrote:
> > I can imagine a reason for relaxing the alignment. I keep getting asked
> > whether we can do "O_DIRECT mount option".  Database folks wants to
> > make sure all the access to files in a given filesystem are O_DIRECT
> 
> 	All currently existing "O_DIRECT mount option" implementations
> that I know of do:
> 
> 	if (not-512-aligned)
> 		bounce_buffer()
> 
> That is, no one attempts to support the wacky variations in DMA engines.


I believe some OSs do buffered IO, if there is a problem with alignment.

Thanks,
Badari

