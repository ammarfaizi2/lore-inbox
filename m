Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbTLQVki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 16:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTLQVki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 16:40:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:57496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264557AbTLQVkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 16:40:37 -0500
Date: Wed, 17 Dec 2003 13:41:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roger Luethi <rl@hellgate.ch>
Cc: riel@redhat.com, andrea@suse.de, wli@holomorphy.com, kernel@kolivas.org,
       chris@cvine.freeserve.co.uk, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-Id: <20031217134104.5a477e6e.akpm@osdl.org>
In-Reply-To: <20031217194950.GA9375@k3.hellgate.ch>
References: <20031216112307.GA5041@k3.hellgate.ch>
	<Pine.LNX.4.44.0312171351080.28701-100000@chimarrao.boston.redhat.com>
	<20031217194950.GA9375@k3.hellgate.ch>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi <rl@hellgate.ch> wrote:
>
> FWIW akpm posted a patch to initialize min_free_kbytes depending on
> available RAM which seemed to make sense but it hasn't made it into
> mainline yet.

Yup.  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test11/2.6.0-test11-mm1/broken-out/scale-min_free_kbytes.patch

Also, note that setup_per_zone_pages_min() plays games to ensure that the
highmem zone's free pages limit is small: there's not a lot of point in
keeping lots of highmem pages free.

