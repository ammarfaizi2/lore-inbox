Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWJHUYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWJHUYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWJHUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 16:24:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:8910 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751450AbWJHUY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 16:24:27 -0400
Date: Sun, 8 Oct 2006 21:24:24 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matthew Wilcox <willy@parisc-linux.org>
Subject: Re: [PATCH] Consolidate check_signature
Message-ID: <20061008202423.GC29920@ftp.linux.org.uk>
References: <11600679551209-git-send-email-matthew@wil.cx> <11600679552794-git-send-email-matthew@wil.cx> <20061008132147.958dc6a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008132147.958dc6a8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 01:21:47PM -0700, Andrew Morton wrote:
> On Thu, 05 Oct 2006 11:05:55 -0600
> Matthew Wilcox <matthew@wil.cx> wrote:
> 
> > There's nothing arch-specific about check_signature(), so move it to
> > <linux/io.h>.  Use a cross between the Alpha and i386 implementations
> > as the generic one.
> 
> It wuld have been nice to have uninlined it too.  And to have given
> it a less crappy name.

memcmp_withio(), to follow the general style?
