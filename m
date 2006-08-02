Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWHBEbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHBEbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWHBEbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:31:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:1525 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751145AbWHBEbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:31:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FAn4JFe5QZ2C9QMqV83+PDbXksUEDI9CN6pyX/EfJMa73jjvaLhO6v4V64S1xOZk1J+anewZ9e167mh5ZCLGC0ZQt1IVwqIDcQqCIjv8LCIwyziZPSeAxCRbvNTwmINGD4ehRHUHO/lB13UlZpKurZ+QByXuZPiiYR5So/aV2sk=
Message-ID: <4807377b0608012131mf160bc3iff724910191b521@mail.gmail.com>
Date: Tue, 1 Aug 2006 21:31:22 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: Linux v2.6.18-rc3
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Kernel development list" <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, cpufreq@www.linux.org.uk
In-Reply-To: <Pine.LNX.4.44L0.0607311627240.5805-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060731081112.05427677.akpm@osdl.org>
	 <Pine.LNX.4.44L0.0607311627240.5805-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 31 Jul 2006, Andrew Morton wrote:
>
> > core_initcall() would suit.  That's actually a bit late for this sort of
> > thing, but we can always add a new section later if it becomes a problem.
> > I'd suggest that we ensure that srcu_notifier_chain_register() performs a
> > reliable BUG() if it gets called too early.
>
> Here's a patch to test.  I can't try it out on my machine because
> 2.6.18-rc2-mm1 (even without the patch) crashes partway through a
> suspend-to-disk, in a way that's extremely hard to debug.  Some sort of
> spinlock-related bug occurs within ioapic_write_entry.

can't test because I also can't suspend or hibernate with rc2-mm1
(resume causes hard hang with the backlight and screen off)  The issue
i reported was against linus' 2.6.18-rc3 kernel.

patch didn't apply to 2.6.18-rc3.

Thanks,
  Jesse
