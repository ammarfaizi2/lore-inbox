Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752599AbVHGTPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbVHGTPs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbVHGTPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:15:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19474 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752599AbVHGTPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:15:47 -0400
Date: Sun, 7 Aug 2005 20:15:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: EXPORT_SYMBOL generates "is deprecated" noise
Message-ID: <20050807201541.D22977@flint.arm.linux.org.uk>
Mail-Followup-To: "Martin J. Bligh" <mbligh@mbligh.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <251790000.1123438079@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <251790000.1123438079@[10.10.2.4]>; from mbligh@mbligh.org on Sun, Aug 07, 2005 at 11:07:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 11:07:59AM -0700, Martin J. Bligh wrote:
> I'm getting lots of errors like this nowadays:
> 
> drivers/serial/8250.c:2651: warning: `register_serial' is deprecated 
> (declared at drivers/serial/8250.c:2607)
> 
> Which is just: "EXPORT_SYMBOL(register_serial);"
> 
> Sorry, but that's just compile-time noise, not anything useful.
> Warning on real usages of it might be handy (we can go fix the users)
> but not EXPORT_SYMBOL - we can't kill the export until the function
> goes away. The more noise we have, the harder it is to see real errors 
> and warnings.

I don't know why I bother with __deprecated - I haven't seen much
evidence of the users of these functions being cleaned up, so I
think we might as well just delete the functions and _force_ people
to fix their code.  That unfortunately seems to be the only way to
get things done in this day and age, which is rather sad if that's
what it takes to kick people into action.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
