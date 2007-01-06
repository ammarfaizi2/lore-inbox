Return-Path: <linux-kernel-owner+w=401wt.eu-S1751434AbXAFQzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXAFQzx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 11:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXAFQzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 11:55:53 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:56712 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbXAFQzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 11:55:53 -0500
Subject: Re: + paravirt-vmi-timer-patches.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: mm-commits@vger.kernel.org, zach@vmware.com, ak@suse.de,
       chrisw@sous-sol.org, jeremy@xensource.com, rusty@rustcorp.com.au
In-Reply-To: <200612152227.kBFMRNuQ002977@shell0.pdx.osdl.net>
References: <200612152227.kBFMRNuQ002977@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 08:54:51 -0800
Message-Id: <1168102492.26086.215.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 14:27 -0800, akpm@osdl.org wrote:
> +
> +unsigned long long vmi_sched_clock(void)
> +{
> +       return read_available_cycles();
> +}
> + 


This sched_clock is likely broken if it's returning something other than
nanoseconds. It looks like cycles, but it's also getting piped through
an ops pointer so I'm not sure what's getting returned here.

Daniel

