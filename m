Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbUKFJRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbUKFJRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 04:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUKFJRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 04:17:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:58586 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261343AbUKFJRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 04:17:38 -0500
Date: Sat, 6 Nov 2004 10:12:40 +0100
From: Andi Kleen <ak@suse.de>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       ak@suse.de, Andrew Morton <akpm@osdl.org>, arjanv@redhat.com
Subject: Re: breakage: flex mmap patch for x86-64
Message-ID: <20041106091240.GA4996@wotan.suse.de>
References: <200411060026.48571.rjw@sisk.pl> <Pine.GSO.4.33.0411060252370.9358-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0411060252370.9358-100000@sweetums.bluetronic.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline int mmap_is_legacy(void)
>  {
> +       if (test_thread_flag(TIF_IA32))
> +               return 1;

That's definitely not the right fix because for 32bit you need flexmmap
more than for 64bit because it gives you more address space.

-Andi

