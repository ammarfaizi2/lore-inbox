Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266379AbUHBJgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUHBJgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 05:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266381AbUHBJgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 05:36:21 -0400
Received: from main.gmane.org ([80.91.224.249]:6568 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266379AbUHBJgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 05:36:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Oops in register_chrdev, what did I do?
Date: Mon, 02 Aug 2004 11:36:15 +0200
Message-ID: <yw1xllgxg9v4.fsf@kth.se>
References: <yw1xwu0i1vcp.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:rsXj2RQhbb7rG033XHgdpGyEjK8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård <mru@kth.se> writes:

> While experimenting a bit with a small kernel module, I got this
> oops.  Digging further, I found that /proc/devices had an entry saying
>
> 248 <NULL>
>
> which would indicate that I passed a NULL name to register_chrdev(),
> only I didn't.  I used a string constant, so I can't see what changed
> it to NULL along the way.
>
> What am I missing here?

There was some confusion with compiler versions and flags, most
notably -mregparm.  Fixed now.  Sorry for the noise.

OTOH, wouldn't it be a good idea to refuse loading modules not
matching the running kernel?

-- 
Måns Rullgård
mru@kth.se

