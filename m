Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTLQMKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 07:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTLQMKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 07:10:13 -0500
Received: from are.twiddle.net ([64.81.246.98]:41613 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S264389AbTLQMKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 07:10:11 -0500
Date: Wed, 17 Dec 2003 04:10:10 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha (2.6.0-test11)
Message-ID: <20031217121010.GA11062@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031213003841.GA5213@wang-fu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213003841.GA5213@wang-fu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 06:38:41PM -0600, Nathan Poznick wrote:
> I've been unable to use modules on my Alpha with 2.6.0-test*.  modprobe
> (from module-init-tools 0.9.15-pre3) would claim an invalid module
> format, and the kernel would tell me "Unknown relocation: 1"  Relocation
> 1 on Alpha is R_ALPHA_REFLONG, and sure enough, readelf -r on one of the
> modules showed many, many uses of it.

Which module?  This relocation should never EVER show up in kernel code.

(It will show up in dwarf2 debug info, so make sure you're not looking at
objects compiled with -g, but debug sections ought to be ignored by the
module loading code.)


r~
