Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVCVHAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVCVHAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVCVG7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:59:03 -0500
Received: from mx1.suse.de ([195.135.220.2]:25233 "EHLO mail.suse.de")
	by vger.kernel.org with ESMTP id S262195AbVCVG4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:56:46 -0500
Date: Tue, 22 Mar 2005 07:56:42 +0100
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with w6692 & kernel >=2.6.10
Message-ID: <20050322065642.GL30742@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <dd02451d050303132662482b66@mail.gmail.com> <20050321142823.672f0749.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321142823.672f0749.akpm@osdl.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 02:28:23PM -0800, Andrew Morton wrote:
> Marko Rebrina <mrebrina@gmail.com> wrote:
> >
> > I have problem with w6692 (mISDN-2005-02-25) & kernel >=2.6.10 (with
> > 2.6.9 is OK!) 
> 
> There haven't been any changes in the w6692 driver for ages, so I'd be
> suspecting PCI changes or something like that.  Are you able to test
> 2.6.12-rc1?
> 

Marko do not point to the in kernel w6692 driver, but to the (still ALPHA)
mISDN driver from cvs.isdn4linux.de.
This driver had a problem with the pci_register_driver return code changes
in 2.6.10, it now always returns 0 (if no error), but < 2.6.10 did return
the number of detected devices, which was tested in this driver.
This is fixed since last week in our CVS.

-- 
Karsten Keil
SuSE Labs
ISDN development
