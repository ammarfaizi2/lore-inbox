Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVCIOlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVCIOlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVCIOlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:41:15 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:25066 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261677AbVCIOk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:40:58 -0500
To: Moritz Muehlenhoff <jmm@inutil.org>, linux-kernel@vger.kernel.org
Subject: Re: Average power consumption in S3?
In-Reply-To: <20050309142612.GA6049@informatik.uni-bremen.de>
References: <20050309142612.GA6049@informatik.uni-bremen.de>
Date: Wed, 9 Mar 2005 14:40:50 +0000
Message-Id: <E1D92Mk-0006HD-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moritz Muehlenhoff <jmm@inutil.org> wrote:

> I'm using an IBM Thinkpad X31. With stock 2.6.11 and the additional
> radeontool to power-off the backlight in suspend, S3 works very well
> and reliable. During S3 I've measured a power consumption of 1400
> to 1500 mWh (using 512 megabytes of RAM). Is there still room for
> optimization? What's the typical amount of energy required for suspend-
> to-ram? From friends using iBooks with MacOS X I've heard that they
> left the notebook in suspend when leaving for a week and could still
> use it after return.

Radeons don't actually power down in D3 unless some registers are set,
and even then the kernel doesn't currently have any code that would put
the Radeon in D3. If you're willing to test something, could you try the
code at

http://www.srcf.ucam.org/~mjg59/radeon/

and do

radeontool power off

immediately before putting the machine into suspend? Make sure that you
do this from something other than X.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
