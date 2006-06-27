Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWF0QGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWF0QGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWF0QGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:06:17 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:62696 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1161134AbWF0QGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:06:16 -0400
Message-ID: <351424373.01759@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 28 Jun 2006 00:06:24 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New readahead - ups and downs
Message-ID: <20060627160624.GB6014@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	Helge Hafting <helge.hafting@aitel.hist.no>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44A12D84.5010400@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A12D84.5010400@aitel.hist.no>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

Thanks for testing it out.
I'll check it when I have time(I'll be out for a week...).

Wu

On Tue, Jun 27, 2006 at 03:07:16PM +0200, Helge Hafting wrote:
> Many have noticed positive sides of the new readahead system.
> I too see that, bootup is quicker and starting a big app like firefox is
> also noticeable faster.
> 
> I made my own little io-intensive test, that shows a case where
> performance drops.
> 
> I boot the machine, and starts "debsums", a debian utility that
> checksums every file managed by debian package management.
> As soon as the machine starts swapping, I also start
> start a process that applies an mm-patch to the kernel tree, and
> times this.
> 
> This patching took 1m28s with cold cache, without debsums running.
> With the 2.6.15 kernel (old readahead), and debsums running, this
> took 2m20s to complete, and 360kB in swap at the worst.
> 
> With the new readahead in 2.6.17-mm3 I get 6m22s for patching,
> and 22MB in swap at the most.  Runs with mm1 and mm2 were
> similiar, 5-6 minutes patching and 22MB swap.
> 
> My patching clearly takes more times this way.  I don't know
> if debsums improved though, it could be as simple as a fairness
> issue.  Memory pressure definitely went up.
> 
> 
> Helge Hafting
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
