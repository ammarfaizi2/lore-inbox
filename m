Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUJEOAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUJEOAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269829AbUJEOAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:00:05 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:50603 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269758AbUJEN4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:56:36 -0400
Subject: Re: Core scsi layer crashes in 2.6.8.1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Anton Blanchard <anton@samba.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041005114951.GD22396@krispykreme.ozlabs.ibm.com>
References: <1096401785.13936.5.camel@localhost.localdomain>
	<1096467125.2028.11.camel@mulgrave> 
	<20041005114951.GD22396@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 Oct 2004 08:56:22 -0500
Message-Id: <1096984590.1765.2.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 06:49, Anton Blanchard wrote:
> 
> Hi James,
> 
> > These state transition warnings are currently expected in this code
> > (they're basically verbose warnings).
> > 
> > What was the oops?
> > 
> > I have a theory that we should be taking a device reference before
> > waking up the error handler, otherwise host removal can race with error
> > handling.
> 
> Did this get sorted out? Here is an oops from a few week old BK tree.
> FYI I just noticed I have disabled host reset in the sym2 driver (it
> was locking up at the time and I never went back to work out why).
> However, even with a host reset this could happen right?

Well, the theoretical hole is fixed ... If you test the current tree
we'll find out if this is indeed your problem.

James


