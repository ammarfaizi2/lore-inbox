Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVCIRMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVCIRMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVCIRMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:12:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37392 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262083AbVCIRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:12:37 -0500
Date: Wed, 9 Mar 2005 17:12:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
       amitg@calsoftinc.com, gud@eth.net
Subject: Re: [patch 1/1] unified spinlock initialization arch/um/drivers/port_kern.c
Message-ID: <20050309171231.H25398@flint.arm.linux.org.uk>
Mail-Followup-To: blaisorblade@yahoo.it, akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
	amitg@calsoftinc.com, gud@eth.net
References: <20050309094234.8FC0C6477@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050309094234.8FC0C6477@zion>; from blaisorblade@yahoo.it on Wed, Mar 09, 2005 at 10:42:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:42:33AM +0100, blaisorblade@yahoo.it wrote:
> 
> From: <domen@coderock.org>
> Cc: <user-mode-linux-devel@lists.sourceforge.net>, <domen@coderock.org>, <amitg@calsoftinc.com>, <gud@eth.net>
> 
> Unify the spinlock initialization as far as possible.

Are you sure this is really the best option in this instance?
Sometimes, static data initialisation is more efficient than
code-based manual initialisation, especially when the memory
is written to anyway.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
