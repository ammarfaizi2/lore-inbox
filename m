Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWB0LS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWB0LS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWB0LS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:18:57 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58266 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751159AbWB0LS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:18:57 -0500
Date: Mon, 27 Feb 2006 16:48:47 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 4/7] Add sysctl for delay accounting
Message-ID: <20060227111847.GC22492@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141028322.5785.60.camel@elinux04.optonline.net> <1141028784.2992.58.camel@laptopd505.fenrus.org> <4402BA93.5010302@watson.ibm.com> <1141029743.2992.71.camel@laptopd505.fenrus.org> <4402BF80.70005@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4402BF80.70005@watson.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But if task enumeration is going to get more difficult, we'll need to 
> keep the on-demand allocation (on
> next use) as a backup for tasks that weren't caught during the sysctl 
> change.
>

One possible issue with on-demand allocation is that under heavy load
allocation causes IO to happen and when we try to timestamp that IO, we
do not have a delays structure to do so.

Balbir
