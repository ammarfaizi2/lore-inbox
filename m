Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbWBYElN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbWBYElN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWBYElN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:41:13 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32952 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932669AbWBYElM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:41:12 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86: clean up early_printk output
Date: Sat, 25 Feb 2006 05:29:10 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200602241909_MC3-1-B93E-25B@compuserve.com>
In-Reply-To: <200602241909_MC3-1-B93E-25B@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602250529.11099.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 01:07, Chuck Ebbert wrote:
> early_printk() starts output on the second screen line and doesn't
> clear the rest of the line when it hits a newline char.  When there
> is already a BIOS message there, it becomes hard to read.  Change
> this so it starts on the first line and clears to EOL upon hitting
> newline.

early_printk is designed to do absolutely minimal work to get the 
message out. Your patch adds too much potential disturbance 
imho.

-Andi
