Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVAGMYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVAGMYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVAGMYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:24:46 -0500
Received: from colin2.muc.de ([193.149.48.15]:30988 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261385AbVAGMYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:24:36 -0500
Date: 7 Jan 2005 13:24:34 +0100
Date: Fri, 7 Jan 2005 13:24:34 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050107122434.GA64665@muc.de>
References: <3174569B9743D511922F00A0C9431423072912FA@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C9431423072912FA@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 06:53:11PM -0800, YhLu wrote:
> static unsigned int phys_pkg_id(int index_msb)
> {
>         return hard_smp_processor_id() >> index_msb;
> }
> 
> In arch/x86_64/kernel/genapic_cluster.c
> 
> Should be changed to 
> 
> static unsigned int phys_pkg_id(int index_msb)
> {
>         /* physical apicid, so we need to substract offset */
>         return (hard_smp_processor_id() - boot_cpu_id) >> index_msb;
> }

Why? 

If you want a patch merged you need to supply some more explanation
please.

Also cc Suresh & James for comment.

-Andi

