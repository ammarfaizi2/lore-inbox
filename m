Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUF3T7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUF3T7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUF3T6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:58:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:33961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262062AbUF3T6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:58:21 -0400
Date: Wed, 30 Jun 2004 12:57:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] intrinsic automount and mountpoint degradation support
Message-Id: <20040630125713.36004088.akpm@osdl.org>
In-Reply-To: <31080.1088624498@redhat.com>
References: <31080.1088624498@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Here's a patch that I worked out with Al Viro that adds support for a
>  filesystem (such as kAFS) to perform automounting intrinsically without the
>  need for a userspace daemon. It also adds support for such mountpoints to be
>  degraded at the filesystem's behest until they've been untouched long enough
>  that they'll be removed.

Please don't try to add uncommented code to the kernel.

How does this work?

Why is autofs unsuitable?

Apart from documenting the major functions and data structures, comments
are also needed which describe the interpretation of ->mnt_count.  This:

+		if (atomic_read(&mnt->mnt_count) == 2) {

is otherwise incomprehensible.

Apart from making the code maintainable, tasteful commentary and covering
documentation makes the patch review process much more fruitful.  Please
have a think about that, and resend?

Thanks.
