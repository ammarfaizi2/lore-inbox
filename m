Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVCPWmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVCPWmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVCPWmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:42:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:63708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262838AbVCPWlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:41:40 -0500
Date: Wed, 16 Mar 2005 14:41:17 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com
Subject: Re: [patch] Syscall auditing - move "name=" field to the end
Message-ID: <20050316224117.GC28536@shell0.pdx.osdl.net>
References: <4238A65C.7020908@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4238A65C.7020908@rainbow-software.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ondrej Zary (linux@rainbow-software.org) wrote:
> This patch moves the "name=" field to the end of audit records. The 
> original placement is bad because it cannot be properly parsed. It is 
> impossible to tell if the name is "/bin/true" or "/bin/true inode=469634 
> dev=00:00" because the "inode=" and "dev=" fields can be omitted.
> 
> Before:
> audit(1111008486.824:89346): item=0 name=/bin/true inode=469634 dev=00:00
> 
> After:
> audit(1111008486.824:89346): item=0 inode=469634 dev=00:00 name=/bin/true
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Looks reasonable.  Thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
