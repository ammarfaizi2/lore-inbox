Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSHTSdb>; Tue, 20 Aug 2002 14:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHTSda>; Tue, 20 Aug 2002 14:33:30 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:19471 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S317101AbSHTSda>; Tue, 20 Aug 2002 14:33:30 -0400
Message-ID: <3D628BF5.26FBE772@zip.com.au>
Date: Tue, 20 Aug 2002 11:35:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Alanen <maalanen@ra.abo.fi>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch, 2.5] vmalloc.c error path fixes
References: <Pine.LNX.4.44.0208202022100.16857-100000@tuxedo.abo.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Alanen wrote:
> 
> I think there are some problems in vmalloc.c.  The two first parts
> of the diff fix a spinlock being held if an error occurs in
> map_vm_area, and the last part fixes the error path of __vmalloc.

Certainly agree on the first chunk.  Listen to the old guy: "Thou
shalt not have more than one return statement per function".

Second chunk looks good too, but perhaps there's another way of doing
it.  The 2.5.31 code just tossed it all at vfree.  Perhaps hch can
comment?
