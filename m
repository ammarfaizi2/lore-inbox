Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbUK3VDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbUK3VDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUK3VDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:03:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:29349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262327AbUK3VDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:03:31 -0500
Date: Tue, 30 Nov 2004 13:03:20 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?S=F8ren_N=F8hr_Christensen?= <snc@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org, umbrella@cs.aau.dk
Subject: Re: Syscall trouble
Message-ID: <20041130130320.J14339@build.pdx.osdl.net>
References: <200411301455.19143.snc@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200411301455.19143.snc@cs.aau.dk>; from snc@cs.aau.dk on Tue, Nov 30, 2004 at 02:55:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Søren Nøhr Christensen (snc@cs.aau.dk) wrote:
<snip>
> +#define __NR_umb_set_child_restrictions       284
<snip>

> Any suggestions?

Don't do it this way.  Use /proc/<pid>/attr/ interface if you only want
to handle creating restrictions within a process.  If you're using it to
load your policy, then create a reasonable filesystem interface and do
it that way.  This will be portable across versions and architectures
without allocating any syscalls.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
