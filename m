Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264581AbTKNSzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbTKNSzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:55:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:8579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264581AbTKNSzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:55:12 -0500
Date: Fri, 14 Nov 2003 10:59:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
Message-Id: <20031114105947.641335f5.akpm@osdl.org>
In-Reply-To: <98290000.1068836914@flay>
References: <20031112233002.436f5d0c.akpm@osdl.org>
	<98290000.1068836914@flay>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> 
> 
> > - Several ext2 and ext3 allocator fixes.  These need serious testing on big
> >   SMP.
> 
> OK, ext3 survived a swatting on the 16-way as well>

Great, thanks.

> It's still slow as snot, but it does work ;-)

I think SDET generates storms of metadata updates.  Making the journal
larger may help get that idle time down.

Probably the default journal size is too small nowadays.  Most tests seem
to run faster when it is enlarged.


