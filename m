Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVKEOvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVKEOvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 09:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVKEOvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 09:51:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:7860 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932069AbVKEOvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 09:51:36 -0500
Date: Sat, 5 Nov 2005 14:51:34 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Ian Campbell <icampbell@arcom.com>, Wim Van Sebroeck <wim@iguana.be>,
       linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] sa1100_wdt.c sparse cleanups
Message-ID: <20051105145134.GL7992@ftp.linux.org.uk>
References: <1130921809.12578.179.camel@icampbell-debian> <20051105101026.GA28438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105101026.GA28438@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 10:10:27AM +0000, Russell King wrote:
> It's probably better to use a union with these, eg:
> 
> 	union {
> 		void __user *arg;
> 		struct watchdog_info __user *info;
> 		int __user *i;
> 	} u;
> 
> 	u.arg = (void __user *)arg;
> 
> ...
> 
> 	ret = copy_to_user(u.info, &ident, sizeof(ident)) ? -EFAULT : 0;

Just use void __user *.
