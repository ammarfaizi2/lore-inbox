Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbUJYXyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUJYXyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUJYWXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:23:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:24235 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261294AbUJYWJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:09:52 -0400
Date: Mon, 25 Oct 2004 15:13:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: javier@marcet.info, linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
Message-Id: <20041025151343.7a501719.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0410251735470.21539-100000@chimarrao.boston.redhat.com>
References: <20041023125948.GC9488@marcet.info>
	<Pine.LNX.4.44.0410251735470.21539-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> -		if (referenced && page_mapping_inuse(page))
> +		if (referenced && sc->priority && page_mapping_inuse(page))

Makes heaps of sense, but I'd like to exactly understand why people are
getting oomings before doing something like this.  I think we're still
waiting for a testcase?
