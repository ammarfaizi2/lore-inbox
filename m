Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVI2CFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVI2CFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVI2CFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:05:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:4545 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751310AbVI2CFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:05:13 -0400
Date: Thu, 29 Sep 2005 03:05:10 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: bbpetkov@yahoo.de, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH] remove check_region in drivers-char-specialix.c
Message-ID: <20050929020510.GR7992@ftp.linux.org.uk>
References: <20050928083737.GA29498@gollum.tnic> <20050928175244.GY7992@ftp.linux.org.uk> <20050928222822.GA14949@gollum.tnic> <20050929011026.GO7992@ftp.linux.org.uk> <20050928184106.49e9db11.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928184106.49e9db11.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 06:41:06PM -0700, Andrew Morton wrote:
 
> http://www.spinics.net/lists/kernel/msg399680.html

Ewww...  A lot of chunks consisting only of whitespace removals - great
way to make patch less readable...

And yes, that second call of sx_request_io_range() must die.  BTW,
what's wrong with use of mdelay() instead of that sx_long_delay()
junk?  Replacing both calls of sx_long_delay() with mdelay(50) would do it...
