Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUBIQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUBIQA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:00:26 -0500
Received: from mail0.lsil.com ([147.145.40.20]:46816 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S263909AbUBIQAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:00:25 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703D1A7C2@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <Emoore@lsil.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.25-rc1: Inconsistent ioctl symbol usage in drivers/messag
	e/fusion/mptctl.c
Date: Mon, 9 Feb 2004 10:58:58 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure I'm looking at it.


On Monday, February 09, 2004 5:27 AM, Marcelo Tosatti wrote:
> 
> Hi Eric,
> 
> Can you please fix this up?
> 
> On Mon, 9 Feb 2004, Keith Owens wrote:
> 
> > 2.4.25-rc1 drivers/message/fusion/mptctl.c expects sys_ioctl,
> > register_ioctl32_conversion and unregister_ioctl32_conversion to be
> > exported symbols when MPT_CONFIG_COMPAT is defined.  That symbol is
> > defined for __sparc_v9__, __x86_64__ and __ia64__.
> >
> > The symbols are not exported in ia64, mptctl.o gets 
> unresolved symbols
> > when it is a module on ia64.
> >
> > x64_64 exports register_ioctl32_conversion and 
> unregister_ioctl32_conversion,
> > but not sys_ioctl.
> 
