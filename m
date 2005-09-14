Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVINXqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVINXqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 19:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVINXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 19:46:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030299AbVINXqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 19:46:47 -0400
Date: Wed, 14 Sep 2005 16:46:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: izvekov@lps.ele.puc-rio.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata sata_sil broken on 2.6.13.1
Message-Id: <20050914164637.01f0fff5.akpm@osdl.org>
In-Reply-To: <60703.200.141.106.169.1126730160.squirrel@correio.lps.ele.puc-rio.br>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
	<60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
	<60703.200.141.106.169.1126730160.squirrel@correio.lps.ele.puc-rio.br>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

izvekov@lps.ele.puc-rio.br wrote:
>
> > So that means the irq triggered, but there where no handlers? Also, this
> > seems a non-critical fault, why whould the machine lock?
> 
> If i use the irqpoll boot option, then it is fine, it boots with no errors
> at all, and i can even mount a filesystem on that PATA hd.
> 

Good.  Now can you please generate the output from `dmesg -s 1000000' for
both good and bad kernels, then do

	diff -u dmesg.good dmesg.bad

and send the result?  Make sure to identify both kernel versions.

Thanks.
