Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWFUJYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWFUJYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWFUJYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:24:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:26816 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932494AbWFUJYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:24:35 -0400
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-x64-smp-multiprocessor-time util problem
References: <20060619180413.qlgd1oj9etmosckg@69.222.0.225>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2006 11:24:30 +0200
In-Reply-To: <20060619180413.qlgd1oj9etmosckg@69.222.0.225>
Message-ID: <p734pyeq2sx.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

art@usfltd.com writes:

> on dual core amd-athlon under 64bit-smp core
> 
> kernel compilation time:
> 
> time make -j 8
> ...
> LD [M]  sound/usb/snd-usb-lib.ko
> LD [M]  sound/usb/usx2y/snd-usb-usx2y.ko
> 
> real    18m0.948s
> user    26m6.270s    ------bad
> sys     4m22.256s    ------?bad
> [xxx@localhost linux-2.6.17]$
> --- real-clock time  is ~18 min -- user and system time doubled?

user/sys accounts how much time the individual CPUs spent on your 
job. real counts how far your wall clock advanced.

Think about it. It's not that difficult to understand.

-Andi
