Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267422AbUBSR1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267437AbUBSR1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:27:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:41126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267422AbUBSR1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:27:17 -0500
Date: Thu, 19 Feb 2004 09:27:08 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: netdev@oss.sgi.com
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org
Subject: Re: [NET] 64 bit byte counter for 2.6.3
Message-Id: <20040219092708.1935e684@dell_ss3.pdx.osdl.net>
In-Reply-To: <E1AtjKh-0006Bz-Ee@rhn.tartu-labor>
References: <20040218101711.25dda791@dell_ss3.pdx.osdl.net>
	<E1AtjKh-0006Bz-Ee@rhn.tartu-labor>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 10:14:55 +0200
Meelis Roos <mroos@linux.ee> wrote:

> SH>  * Network changes gets discussed on netdev@oss.sgi.com 
> SH>  * 64 bit values are not atomic on 32 bit architectures 
> 
> Agree.
> 
> SH>  * wider values in /proc output risks breaking apps like ifconfig and netstat
> 
> This is probably not a problem here, ifconfig etc have been working fine
> with non-wrapping numbers on sparc64 and other 64-bit machines.

Looking at current net-tools source, they are doing sscanf into a long-long-unsigned
value already.

