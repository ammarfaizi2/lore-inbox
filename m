Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264827AbUEPVjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbUEPVjX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbUEPVjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 17:39:23 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:53439 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264827AbUEPVjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 17:39:21 -0400
Subject: Re: [patch] kill off PC9800
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <40A7DD0C.7010007@pobox.com>
References: <1084729840.10938.13.camel@mulgrave>
	<20040516142123.2fd8611b.akpm@osdl.org>  <40A7DD0C.7010007@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 May 2004 16:38:24 -0500
Message-Id: <1084743514.10765.22.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-16 at 16:28, Jeff Garzik wrote:
> Although I like deleting things as much as the next guy :) I do have a 
> question, to which I haven't come up with a good answer myself:
> 
> Should PC9800 be excised en masse, or just toss the obviously broken or 
> not-in-any-makefile/Kconfig pieces?
> 
> The PC9800 net driver stuff still seems to build, and be sane.

I haven't looked at the net stuff but if it's like the SCSI stuff, it's
only usable in a pc9800.  The vanilla kernel currently has no way to
select a pc9800 subarchitecture build.

This is a test of interest.  Since the pc9800 can't build the vanilla
kernel, is anyone maintaining the out of tree pieces to allow it to
build, and would they take on the job of maintaining it in-tree? if
no-one's interested in maintaining the pc9800 subarchitecture
components, it stands to reason that no-one is going to be compiling or
running the net or scsi drivers, so there's no point keeping them
hanging around.  Thus, if one piece goes, they all should.

James


