Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWCGV1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWCGV1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWCGV1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:27:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932316AbWCGV1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:27:53 -0500
Date: Tue, 7 Mar 2006 13:25:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dean Roe <roe@sgi.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: [PATCH] Prevent NULL pointer deref in grab_swap_token
Message-Id: <20060307132545.2503721e.akpm@osdl.org>
In-Reply-To: <20060307211344.GA2946@sgi.com>
References: <20060307211344.GA2946@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean Roe <roe@sgi.com> wrote:
>
> grab_swap_token() assumes that the current process has an mm struct,
> which is not true for kernel threads invoking get_user_pages().  Since
> this should be extremely rare, just return from grab_swap_token()
> without doing anything.
> 

Fair enough.

Which kernel threads are running get_user_pages()?

