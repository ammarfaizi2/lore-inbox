Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUISUSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUISUSX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUISUSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:18:23 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:4101 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263540AbUISUSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:18:18 -0400
Message-ID: <35fb2e59040919131864c26952@mail.gmail.com>
Date: Sun, 19 Sep 2004 21:18:14 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: linux-kernel@vger.kernel.org
Subject: Re: xilinx_sysace
In-Reply-To: <35fb2e5904090607241087442d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <35fb2e5904090607241087442d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004 15:24:11 +0100, Jon Masters <jonmasters@gmail.com> wrote:

> The driver works fine for me as a read only device but I'm still
> seeing occasional hard locks on writes (looks to be something not
> getting io_request_lock at the right moment - currently
> investigating). They use a kernel thread which just sits and
> compensates for the hardware not being able to signal when it is ready
> for a new request - and I think there's a race there.

It's as I thought on and off and then on again - the code checks out
ok (it's not pretty but it works) - and I seem to be getting unwanted
extra unhandled interrupts from the hardware. This driver needs a lot
of cleanup anyway - it doesn't handle these kinds of error state, nor
does it handle the removal of a mounted CompactFlash, and a dozen
other typical problems. I'll post a patch when I've solved the main
problem - moan at me by private mail if you're using this, having
similar issues, and feel like helping.

Jon.
