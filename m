Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUGGRCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUGGRCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUGGRCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:02:11 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:51142 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265233AbUGGRCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:02:02 -0400
Date: Wed, 7 Jul 2004 13:04:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Davide Rossetti <davide.rossetti@roma1.infn.it>,
       linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
In-Reply-To: <40EBF07B.8040003@hist.no>
Message-ID: <Pine.LNX.4.58.0407071302490.23212@montezuma.fsmlabs.com>
References: <200407011215.59723.bjorn.helgaas@hp.com>
 <20040701115339.A4265@unix-os.sc.intel.com> <40EBED33.3050707@roma1.infn.it>
 <40EBF07B.8040003@hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Helge Hafting wrote:

> Davide Rossetti wrote:
>
> > Rajesh Shah wrote:
> >
> >> What type of usage model did you have in mind to have the
> >>
> >> device write to memory instead of using MSI for interrupts?
> >>
> >>
> > for instance for a fast wake-up trick. the driver loops on a memory
> > location until the MSI write access changes the memory content...
>
> Won't that put a bad load on the bus?  Someone else might need it:
> * Another cpu in a smp system
> * Any device doing bus-master transfers, even in a UP system
>
> That polling loop had better be guaranteed to be _very_ short.

mwait/monitor is best suited for such things and doesn't result in
pounding on memory. Considering the box has MSI, there is a higher
possibility of it also having the mwait/monitor instructions.

	Zwane

