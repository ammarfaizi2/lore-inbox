Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVBHAZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVBHAZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVBHAZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:25:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:44708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261362AbVBHAZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:25:34 -0500
Date: Mon, 7 Feb 2005 16:30:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: prezeroing V6 [2/3]: ScrubD
Message-Id: <20050207163035.7596e4dd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502071131260.27951@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
	<1106828124.19262.45.camel@hades.cambridge.redhat.com>
	<20050202153256.GA19615@logos.cnet>
	<Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0502071131260.27951@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> called scrubd.

What were the benchmarking results for this work?  I think you had some,
but this is pretty vital info, so it should be retained in the changelogs.

Having one kscrubd per node seems like the right thing to do.

Should we be managing the kernel threads with the kthread() API?
