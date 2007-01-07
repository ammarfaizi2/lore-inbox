Return-Path: <linux-kernel-owner+w=401wt.eu-S964819AbXAGSHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbXAGSHU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbXAGSHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:07:20 -0500
Received: from ms-smtp-01.ohiordc.rr.com ([65.24.5.135]:56895 "EHLO
	ms-smtp-01.ohiordc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964819AbXAGSHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:07:17 -0500
Subject: Re: PROBLEM: LSIFC909 mpt card fails to recognize devices
From: Justin Rosander <myrddinemrys@neo.rr.com>
To: Eric Moore <eric.moore@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20070105035526.GA14185@lsil.com>
References: <1167955606.5133.13.camel@localhost>
	 <20070104165922.137c6df9.akpm@osdl.org>  <20070105035526.GA14185@lsil.com>
Content-Type: text/plain; charset=utf-8
Date: Sun, 07 Jan 2007 13:07:07 -0500
Message-Id: <1168193227.4458.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,
I tried recompiling the kernel per your instructions, but I got a
failure here:
          CC [M]  drivers/message/fusion/mptbase.o
        drivers/message/fusion/mptbase.c: In function ‘mpt_resume’:
        drivers/message/fusion/mptbase.c:1526: warning: ignoring return value of ‘pci_enable_device’, declared with attribute warn_unused_result
          CC [M]  drivers/message/fusion/mptscsih.o
        drivers/message/fusion/mptscsih.c: In function ‘mptscsih_initTarget’:
        drivers/message/fusion/mptscsih.c:2691: error: ‘lun’ undeclared (first use in this function)
        drivers/message/fusion/mptscsih.c:2691: error: (Each undeclared identifier is reported only once
        drivers/message/fusion/mptscsih.c:2691: error: for each function it appears in.)
        make[4]: *** [drivers/message/fusion/mptscsih.o] Error 1
        make[3]: *** [drivers/message/fusion] Error 2
        make[2]: *** [drivers/message] Error 2
        make[1]: *** [drivers] Error 2

Did I do something wrong?
Regards,
Justin

On Thu, 2007-01-04 at 20:55 -0700, Eric Moore wrote:
> On Thu, Jan 04, 2007 at 04:59:22PM -0800, Andrew Morton wrote:
> > On Thu, 04 Jan 2007 19:06:46 -0500
> > Justin Rosander <myrddinemrys@neo.rr.com> wrote:
> > 
> > > Please forward this to the appropriate maintainer.  Thank you.
> > > 
> > > [1.] One line summary of the problem:    My fibre channel drives fail to
> > > be recognized by my LSIFC909 card. 
> > 
> > Please send the output of `lspci -vn'
> > -
> 
> Recompile the driver with MPT_DEBUG_INIT enabled in the driver Makefile,
> and repost the output.
> 
> Eric Moore

