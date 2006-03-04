Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWCDLq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWCDLq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWCDLq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:46:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751487AbWCDLq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:46:26 -0500
Date: Sat, 4 Mar 2006 03:44:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: ak@muc.de, anemo@mba.ocn.ne.jp, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, johnstul@us.ibm.com,
       rth@twiddle.net
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
Message-Id: <20060304034449.3fd5e2fa.akpm@osdl.org>
In-Reply-To: <17417.32015.6281.253814@cargo.ozlabs.ibm.com>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
	<20060304.013153.71086081.anemo@mba.ocn.ne.jp>
	<20060304001834.0476e8e9.akpm@osdl.org>
	<20060304112010.GA94875@muc.de>
	<17417.32015.6281.253814@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Andi Kleen writes:
> 
> > Also I assume Atsushi-san did the patch because he saw a real problem?
> 
> Yes, one which I also saw on PPC.  The compiler (gcc-4) emits loads
> for jiffies, jiffies64 and wall_jiffies before storing the incremented
> jiffies64 value back.
> 

What was the effect of that?
