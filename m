Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWCWICJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWCWICJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWCWICJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:02:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39859 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030192AbWCWICI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:02:08 -0500
Subject: Re: [PATCH] Try 3, Fix release function in IPMI device model
From: Arjan van de Ven <arjan@infradead.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Yani Ioannou <yani.ioannou@gmail.com>, greg@kroah.com,
       dtor_core@ameritech.net, rmk+lkml@arm.linux.org.uk
In-Reply-To: <20060322231947.GA22494@i2.minyard.local>
References: <20060322231947.GA22494@i2.minyard.local>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 09:02:01 +0100
Message-Id: <1143100922.3147.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 17:19 -0600, Corey Minyard wrote:
> I didn't get any comments on this, so I assume it is correct.
> I fixed the spelling of Arjan's name (profuse apologies) in
> this version, but otherwise it is the same.
> 
> I'm sorry to cause so much trouble with this.
> 
> -Corey
> 
> 
> 
> Arjan van de Ven pointed out that the changeover to the driver model
> in the IPMI driver had some bugs in it dealing with the release
> function and cleanup.  Then Russell King pointed out that you can't
> put release functions in the same module as the unregistering code.
> 
> This patch fixes those problems and also adds a semaphore around the
> BMC functions and converts the BMC counter to a kref, which I meant to
> do earlier, but didn't write down :(.


please use a mutex not a semaphore... semaphores for mutex code are
deprecated

