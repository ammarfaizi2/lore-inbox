Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbTIDPy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTIDPy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:54:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:25068 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265071AbTIDPyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:54:55 -0400
Date: Thu, 4 Sep 2003 08:55:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-Id: <20030904085537.78c251b3.akpm@osdl.org>
In-Reply-To: <3F574A49.7040900@namesys.com>
References: <3F574A49.7040900@namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> Is it correct to say of ext3 that it guarantees and only guarantees 
> atomicity of writes that do not cross page boundaries?

Yes.

>     By contrast, ext3 only guarantees the atomicity of a single write 
> that does not span a page boundary, and it guarantees that its internal 
> metadata will not be corrupted even if your applications data is 
> corrupted after the crash.

Not sure that I understand this.  In data=writeback mode, metadata
integrity is preserved but data writes may be lost.  In data=journal and
data=ordered modes the data and the metadata which refers to it are always
in sync on-disk.

