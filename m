Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVEHQq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVEHQq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 12:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVEHQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 12:46:59 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:1800 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261807AbVEHQq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 12:46:57 -0400
Date: Sun, 8 May 2005 12:42:10 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andi Kleen <ak@muc.de>
Cc: Antoine Martin <antoine@nagafix.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050508164210.GC25130@ccure.user-mode-linux.org>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <m1ekchvmb0.fsf@muc.de> <1115570102.10373.23.camel@cobra> <m1acn5vjdz.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1acn5vjdz.fsf@muc.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 05:15:36PM +0200, Andi Kleen wrote:
> Antoine Martin <antoine@nagafix.co.uk> writes:
> Ok, the bug is found now. It is a kernel bug that it allows to set
> non canonical addresses in 64bit segment registers through ptrace.
> 
> But even if I fixed that then it will not help you run UML, because
> UML needs to set correct addresses of course, not illegal ones.

True, but if the host stays up, and maybe printks something (or even returns
 -EIO), that would help track down the UML problem.

				Jeff
