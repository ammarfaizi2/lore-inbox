Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030607AbWFOPFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030607AbWFOPFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWFOPFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:05:52 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:20361 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030607AbWFOPFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:05:51 -0400
Date: Thu, 15 Jun 2006 08:05:27 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: frode isaksen <frode.isaksen@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: sys_poll with timeout -1 bug fix
Message-ID: <20060615150527.GN11131@us.ibm.com>
References: <542727CE-8E10-44EB-98E7-15481DE45259@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542727CE-8E10-44EB-98E7-15481DE45259@gmail.com>
X-Operating-System: Linux 2.6.17-rc6 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2006 [15:05:00 +0200], frode isaksen wrote:
> If you do a poll() call with timeout -1, the wait will be a big  
> number (depending on HZ)  instead of infinite wait, since -1 is  
> passed to the msecs_to_jiffies function.
> Tested on i386 and MIPS with latest (2.6.16) kernel.

This looks very close to a fix I have on my machine, as well, after
looking at sys_poll() a bit. I suppose the only times you would notice
are if an application actually wants as long a wait as possible, as
opposed to a very long one.

Your patch was line-wrapped and does not have a Signed-off-by line,
however. Care to try again?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
