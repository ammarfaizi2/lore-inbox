Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVBPFZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVBPFZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVBPFZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:25:10 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:44160 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261988AbVBPFZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:25:04 -0500
Date: Wed, 16 Feb 2005 06:25:03 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc4
Message-ID: <20050216052503.GA24484@mail.13thfloor.at>
Mail-Followup-To: Andrea Arcangeli <andrea@cpushare.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050121100606.GB8042@dualathlon.random> <20050215093244.GU13712@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215093244.GU13712@opteron.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 10:32:44AM +0100, Andrea Arcangeli wrote:
> Hello,
> 
> This is the latest version against 2.6.11-rc4:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.11-rc4/seccomp
> 
> I'd need it merged into mainline at some point, unless anybody has
> strong arguments against it. All I can guarantee here, is that I'll back
> it out myself in the future, iff Cpushare will fail and nobody else
> started using it in the meantime for similar security purposes.

hmm, just an idea, but have you thought about using
an indirect syscall table for your purposes?

 current->syscall_table 

and have a table for every 'mode' you want to use ...

or maybe have a 'mask' for every syscall (in a 
separate table) which describes the allowed 'modes'

just because checking the syscall number in a loop
doesn't look very scaleable to me ... 

best,
Herbert

> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
