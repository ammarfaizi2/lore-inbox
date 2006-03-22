Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWCVPDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWCVPDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCVPDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:31 -0500
Received: from ns.suse.de ([195.135.220.2]:63135 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750993AbWCVPD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:29 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 16/35] subarch support for interrupt and exception gates
Date: Wed, 22 Mar 2006 14:45:46 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063752.437169000@sorel.sous-sol.org>
In-Reply-To: <20060322063752.437169000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221445.46490.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:30, Chris Wright wrote:
> Abstract the code that sets up interrupt and exception gates, and
> add a separate subarch implementation for Xen.

AFAIK the only difference is that Xen uses a table of them to pass
the hypervisor and normal Linux calls the macros directly, right?

I would suggest you just use the table for normal Linux too
and make the function that processes them natively !CONFIG_XEN
I guess it will make the code smaller for the normal case and people happy.

That would be much cleaner than just separating it out.

-Andi

