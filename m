Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWFMViR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWFMViR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWFMViR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:38:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8376 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932332AbWFMViQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:38:16 -0400
Subject: Re: more than 3 GB in userspace (4G/4G patch?) for 2.6.16
From: Dave Hansen <haveblue@us.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e6napj$3j0$1@terminus.zytor.com>
References: <448F207A.6080601@hanno.de>  <e6napj$3j0$1@terminus.zytor.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 14:37:01 -0700
Message-Id: <1150234621.20249.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 14:30 -0700, H. Peter Anvin wrote:
> > A 0.5/3.5 GB split appears to be what I need for my application.
> 
> That is incompatible with PAE.  The way PAE works, the split has to be
> an even number of gigabytes. 

Well, there have been ancient patches available in the past.  People pop
up now and again and ask for them.  This is _horribly_ out of date, but
it at least indicates that this is possible.

The basic idea is that you never share a kernel PMD page.  Each process
needs to allocate four of its own:

http://lkml.org/lkml/2003/5/9/138

-- Dave

