Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWEGKii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWEGKii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 06:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWEGKii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 06:38:38 -0400
Received: from mail.suse.de ([195.135.220.2]:3975 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932120AbWEGKih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 06:38:37 -0400
To: Joachim Fritschi <jfritschi@freenet.de>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/2]  Twofish cipher x86_64-asm optimized
References: <200605071157.03362.jfritschi@freenet.de>
From: Andi Kleen <ak@suse.de>
Date: 07 May 2006 12:38:30 +0200
In-Reply-To: <200605071157.03362.jfritschi@freenet.de>
Message-ID: <p73odya3ys9.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joachim Fritschi <jfritschi@freenet.de> writes:
> 
> Testing:
> -----------
> The code passed the kernel test module and passed automated tests on a 
> dm-crypt volume reading/writing large files with alternating modules ( c / 
> assembler ) and comparing results. It is also running on my workstation for 
> over a week now.

It would be good if you could run some random input encrypt/decrypt tests 
comparing the C reference version with yours. We have had bad luck 
with assembler functions not quite implementing the same cipher 
in the past.

> 
> Please have a look, try, improve and criticise.

Is it really needed to duplicate all the C code and tables - can't that 
be shared with the portable C code? 

Also don't make it a separate config - it should just be a replacement
on x86-64.

-Andi
