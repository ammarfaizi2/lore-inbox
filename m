Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWDKCor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWDKCor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 22:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWDKCor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 22:44:47 -0400
Received: from colin.muc.de ([193.149.48.1]:17931 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932263AbWDKCor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 22:44:47 -0400
Date: 11 Apr 2006 04:44:39 +0200
Date: Tue, 11 Apr 2006 04:44:39 +0200
From: Andi Kleen <ak@muc.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W.Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kdump: x86_64 add crashdump trigger points
Message-ID: <20060411024439.GB52164@muc.de>
References: <20060410220511.GB24711@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410220511.GB24711@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 06:05:11PM -0400, Vivek Goyal wrote:
> 
> 
> o Start booting into the capture kernel after an Oops if system is in a
>   unrecoverable state. System will boot into the capture kernel, if one is
>   pre-loaded by the user, and capture the kernel core dump.
> 
> o One of the following conditions should be true to trigger the booting of
>   capture kernel.
> 	- panic_on_oops is set.
> 	- pid of current thread is 0
> 	- pid of current thread is 1
> 	- Oops happened inside interrupt context.  

I would rather put it into die(). Then the patch will be much smaller
too.

-Andi
