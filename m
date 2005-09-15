Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbVIOUYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVIOUYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbVIOUYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:24:17 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:17926 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1161012AbVIOUYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:24:16 -0400
Date: Thu, 15 Sep 2005 15:21:11 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       allan.graves@gmail.com
Subject: Re: [PATCH 1/10] UML - _switch_to code consolidation
Message-ID: <20050915192111.GD8106@ccure.user-mode-linux.org>
References: <200509142155.j8ELtm5c012124@ccure.user-mode-linux.org> <20050914223035.455f76b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914223035.455f76b9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 10:30:35PM -0700, Andrew Morton wrote:
> Which if any of these are -rc material?   uml-return-a-real-error-code.patch?

I consider them all to be 2.6.14 material, which is why I sent them.

With the exception of uml-breakpoint-an-arbitrary-thread.patch, which
adds a bit of functionality, they are all bug fixes and code
movement/cleanup.  In order of my preference of reaching mainline:

uml-remove-include-of-asm-elfh.patch
	serious bug - this fixes the x86_64 build

uml-preserve-errno-in-error-paths.patch
	serious bug - if you hit some of these, UML will hang

uml-return-a-real-error-code.patch
	a small bug, almost a cleanup

uml-remove-a-useless-include.patch
uml-remove-an-unused-file.patch
uml-remove-some-build-warnings.patch
	code cleanup

uml-move-libc-code-out-of-mem_userc-and-tempfilec.patch
uml-merge-mem_userc-and-memc.patch
	code movement

uml-_switch_to-code-consolidation.patch
	code cleanup - can be omitted from mainline if
	uml-breakpoint-an-arbitrary-thread.patch is

uml-breakpoint-an-arbitrary-thread.patch
	functionality


				Jeff
