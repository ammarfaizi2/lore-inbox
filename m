Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVHNUjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVHNUjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 16:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVHNUjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 16:39:39 -0400
Received: from siaag2ah.compuserve.com ([149.174.40.141]:53215 "EHLO
	siaag2ah.compuserve.com") by vger.kernel.org with ESMTP
	id S932271AbVHNUjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 16:39:39 -0400
Date: Sun, 14 Aug 2005 16:36:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc6] Fix kmem read on 32-bit archs
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200508141639_MC3-1-A731-592C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 09:24:02 -0700 (PDT), Linus Torvalds wrote:

> Yes, the thing needs to be opened with O_LARGEFILE and you need to use 
> "llseek()" to seek into it, but once you do that, everything should be 
> fine.

  GCC warns about using llseek and suggests lseek64 instead. That works
for me, but up till 2.6.11 plain lseek worked too.  I guess it really
shouldn't have?

__
Chuck
