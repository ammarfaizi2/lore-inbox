Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVGaMYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVGaMYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 08:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVGaMYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 08:24:08 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:56268 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261690AbVGaMYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 08:24:07 -0400
Date: Sun, 31 Jul 2005 14:20:34 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: apache <apache@ayni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How come that in kernel 2.6.11 a dvd is readable, but not in kernel 2.6.12?
Message-ID: <20050731122034.GA32232@electric-eye.fr.zoreil.com>
References: <42ECB294.7040608@ayni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ECB294.7040608@ayni.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

apache <apache@ayni.com> :
[...]
> Fact: I can write a DVD on a machine with kernel-2.6.11, but I cannot 
> read that DVD in a machine with kernel-2.6.12, even worse: the system is 
> stuck.
> 
> please explain

I can't explain but we may try to fix it with your help.

As a general remark, dmesg + .config + lspci -vx/lsmod help figuring the
hardware environment.

1 - can the regression be reproduced with last -rc (namely 2.6.13-rc4) ?
2 - if yes, can you isolate a simple operation to trigger the bug: I assume
    you read the DVD from hell with some nice viewer under X. Can you
    reproduce the bug in a simple console, without X, through a 'dd'
    command for instance ?
3 - if so, did you notice extra messages ? Is led activity available ?
4 - if you are still stuck, you can start a binary search on the 2.6.12-rc
    kernels, then on the 2.6.12-rcX-gitY to isolate the trigger (it may not
    necessarily be the culprit).

--
Ueimor
