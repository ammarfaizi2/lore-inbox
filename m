Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVCKT7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVCKT7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVCKT5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:57:24 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:62888 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261500AbVCKTse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:48:34 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Average power consumption in S3?
Date: Fri, 11 Mar 2005 20:49:16 +0100
User-Agent: KMail/1.7.2
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Moritz Muehlenhoff <jmm@inutil.org>
References: <20050309142612.GA6049@informatik.uni-bremen.de> <E1D92Mk-0006HD-00@chiark.greenend.org.uk>
In-Reply-To: <E1D92Mk-0006HD-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503112049.16782.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 15:40, Matthew Garrett wrote:
> Moritz Muehlenhoff <jmm@inutil.org> wrote:
> > I'm using an IBM Thinkpad X31. With stock 2.6.11 and the additional
> > radeontool to power-off the backlight in suspend, S3 works very well
> > and reliable. During S3 I've measured a power consumption of 1400
> > to 1500 mWh (using 512 megabytes of RAM). Is there still room for
> > optimization? What's the typical amount of energy required for suspend-
> > to-ram? From friends using iBooks with MacOS X I've heard that they
> > left the notebook in suspend when leaving for a week and could still
> > use it after return.
>
> Radeons don't actually power down in D3 unless some registers are set,
> and even then the kernel doesn't currently have any code that would put
> the Radeon in D3. If you're willing to test something, could you try the
> code at
>
> http://www.srcf.ucam.org/~mjg59/radeon/
>
> and do
>
> radeontool power off
>
> immediately before putting the machine into suspend? Make sure that you
> do this from something other than X.

Small question, can this tool do what the boot-radeon tool can? That way I can 
scrap another one in my suspend-to-ram tricks ;p

Jan

-- 
  I tripped over a hole that was sticking up out of the ground.
