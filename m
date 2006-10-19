Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423268AbWJSLKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423268AbWJSLKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423274AbWJSLKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:10:38 -0400
Received: from [195.171.73.133] ([195.171.73.133]:38326 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S1423268AbWJSLKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:10:38 -0400
Date: Thu, 19 Oct 2006 11:10:37 +0000
From: andrew@walrond.org
To: linux-kernel@vger.kernel.org, David <dwmw2@infradead.org>
Subject: Re: make headers_install headers problem on sparc64
Message-ID: <20061019111037.GD17882@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, David <dwmw2@infradead.org>
References: <20061018223713.GD9350@pelagius.h-e-r-e-s-y.com> <20061019105441.GC17882@pelagius.h-e-r-e-s-y.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019105441.GC17882@pelagius.h-e-r-e-s-y.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 10:54:41AM +0000, andrew@walrond.org wrote:
> 
> Another problem; when compiling reiserfsprogs 3.6.19 there is a header
> missing:
> 
> ../include/reiserfs_fs.h:41:27: error: asm/unaligned.h: No such file
> or directory
> 
> 
> I see this file exists in the kernel sources, but not in the exported
> headers.
> 

Simply copying asm-generic/unaligned.h into the sanitised header tree
under asm/ solves the problem, so should headers_install just include
unaligned.h ?

> Andrew

PS Great job BTW; I have encountered amazingly few problems using the
sanitised headers created with headers_install.
