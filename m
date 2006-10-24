Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWJXPUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWJXPUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWJXPUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:20:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13985 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964903AbWJXPUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:20:51 -0400
Subject: Re: FDDI on Linux kernel 2.6
From: Lee Revell <rlrevell@joe-job.com>
To: Wouter de Waal <wrm@ccii.co.za>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.0.25.2.20061024131939.05e4de70@alpha.ccii.co.za>
References: <5.0.0.25.2.20061024131939.05e4de70@alpha.ccii.co.za>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 11:20:36 -0400
Message-Id: <1161703237.3982.81.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 13:19 +0200, Wouter de Waal wrote:
> The first customer eventually found that the driver does not work when
> the kernel is configured to use 64 bit memory addressing. This would
> obviously have to do with the pointer sizes used by the driver
> structure.
> 
> They did not need 64 bit addressing, and solved their problem by
> reconfiguring their kernel for 32 bit addressing.
> 
> Is it possible to configure things so that this issue is highlighted
> when the kernel is built?

Most drivers will work on 64 bit without modification.  If it's not
possible to make the driver 64 bit clean, then make it depend on
!X86_64 (and any other 64 bit platform the hardware might be used on).

Lee

