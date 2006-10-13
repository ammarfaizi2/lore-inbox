Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWJMJv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWJMJv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 05:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWJMJv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 05:51:59 -0400
Received: from bender.bawue.de ([193.7.176.20]:9658 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1750972AbWJMJv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 05:51:58 -0400
Date: Fri, 13 Oct 2006 10:52:06 +0100
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: SYS_personality does not work correctly on mips(el)64
Message-ID: <20061013095206.GA4027@networkno.de>
References: <452EB653.7070604@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452EB653.7070604@aurel32.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Thiemo Seufer <ths@networkno.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Jarno wrote:
> Hi all,
> 
> On mips(el), when doing multiple call to the syscall SYS_personality in 
> order to get the current personality (using 0xffffffff for the first 
> argument), on a 64-bit kernel, the second and subsequent syscalls are 
> failing. That works correctly with a 32-bit kernels and on other 
> architectures.

That's caused by mis-handling broken sign extensions, see also
http://bugs.debian.org/380531.


Thiemo
