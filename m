Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTJMNHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 09:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTJMNHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 09:07:05 -0400
Received: from asplinux.ru ([195.133.213.194]:65285 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261740AbTJMNHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 09:07:02 -0400
From: Kirill Korotaev <kk@sw.ru>
Reply-To: kk@sw.ru
Organization: SWsoft
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Date: Mon, 13 Oct 2003 17:08:02 +0400
User-Agent: KMail/1.5.1
References: <200310131318.09234.kk@sw.ru> <200310131621.33079.kk@sw.ru> <16266.39568.286607.206395@laputa.namesys.com>
In-Reply-To: <16266.39568.286607.206395@laputa.namesys.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310131708.02348.kk@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > no, testcase is not available :( And it uses functionality
>  > not available in mainstream kernel. But the problem can be hit with
>  > very simple script instead:
>  >
>  > 1. mount N filesystems.
>  > 2. work on them, so that inode cache grows to its maximum
>  > possible size (it was 1,000,000 of inodes in our case).
>  > 3. umount these filesystems.
>  >
>  > During operation #3 node is very slow and it is quite noticable
>  > on ssh console when typing commands.
>
> This can be due to a number of reasons (worst case behavior of
> shrink_dcache_parent() for example). What /proc/profile shows?
I used cycles measuring patch. It showed that > 50% CPU during the test
was spent in invalidate_inodes().

Kirill

