Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWAFBXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWAFBXF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWAFBXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:23:04 -0500
Received: from 62.4.70.142.eliott-ness.com ([62.4.70.142]:61581 "HELO mput.de")
	by vger.kernel.org with SMTP id S1750716AbWAFBXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:23:02 -0500
Subject: Re: [PATCH 12/15] via-pmu: Wrap some uses of
	sleep_in_progress	with proper ifdef's
From: Kristian Mueller <kernel@mput.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1136470635.4430.52.camel@grayson>
References: <0ISL00EOC96O6A@a34-mta01.direcway.com>
	 <1136403259.14273.17.camel@pismo>  <1136470635.4430.52.camel@grayson>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 01:22:56 +0800
Message-Id: <1136481777.3735.18.camel@pismo>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben

On Do, 2006-01-05 at 09:17 -0500, Ben Collins wrote: 
> On Thu, 2006-01-05 at 03:34 +0800, Kristian Mueller wrote:
> > We've already found a different solution to this in the Linuxppc-dev
> > list.
> > 
> > See:
> >  http://patchwork.ozlabs.org/linuxppc/patch?id=3737
> 
> That patch makes no sense. It just moves the variable out of the ifdef,
> but if CONFIG_PM or CONFIG_PPC32 is not enabled, then the variable never
> gets modified, and so is always 0. Why not just wrap all the code that
> uses it (like my patch did)?

I had quite the same approach in mind but as Olof Johansson remarked in
http://patchwork.ozlabs.org/linuxppc/patch?id=3736 this would just
introduce more unnecessary #ifdefs.


Regards,
Kristian

