Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbUKKSNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbUKKSNL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbUKKSKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:10:47 -0500
Received: from plam.fujitsu-siemens.com ([217.115.66.9]:16433 "EHLO
	plam.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262327AbUKKSJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:09:56 -0500
Message-ID: <4193AAEE.1000800@fujitsu-siemens.com>
Date: Thu, 11 Nov 2004 19:09:50 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UML - signal bug fix
References: <200411111957.iABJvHPV004137@ccure.user-mode-linux.org>
In-Reply-To: <200411111957.iABJvHPV004137@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> This patch fixes a bug introduced in the last batch of signal fixes.  The
> system call return value should only be reset if called diectly from a system
> call, i.e. sigsuspend.  The fixes added earlier caused any interrupted non-zero
> system call return to be reset, confusing fork and vfork, among others.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
Yes. The patchset was wrong.
But IMHO the solution shouldn't be resetting to the old state, that did syscall
restarting wrong!
The problem, you fix here, doesn't occur, when using my complete patchset. And my
patches fix UML's wrong syscall restart handling. And other issues they fix, too.

Bodo
