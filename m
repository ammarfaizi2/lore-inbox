Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUIAXV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUIAXV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268185AbUIAXVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:21:07 -0400
Received: from users.linvision.com ([62.58.92.114]:13022 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S267635AbUIAXOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:14:35 -0400
Date: Thu, 2 Sep 2004 01:14:34 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Romano Giannetti <romano@dea.icai.upco.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Driver retries disk errors.
Message-ID: <20040901231434.GD28809@bitwizard.nl>
References: <20040830163931.GA4295@bitwizard.nl> <1093952715.32684.12.camel@localhost.localdomain> <20040831135403.GB2854@bitwizard.nl> <1093961570.597.2.camel@localhost.localdomain> <20040831155653.GD17261@harddisk-recovery.com> <1093965233.599.8.camel@localhost.localdomain> <20040831170016.GF17261@harddisk-recovery.com> <1093968767.597.14.camel@localhost.localdomain> <20040901152817.GA4375@pern.dea.icai.upco.es> <1094049877.2787.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094049877.2787.1.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 03:44:38PM +0100, Alan Cox wrote:
> On Mer, 2004-09-01 at 16:28, Romano Giannetti wrote:
> > Just a question from a kernel-almost-illiterate. Could this explain the
> > behavior of my laptop yesterday, reading a damaged DVD? I had to wait almost
> > one full minute of retry until being able to kill xine... 
> 
> Thats the block layer. Its actually hard to fix the kill -9 case.

I don't think so. It starts with the ide-cd level driver 
doing 8 retries. Most disk we see retry themselves for about  a 
4 second delay before reporting a bad block. A CD taking twice
that much would not sound abnormal. (seeks are about 10 times
as expensive on CDs). 8 times 8 seconds is a full minute. 

	Roger.  

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
