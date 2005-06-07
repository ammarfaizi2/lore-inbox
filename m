Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVFGX4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVFGX4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 19:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVFGX4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 19:56:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:37845 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262043AbVFGX4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 19:56:16 -0400
Date: Tue, 7 Jun 2005 16:56:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.12-rc6-mm1
Message-Id: <20050607165656.2517b417.akpm@osdl.org>
In-Reply-To: <1004450000.1118188239@flay>
References: <1004450000.1118188239@flay>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> Wheeee! it actually compiles and boots for me on x86 ;-)

We aim to please.

> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.moe.png
> 
> Seems to show that perf is rather sucky on kernbench though.

CPU scheduler.

> baseline (-rc6) data is here:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/4760/kernbench.test/
> 
> -mm1 is here:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/4876/kernbench.test/
> 
> Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).

Oh crap, so it does.  That's wrong.

> If I factor it by 4x, I get:

Would it be possible to set it back to 100Hz, retest?
