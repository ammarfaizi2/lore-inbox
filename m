Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbUKISj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUKISj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUKISiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:38:04 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:57103 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261616AbUKIShj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:37:39 -0500
Date: Tue, 9 Nov 2004 19:37:29 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Miroslav Zubcic <mvz@nimium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - Nasty Oops in clear_inode or someware ...
Message-ID: <20041109183729.GB3408@pclin040.win.tue.nl>
References: <lz654fkmk3.fsf@devana.home.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lz654fkmk3.fsf@devana.home.int>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 05:35:24PM +0100, Miroslav Zubcic wrote:

> Machine Oopsed today during amanda backup. It became non-responsive,
> ps(1) hangup, ssh(1) from other machine hanged, console login on
> serial port hanged during password check on login. I have rebooted
> machine and examined kernel log.
> 
> Nov  9 12:57:22 mokos kernel: eax: c0379560   ebx: e29de8e4   ecx: c16df200   edx: ffffefff

Could this be a single-bit error, where ffffefff should have been ffffffff?
At first sight ffffefff doesnt make sense, while ffffffff is EXT3_ACL_NOT_CACHED.
