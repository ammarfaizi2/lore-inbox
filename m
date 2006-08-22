Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWHVDL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWHVDL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 23:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWHVDL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 23:11:58 -0400
Received: from mother.openwall.net ([195.42.179.200]:28584 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751180AbWHVDL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 23:11:57 -0400
Date: Tue, 22 Aug 2006 07:07:55 +0400
From: Solar Designer <solar@openwall.com>
To: Ernie Petrides <petrides@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: printk()s of user-supplied strings (Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again)
Message-ID: <20060822030755.GB830@openwall.com>
References: <20060821211104.GA7790@1wt.eu> <200608212336.k7LNa1E8008716@pasta.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608212336.k7LNa1E8008716@pasta.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 07:36:01PM -0400, Ernie Petrides wrote:
> -			printk(KERN_ERR "Unable to load interpreter %.128s\n",
> -				elf_interpreter);

I'd rather have this message rate-limited, not dropped completely.

Another long-time concern that I had is that we've got some printk()s
of user-supplied string data.  What about embedded linefeeds - can this
be used to produce fake kernel messages with arbitrary log level (syslog
priority)?  It certainly seems so.

Also, there are terminal controls...

Alexander
