Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUFFKNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUFFKNj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUFFKNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 06:13:38 -0400
Received: from ozlabs.org ([203.10.76.45]:23215 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263166AbUFFKNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 06:13:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16578.60999.549131.220484@cargo.ozlabs.ibm.com>
Date: Sun, 6 Jun 2004 20:13:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Spinlock-timeout
In-Reply-To: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jake Moilanen writes:

> Here's a patch that will BUG() when a spinlock is held for longer then X
> seconds.  It is useful for catching deadlocks since not all archs have a
> NMI watchdog.  
[snip]
> +		if (jiffies >= jiffy_timeout) 
> +		        BUG();

Don't you need to use time_after()?

Regards,
Paul.
