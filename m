Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVIWAne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVIWAne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 20:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVIWAne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 20:43:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751107AbVIWAnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 20:43:33 -0400
Date: Thu, 22 Sep 2005 17:42:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] Bisecting through -mm with quilt
Message-Id: <20050922174250.71f9c6a9.akpm@osdl.org>
In-Reply-To: <20050923003217.GA18675@mipter.zuzino.mipt.ru>
References: <20050923003217.GA18675@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
>  Quick, Dirty, Fragile, Should Work (TM).

hm, I wouldn't use it.  The problem is that a _lot_ of patches in -mm don't
fscking compile.

	bix:/usr/src/25> grep '[-]fix.patch' series | wc
	     72      72    2905

If your bisection happens to land you between foo.patch and foo-fix.patch,
you have a *known bad* kernel.   What's the point in testing it?

So I'd recommend the smarter approach: copy the series file to ~/hunt, edit
~/hunt and do the bisection by hand, marking the good and bad points in
~/hunt as you go.

