Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbWFIFuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWFIFuu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWFIFut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:50:49 -0400
Received: from mx1.suse.de ([195.135.220.2]:36550 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965221AbWFIFut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:50:49 -0400
From: Andi Kleen <ak@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: Using netconsole for debugging suspend/resume
Date: Fri, 9 Jun 2006 07:50:25 +0200
User-Agent: KMail/1.9.3
Cc: auke-jan.h.kok@intel.com, jeremy@goop.org, mpm@selenic.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060608210702.GD24227@waste.org> <4489038C.3050901@intel.com> <20060608.222352.59657133.davem@davemloft.net>
In-Reply-To: <20060608.222352.59657133.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606090750.25067.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 June 2006 07:23, David Miller wrote:
> From: Auke Kok <auke-jan.h.kok@intel.com>
> Date: Thu, 08 Jun 2006 22:13:48 -0700
> 
> > netconsole should retry. There is no timeout programmed here since that might
> > lose important information, and you rather want netconsole to survive an odd
> > unplugged cable then to lose vital debugging information when the system is
> > busy for instance. (losing link will cause the interface to be down and thus
> > the queue to be stopped)
> 
> I completely disagree that netpoll should loop when the ethernet
> cable is plugged out. 

Currently it is a bit dumb and doesn't distingush the various cases
well.

I submitted a patch to loop to be a bit more clever at some point. It can be still
found in the netdev archives.

-Andi
