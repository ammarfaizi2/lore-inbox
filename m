Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWAEORt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWAEORt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWAEORt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:17:49 -0500
Received: from dpc6682004040.direcpc.com ([66.82.4.40]:47084 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751270AbWAEORs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:17:48 -0500
Date: Thu, 05 Jan 2006 09:17:15 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 12/15] via-pmu: Wrap some uses of sleep_in_progress	with
 proper ifdef's
In-reply-to: <1136403259.14273.17.camel@pismo>
To: Kristian Mueller <kernel@mput.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <1136470635.4430.52.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL00EOC96O6A@a34-mta01.direcway.com>
 <1136403259.14273.17.camel@pismo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 03:34 +0800, Kristian Mueller wrote:
> Hi Ben
> 
> On Mi, 2006-01-04 at 17:01 -0500, Ben Collins wrote:
> > Basically completes what's already in the rest of the driver.
> > sleep_in_progress is only defined for pm+ppc32.
> > 
> > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> 
> We've already found a different solution to this in the Linuxppc-dev
> list.
> 
> See:
>  http://patchwork.ozlabs.org/linuxppc/patch?id=3737

That patch makes no sense. It just moves the variable out of the ifdef,
but if CONFIG_PM or CONFIG_PPC32 is not enabled, then the variable never
gets modified, and so is always 0. Why not just wrap all the code that
uses it (like my patch did)?

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

