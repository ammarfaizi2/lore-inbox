Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbVKQByi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbVKQByi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbVKQByi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:54:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161089AbVKQByh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:54:37 -0500
Date: Wed, 16 Nov 2005 17:54:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ph. Marek" <philipp.marek@bmlv.gv.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optional use "gzip --rsyncable" for bzImage
Message-Id: <20051116175413.208d27db.akpm@osdl.org>
In-Reply-To: <200511161408.49287.philipp.marek@bmlv.gv.at>
References: <200511161408.49287.philipp.marek@bmlv.gv.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ph. Marek" <philipp.marek@bmlv.gv.at> wrote:
>
>  As (at least in debian) gzip has the "--rsyncable" parameter included, 
>  I'd like to suggest this patch to (configurable) use this for bzImage creation.

I'd doubt if this works with a compressed a.out.  Most changes one would
make to a kernel at the source level will cause changes all over the
generated binary, so rsync will send the whole compressed file anyway.

For example, a few-byte change in size of a function will cause a huge
number of `call xxxxxxxx' opcodes to turn into `call xxxxxxxx+N'.

So I'll need some convincing.  But even if convinced, this seems like an
exceedingly obscure thing that not many people would be interested in.

echo `/usr/bin/gzip --rsyncable $*' > ~/bin/gzip ;)
