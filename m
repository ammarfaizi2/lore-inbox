Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTJBWgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTJBWgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:36:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:32135 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263526AbTJBWgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:36:22 -0400
Date: Thu, 2 Oct 2003 23:35:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Message-ID: <20031002223550.GB13853@mail.shareable.org>
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org> <3F7B9CF9.4040706@redhat.com> <blgol5$vd0$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blgol5$vd0$1@news.cistron.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> How about use /proc/self/task/self/fd/%d if /proc/self/task/self
> exists, /proc/self/fd/%d otherwise ?

/dev/stdin is a symbolic link to /proc/self/fd/0.

open("/dev/stdin", O_RDONLY) should always work, if descriptor 0 is readable.

Maybe you're saying /dev/stdin should be changed to link to
/proc/self/task/self/fd/0?

-- Jamie
