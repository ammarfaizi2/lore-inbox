Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVB1OqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVB1OqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVB1OqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:46:18 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:59147 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261604AbVB1Op4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:45:56 -0500
Date: Mon, 28 Feb 2005 15:45:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: colbuse@ensisun.imag.fr
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [patch 2/2] drivers/chat/vt.c: remove unnecessary code
Message-ID: <20050228144546.GB2753@pclin040.win.tue.nl>
References: <1109595328.422314c031b5f@webmail.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109595328.422314c031b5f@webmail.imag.fr>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: SINECTIS: kweetal.tue.nl 1114; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 01:55:28PM +0100, colbuse@ensisun.imag.fr wrote:

> Avoid changing the state of the console two times in some cases.

A bad change for several reasons.

(i) more object code is generated
(ii) the code is slower
(iii) you change something

Straight line code is cheap, jumps are expensive.
Replacing an assignment by a jump is not an improvement.

But far worse: this is a purposeless microoptimization.
At least one out of every hundred trivial patches is broken.
Thus, a stream of trivial changes will only break the kernel, for no gain.

Andries
