Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVJCHSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVJCHSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 03:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVJCHSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 03:18:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30164 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932168AbVJCHSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 03:18:21 -0400
Date: Mon, 3 Oct 2005 03:18:13 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Arijit Das <Arijit.Das@synopsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Shared library holes in x86_64
Message-ID: <20051003071813.GI8983@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <7EC22963812B4F40AE780CF2F140AFE916835A@IN01WEMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE916835A@IN01WEMBX1.internal.synopsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 12:00:05PM +0530, Arijit Das wrote:
> If I strace a "/bin/sleep 23" command in a RHAS3.0/x86-AMD64 machine, I
> see that holes are being created in some of the mapped shared libraries
> using the mprotect system call like this:

I explained it 3 days ago, so once again:
x86-64 binaries and shared libraries are required to handle page sizes up
to 1MB and as RE and RW segments can't be on the same page, this means they
must not share the same 1MB page.
Just google for ELF_MAXPAGESIZE or look at the libraries using readelf -Wl.

	Jakub
